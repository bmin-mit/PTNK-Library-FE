<script setup lang="ts">
import { definePageMeta, useHead } from '#imports'
import { BookTable } from '~/components/BookTable'
import { CreateBookDialog } from '~/components/CreateBookDialog'

useHead({
  title: 'PTNK Library - Books',
})

definePageMeta({
  middleware: 'require-auth',
})
</script>

<template>
  <div>
    <div class="max-w-screen-lg mx-auto py-16 px-8 gap-8 min-h-screen">
      <BookTable />
    </div>

    <CreateBookDialog />
  </div>
</template>
