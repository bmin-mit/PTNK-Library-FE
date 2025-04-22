<script setup lang="ts">
import type { AxiosError } from 'axios'
import { callOnce } from '#app'
import { ArrowRight, Check, CornerDownLeft, X } from 'lucide-vue-next'
import { ref } from 'vue'
import { toast } from 'vue-sonner'
import { BookDialog } from '~/components/BookDialog'
import { Button } from '~/components/ui/button'
import { Table, TableBody, TableCaption, TableCell, TableHead, TableHeader, TableRow } from '~/components/ui/table'
import { H1 } from '~/components/ui/typography'
import { useLendingRequestsStore } from '~/store/lending-requests'
import { useUser } from '~/store/user'
import { FetchStatus } from '~/types/fetch-status.enum'
import { LendingStatus } from '~/types/lending-status.enum'
import { UserRole } from '~/types/user-role.enum'

const lendingRequestsStore = useLendingRequestsStore()
const user = useUser().user

await callOnce(lendingRequestsStore.fetchLendingRequests, { mode: 'navigation' })

const isSubmitting = ref(false)

async function handleRequestAction(requestId: number, action: LendingStatus) {
  isSubmitting.value = true

  try {
    switch (action) {
      case LendingStatus.APPROVED:
        await lendingRequestsStore.approveLendingRequest(requestId)
        toast.success('Request approved successfully')
        break
      case LendingStatus.REJECTED:
        await lendingRequestsStore.rejectLendingRequest(requestId)
        toast.success('Request rejected successfully')
        break
      case LendingStatus.RETURNED:
        await lendingRequestsStore.returnLendingRequest(requestId)
        toast.success('Book returned successfully')
        break
    }
  }
  catch (e) {
    console.log(e)
    toast.error(`Failed to update request: ${((e as AxiosError).response?.data as { message: string })?.message}`)
  }
  finally {
    isSubmitting.value = false
  }
}
</script>

<template>
  <div>
    <H1 class="mb-2">
      Lending requests
    </H1>
    <NuxtLink to="/books" class="text-muted-foreground pb-8 underline flex items-center">
      To books <ArrowRight :size="16" class="ms-1" />
    </NuxtLink>

    <Table>
      <TableCaption v-if="lendingRequestsStore.status === FetchStatus.FAILED">
        Failed to fetch requests
      </TableCaption>

      <TableHeader>
        <TableRow>
          <TableHead />
          <TableHead>Book</TableHead>
          <TableHead v-if="user?.role === UserRole.ADMIN">
            Borrower
          </TableHead>
          <TableHead>Quantity</TableHead>
          <TableHead>Return date</TableHead>
          <TableHead>Status</TableHead>
        </TableRow>
      </TableHeader>

      <TableBody>
        <TableRow v-for="(request, index) in lendingRequestsStore.lendingRequests" :key="request.id">
          <TableCell class="text-center text-muted-foreground">
            {{ index + 1 }}
          </TableCell>

          <TableCell>
            <BookDialog :book="request.book" disable-lending>
              <p class="underline">
                {{ request.book.name }}
              </p>
            </BookDialog>
          </TableCell>

          <TableCell v-if="user?.role === UserRole.ADMIN">
            {{ request.user.name }}
          </TableCell>

          <TableCell>
            {{ request.quantity }}
          </TableCell>

          <TableCell>
            {{ new Date(request.returnDate).toLocaleDateString() }}
          </TableCell>

          <TableCell>
            {{ request.status.toUpperCase() }}
          </TableCell>

          <TableCell v-if="user?.role === UserRole.ADMIN" class="flex gap-1 justify-end">
            <Button
              size="sm"
              variant="destructive"
              :disabled="request.status !== LendingStatus.REQUESTED || isSubmitting"
              @click="handleRequestAction(request.id, LendingStatus.REJECTED)"
            >
              <X />
            </Button>

            <Button
              size="sm"
              :disabled="request.status !== LendingStatus.REQUESTED || isSubmitting"
              @click="handleRequestAction(request.id, LendingStatus.APPROVED)"
            >
              <Check />
            </Button>

            <Button
              size="sm"
              variant="secondary"
              :disabled="request.status !== LendingStatus.APPROVED || isSubmitting"
              @click="handleRequestAction(request.id, LendingStatus.RETURNED)"
            >
              <CornerDownLeft />
            </Button>
          </TableCell>
        </TableRow>
      </TableBody>
    </Table>
  </div>
</template>
