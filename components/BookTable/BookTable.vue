<script setup lang="ts">
import { callOnce } from '#app'
import { ArrowRight, Trash } from 'lucide-vue-next'
import { toast } from 'vue-sonner'
import { Button } from '~/components/ui/button'
import { Table, TableBody, TableCaption, TableCell, TableHead, TableHeader, TableRow } from '~/components/ui/table'
import { Tooltip, TooltipContent, TooltipProvider, TooltipTrigger } from '~/components/ui/tooltip'
import { H1 } from '~/components/ui/typography'
import { useBookStore } from '~/store/book'
import { useUser } from '~/store/user'
import { FetchStatus } from '~/types/fetch-status.enum'
import { UserRole } from '~/types/user-role.enum'

const bookStore = useBookStore()

const user = useUser().user

await callOnce(bookStore.fetchBooks, { mode: 'navigation' })

function handleBookDelete(bookId: number) {
  bookStore.deleteBook(bookId)
    .then(() => {
      toast.success('Book deleted successfully')
      bookStore.fetchBooks()
    })
    .catch((error) => {
      toast.error(`Failed to delete book: ${error.message}`)
    })
}
</script>

<template>
  <div class="flex flex-col">
    <H1 class="mb-2">
      Books
    </H1>
    <NuxtLink to="/lending-requests" class="text-muted-foreground pb-8 underline flex items-center">
      To lending requests <ArrowRight :size="16" class="ms-1" />
    </NuxtLink>

    <Table>
      <TableCaption v-if="bookStore.status === FetchStatus.FAILED">
        Failed to fetch books
      </TableCaption>

      <TableCaption v-if="bookStore.books.length === 0">
        No books available
      </TableCaption>

      <TableHeader>
        <TableRow>
          <TableHead />
          <TableHead>Name</TableHead>
          <TableHead>Quantity</TableHead>
          <TableHead>Stock</TableHead>
          <TableHead>Position</TableHead>
          <TableHead v-if="user?.role === UserRole.ADMIN" />
        </TableRow>
      </TableHeader>

      <TableBody>
        <TooltipProvider v-for="(book, index) in bookStore.books" :key="book.id">
          <Tooltip>
            <TooltipTrigger as-child>
              <TableRow>
                <TableCell class="text-center text-muted-foreground">
                  {{ index + 1 }}
                </TableCell>
                <TableCell>
                  <BookDialog :book="book">
                    <p class="underline">
                      {{ book.name }}
                    </p>
                  </BookDialog>
                </TableCell>
                <TableCell>{{ book.quantity }}</TableCell>
                <TableCell>{{ book.stock }}</TableCell>
                <TableCell>{{ book.position }}</TableCell>
                <TableCell v-if="user?.role === UserRole.ADMIN" class="text-end">
                  <Button size="icon" class="w-8 h-8 self-end" @click="handleBookDelete(book.id)">
                    <Trash />
                  </Button>
                </TableCell>
              </TableRow>
            </TooltipTrigger>

            <TooltipContent>
              <p class="text-sm text-muted-foreground">
                {{ book.name }}
              </p>
            </TooltipContent>
          </Tooltip>
        </TooltipProvider>
      </TableBody>
    </Table>
  </div>
</template>
