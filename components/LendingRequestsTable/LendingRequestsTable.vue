<script setup lang="ts">
import { callOnce } from '#app'
import { ArrowRight } from 'lucide-vue-next'
import { Table, TableCaption, TableHead, TableHeader, TableRow } from '~/components/ui/table'
import { H1 } from '~/components/ui/typography'
import { useLendingRequestsStore } from '~/store/lending-requests'
import { FetchStatus } from '~/types/fetch-status.enum'

const lendingRequestsStore = useLendingRequestsStore()

await callOnce(lendingRequestsStore.fetchLendingRequests)
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
          <TableHead>Borrower</TableHead>
          <TableHead>Quantity</TableHead>
          <TableHead>Request date</TableHead>
        </TableRow>
      </TableHeader>
    </Table>
  </div>
</template>
