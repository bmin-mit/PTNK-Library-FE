<script setup lang="ts">
import type { Book } from '~/types/book.entity'
import { toTypedSchema } from '@vee-validate/zod'
import { useForm } from 'vee-validate'
import { toast } from 'vue-sonner'
import * as z from 'zod'
import { Button } from '~/components/ui/button'
import { FormControl, FormField, FormItem, FormLabel, FormMessage } from '~/components/ui/form'
import { Input } from '~/components/ui/input'
import { useBookStore } from '~/store/book'

const formSchema = toTypedSchema(z.object({
  name: z.string().min(2, 'Name must be more than 2 characters').max(1000, 'Name is too long'),
  author: z.string().optional(),
  quantity: z.number().gt(0),
  stock: z.number().gt(0).optional(),
  position: z.string().optional(),
  publisher: z.string().optional(),
  publishYear: z.number().optional(),
  isbn: z.string().optional(),
  language: z.string().optional(),
}))

const { isSubmitting, handleSubmit } = useForm({
  validationSchema: formSchema,
  validateOnMount: false,
})

const bookStore = useBookStore()

const onSubmit = handleSubmit((values) => {
  bookStore.createBook(values as Omit<Book, 'id'>)
    .then(() => {
      toast.success('Book created successfully')
      bookStore.fetchBooks()
    })
    .catch((error) => {
      toast.error(`Failed to create book: ${error.message}`)
    })
})
</script>

<template>
  <form class="space-y-4" @submit="onSubmit">
    <FormField v-slot="{ componentField }" name="name">
      <FormItem>
        <FormLabel>Name</FormLabel>
        <FormControl>
          <Input :disabled="isSubmitting" type="text" placeholder="Name" v-bind="componentField" />
        </FormControl>
        <FormMessage />
      </FormItem>
    </FormField>

    <FormField v-slot="{ componentField }" name="author">
      <FormItem>
        <FormLabel>Author</FormLabel>
        <FormControl>
          <Input :disabled="isSubmitting" type="text" placeholder="Author" v-bind="componentField" />
        </FormControl>
        <FormMessage />
      </FormItem>
    </FormField>

    <FormField v-slot="{ componentField }" name="quantity">
      <FormItem>
        <FormLabel>Quantity</FormLabel>
        <FormControl>
          <Input :disabled="isSubmitting" type="number" placeholder="Quantity" v-bind="componentField" />
        </FormControl>
        <FormMessage />
      </FormItem>
    </FormField>

    <FormField v-slot="{ componentField }" name="stock">
      <FormItem>
        <FormLabel>Stock</FormLabel>
        <FormControl>
          <Input :disabled="isSubmitting" type="number" placeholder="Stock" v-bind="componentField" />
        </FormControl>
        <FormMessage />
      </FormItem>
    </FormField>

    <FormField v-slot="{ componentField }" name="position">
      <FormItem>
        <FormLabel>Position</FormLabel>
        <FormControl>
          <Input :disabled="isSubmitting" type="text" placeholder="Position" v-bind="componentField" />
        </FormControl>
        <FormMessage />
      </FormItem>
    </FormField>

    <FormField v-slot="{ componentField }" name="publisher">
      <FormItem>
        <FormLabel>Publisher</FormLabel>
        <FormControl>
          <Input :disabled="isSubmitting" type="text" placeholder="Publisher" v-bind="componentField" />
        </FormControl>
        <FormMessage />
      </FormItem>
    </FormField>

    <FormField v-slot="{ componentField }" name="publishYear">
      <FormItem>
        <FormLabel>Publish Year</FormLabel>
        <FormControl>
          <Input :disabled="isSubmitting" type="number" placeholder="Publish Year" v-bind="componentField" />
        </FormControl>
        <FormMessage />
      </FormItem>
    </FormField>

    <FormField v-slot="{ componentField }" name="isbn">
      <FormItem>
        <FormLabel>ISBN</FormLabel>
        <FormControl>
          <Input :disabled="isSubmitting" type="text" placeholder="ISBN" v-bind="componentField" />
        </FormControl>
        <FormMessage />
      </FormItem>
    </FormField>

    <FormField v-slot="{ componentField }" name="language">
      <FormItem>
        <FormLabel>Language</FormLabel>
        <FormControl>
          <Input :disabled="isSubmitting" type="text" placeholder="Language" v-bind="componentField" />
        </FormControl>
        <FormMessage />
      </FormItem>
    </FormField>

    <Button class="w-full" :disabled="isSubmitting">
      Create
    </Button>
  </form>
</template>
