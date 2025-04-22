<script setup lang="ts">
import { useHead } from '#imports'

useHead({
  title: 'PTNK Library - Lending requests',
})
</script>

<template>
  <div>
    <div class="max-w-screen-lg mx-auto py-16 px-8 gap-8 min-h-screen">
      <LendingRequestsTable />
    </div>
  </div>
</template>
