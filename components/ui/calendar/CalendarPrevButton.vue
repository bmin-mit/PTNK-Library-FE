<script lang="ts" setup>
import type { CalendarPrevProps } from 'reka-ui'
import type { HTMLAttributes } from 'vue'
import { buttonVariants } from '@/components/ui/button'
import { cn } from '@/lib/utils'
import { ChevronLeft } from 'lucide-vue-next'
import { CalendarPrev, useForwardProps } from 'reka-ui'
import { computed } from 'vue'

const props = defineProps<CalendarPrevProps & { class?: HTMLAttributes['class'] }>()

const delegatedProps = computed(() => {
  const { class: _, ...delegated } = props

  return delegated
})

const forwardedProps = useForwardProps(delegatedProps)
</script>

<template>
  <CalendarPrev
    data-slot="calendar-prev-button"
    :class="cn(
      buttonVariants({ variant: 'outline' }),
      'absolute left-1',
      'size-7 bg-transparent p-0 opacity-50 hover:opacity-100',
      props.class,
    )"
    v-bind="forwardedProps"
  >
    <slot>
      <ChevronLeft class="size-4" />
    </slot>
  </CalendarPrev>
</template>
