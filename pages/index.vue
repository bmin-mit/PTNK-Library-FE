<script setup lang="ts">
import { Button } from '@/components/ui/button'
import { H1, H3 } from '@/components/ui/typography'
import { ArrowRight } from 'lucide-vue-next'
</script>

<template>
  <div class="flex min-h-screen flex-col items-center justify-center gap-4 p-4 text-center">
    <NuxtImg src="/logo.svg" class="size-24 mb-4" />

    <H1 class="text-primary font-mono">
      PTNK Library
    </H1>
    <H3>A simple, sleek and reliable library management service</H3>

    <Button size="lg" class="mt-2 shadow-xl" as-child>
      <NuxtLink to="/register">
        Getting started <ArrowRight />
      </NuxtLink>
    </Button>
  </div>
</template>
