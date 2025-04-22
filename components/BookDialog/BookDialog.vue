<script setup lang="ts">
import type { Book } from '~/types/book.entity'
import { Dialog, DialogHeader, DialogScrollContent, DialogTitle, DialogTrigger } from '~/components/ui/dialog'
import { Separator } from '~/components/ui/separator'
import { useUser } from '~/store/user'
import { UserRole } from '~/types/user-role.enum'
import LendingRequestForm from './LendingRequestForm.vue'

defineProps<{ book: Book }>()

const user = useUser().user
</script>

<template>
  <Dialog>
    <DialogTrigger>
      <slot />
    </DialogTrigger>

    <DialogScrollContent>
      <DialogHeader>
        <DialogTitle>{{ book.name }}</DialogTitle>
        <p class="text-muted-foreground text-sm">
          Authors: Book authors
        </p>
      </DialogHeader>

      <div class="grid grid-cols-[auto_auto_1fr] gap-6">
        <div class="flex flex-col gap-4">
          <div>
            <p>Quantity</p>
            <p class="text-sm text-muted-foreground">
              {{ book.quantity }}
            </p>
          </div>

          <div>
            <p>Stock</p>
            <p class="text-sm text-muted-foreground">
              {{ book.stock }}
            </p>
          </div>

          <div>
            <p>Position</p>
            <p class="text-sm text-muted-foreground">
              {{ book.position ?? 'Unknown' }}
            </p>
          </div>

          <div>
            <p>ISBN</p>
            <p class="text-sm text-muted-foreground">
              {{ book.isbn ?? 'Unknown' }}
            </p>
          </div>

          <div>
            <p>Publisher</p>
            <p class="text-sm text-muted-foreground">
              {{ book.publisher ?? 'Unknown' }}
            </p>
          </div>

          <div>
            <p>Publish year</p>
            <p class="text-sm text-muted-foreground">
              {{ book.publishYear ?? 'Unknown' }}
            </p>
          </div>

          <div>
            <p>Language</p>
            <p class="text-sm text-muted-foreground">
              {{ book.language ?? 'Unknown' }}
            </p>
          </div>
        </div>

        <Separator v-if="user?.role === UserRole.USER" orientation="vertical" />

        <div v-if="user?.role === UserRole.USER">
          <p class="mb-4">
            Request lending
          </p>
          <LendingRequestForm :book="book" />
        </div>
      </div>
    </DialogScrollContent>
  </Dialog>
</template>
