<script setup lang="ts">
import { definePageMeta } from '#imports'
import { Toaster } from '@/components/ui/sonner'

definePageMeta({
  colorMode: 'system',
})
</script>

<template>
  <NuxtLayout>
    <NuxtPage />
  </NuxtLayout>

  <ClientOnly>
    <Toaster />
  </ClientOnly>
</template>
