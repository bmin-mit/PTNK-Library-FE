<script setup lang="ts">
import { LendingRequestDialog } from '@/components/LendingRequestDialog'
import { H1 } from '~/components/ui/typography'
</script>

<template>
  <div>
    <div class="max-w-screen-lg mx-auto">
      <H1 class="mt-8">
        Books
      </H1>
    </div>

    <LendingRequestDialog class="fixed bottom-4 right-4 md:bottom-8 md:right-8" />
  </div>
</template>
