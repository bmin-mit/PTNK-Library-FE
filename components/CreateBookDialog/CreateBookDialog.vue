<script setup lang="ts">
import { Plus } from 'lucide-vue-next'
import CreateBookForm from '~/components/CreateBookDialog/CreateBookForm.vue'

import { Button } from '~/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '~/components/ui/dialog'
import { useUser } from '~/store/user'
import { UserRole } from '~/types/user-role.enum'

const user = useUser().user
</script>

<template>
  <Dialog v-if="user?.role === UserRole.ADMIN">
    <DialogTrigger as-child>
      <Button class="fixed bottom-4 right-4 md:bottom-8 md:right-8">
        <Plus /> Create book
      </Button>
    </DialogTrigger>

    <DialogContent>
      <DialogHeader>
        <DialogTitle>Create a book</DialogTitle>
      </DialogHeader>

      <CreateBookForm />
    </DialogContent>
  </Dialog>
</template>
