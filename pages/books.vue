<script setup lang="ts">
import { callOnce } from '#app'
import { definePageMeta } from '#imports'
import { CreateBookDialog } from '~/components/CreateBookDialog'
import { Table, TableBody, TableCaption, TableCell, TableHead, TableHeader, TableRow } from '~/components/ui/table'
import { Tooltip, TooltipContent, TooltipProvider, TooltipTrigger } from '~/components/ui/tooltip'
import { H1 } from '~/components/ui/typography'
import { useBookStore } from '~/store/book'
import { FetchStatus } from '~/types/fetch-status.enum'

definePageMeta({
  middleware: 'require-auth',
})

const bookStore = useBookStore()

await callOnce(bookStore.fetchBooks, { mode: 'navigation' })
</script>

<template>
  <div>
    <div class="max-w-screen-lg mx-auto my-16 px-8">
      <H1 class="mb-8">
        Books
      </H1>

      <Table>
        <TableCaption v-if="bookStore.status === FetchStatus.FAILED">
          Failed to fetch books
        </TableCaption>

        <TableHeader>
          <TableRow>
            <TableHead />
            <TableHead>Name</TableHead>
            <TableHead>Quantity</TableHead>
            <TableHead>Stock</TableHead>
            <TableHead>Position</TableHead>
          </TableRow>
        </TableHeader>

        <TableBody>
          <TooltipProvider v-for="(book, index) in bookStore.books" :key="book.id">
            <Tooltip>
              <BookDialog :book="book">
                <TooltipTrigger as-child>
                  <TableRow>
                    <TableCell class="text-center text-muted-foreground">
                      {{ index + 1 }}
                    </TableCell>
                    <TableCell>{{ book.name }}</TableCell>
                    <TableCell>{{ book.quantity }}</TableCell>
                    <TableCell>{{ book.stock }}</TableCell>
                    <TableCell>{{ book.position }}</TableCell>
                  </TableRow>
                </TooltipTrigger>
              </BookDialog>

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

    <CreateBookDialog />
  </div>
</template>
