<script setup lang="ts">
import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { Plus } from 'lucide-vue-next'
import LendingRequestForm from './LendingRequestForm.vue'

const props = defineProps<{ class?: string }>()
</script>

<template>
  <Dialog>
    <DialogTrigger>
      <Button :class="props.class" size="lg">
        <Plus /> Lending request
      </Button>
    </DialogTrigger>

    <DialogContent>
      <DialogHeader>
        <DialogTitle>Request to lend a book</DialogTitle>
      </DialogHeader>

      <LendingRequestForm />
    </DialogContent>
  </Dialog>
</template>
