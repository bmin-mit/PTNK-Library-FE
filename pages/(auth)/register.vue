<script setup lang="ts">
import type { DateValue } from '@internationalized/date'
import { definePageMeta } from '#imports'
import { Button } from '@/components/ui/button'
import { Calendar } from '@/components/ui/calendar'
import { Card, CardContent } from '@/components/ui/card'
import { FormControl, FormField, FormItem, FormLabel, FormMessage } from '@/components/ui/form'
import { Input } from '@/components/ui/input'
import { Popover, PopoverContent, PopoverTrigger } from '@/components/ui/popover'
import { H3 } from '@/components/ui/typography'
import { cn } from '@/lib/utils'

import { CalendarDate, DateFormatter, getLocalTimeZone, parseDate, today } from '@internationalized/date'
import { toTypedSchema } from '@vee-validate/zod'
import { CalendarIcon, Eye, EyeOff } from 'lucide-vue-next'
import { toDate } from 'reka-ui/date'
import { useField, useForm } from 'vee-validate'
import { computed, ref } from 'vue'
import * as z from 'zod'

definePageMeta({
  layout: 'auth',
})

const formSchema = toTypedSchema(z.object({
  email: z.string().email('Invalid email address'),
  name: z.string().min(2, 'Name must be more than 2 characters').max(1000, 'Name is too long'),
  dateOfBirth: z.string().date('Empty date of birth'),
  password: z.string().min(8, 'Password must be at least 8 characters'),
  confirmPassword: z.string().min(8, 'Password must be at least 8 characters'),
}).refine(data => data.password === data.confirmPassword, {
  message: 'Passwords don\'t match',
  path: ['confirmPassword'],
}))

const { handleSubmit, isSubmitting, values, setFieldValue, errors } = useForm({
  validationSchema: formSchema,
  initialValues: {
    email: '',
    name: '',
    dateOfBirth: '',
    password: '',
    confirmPassword: '',
  },
  validateOnMount: false,
})

const onSubmit = handleSubmit(async (values) => {
  await new Promise(resolve => setTimeout(resolve, 2000))
  console.log(values)
})

const showPassword = ref(false)
function togglePasswordVisibility() {
  showPassword.value = !showPassword.value
}

const placeholder = ref()

const df = new DateFormatter('en-US', {
  dateStyle: 'long',
})

const value = computed({
  get: () => values.dateOfBirth ? parseDate(values.dateOfBirth) : undefined,
  set: val => val,
})

const { value: email } = useField<string>('email', undefined, {
  validateOnValueUpdate: false,
  validateOnMount: false,
})

const { value: name } = useField<string>('name', undefined, {
  validateOnValueUpdate: false,
  validateOnMount: false,
})

const { value: password } = useField<string>('password', undefined, {
  validateOnValueUpdate: false,
  validateOnMount: false,
})

const { value: confirmPassword } = useField<string>('confirmPassword', undefined, {
  validateOnValueUpdate: false,
  validateOnMount: false,
})
</script>

<template>
  <div class="flex flex-col items-center p-4">
    <H3 class="mb-4 text-center">
      Register to PTNK Library
    </H3>

    <Card class="max-w-120 w-full">
      <CardContent>
        <form class="space-y-4" :aria-disabled="isSubmitting" @submit="onSubmit">
          <FormField name="email">
            <FormItem>
              <FormLabel for="email">
                Email
              </FormLabel>
              <FormControl>
                <Input v-model="email" type="email" autocomplete="email" :disabled="isSubmitting" />
              </FormControl>
              <FormMessage />
            </FormItem>
          </FormField>

          <FormField name="name">
            <FormItem>
              <FormLabel for="name">
                Full name
              </FormLabel>
              <FormControl>
                <Input v-model="name" type="text" autocomplete="name" :disabled="isSubmitting" />
              </FormControl>
            </FormItem>
          </FormField>

          <FormField name="dateOfBirth">
            <FormItem>
              <FormLabel for="dateOfBirth">
                Date of birth
              </FormLabel>
              <Popover>
                <PopoverTrigger as-child>
                  <FormControl>
                    <Button
                      variant="outline" :class="cn(
                        'ps-3 text-start font-normal w-full',
                        !value && 'text-muted-foreground',
                      )"
                      :disabled="isSubmitting"
                    >
                      <span>{{ value ? df.format(toDate(value)) : "Pick a date" }}</span>
                      <CalendarIcon class="ms-auto h-4 w-4 opacity-50" />
                    </Button>
                    <input hidden>
                  </FormControl>
                </PopoverTrigger>
                <PopoverContent class="w-auto p-0">
                  <Calendar
                    v-model:placeholder="placeholder"
                    v-model="value"
                    calendar-label="Date of birth"
                    initial-focus
                    :min-value="new CalendarDate(1900, 1, 1)"
                    :max-value="today(getLocalTimeZone())"
                    @update:model-value="(v?: DateValue) => {
                      if (v) {
                        setFieldValue('dateOfBirth', v.toString())
                      }
                      else {
                        setFieldValue('dateOfBirth', undefined)
                      }
                    }"
                  />
                </PopoverContent>
              </Popover>
              <FormMessage />
            </FormItem>
          </FormField>

          <FormField name="password">
            <FormItem>
              <FormLabel for="password">
                Password
              </FormLabel>
              <FormControl>
                <div class="flex justify-between gap-2">
                  <Input v-model="password" :type="showPassword ? 'text' : 'password'" autocomplete="new-password" :disabled="isSubmitting" />
                  <Button size="sm" class="h-full" type="button" variant="outline" :disabled="isSubmitting" @click="togglePasswordVisibility">
                    <Eye v-if="!showPassword" class="size-4" />
                    <EyeOff v-else class="size-4" />
                  </Button>
                </div>
              </FormControl>
              <FormMessage />
            </FormItem>
          </FormField>

          <FormField name="confirmPassword">
            <FormItem>
              <FormLabel for="confirmPassword">
                Confirm password
              </FormLabel>
              <FormControl>
                <div class="flex justify-between gap-2">
                  <Input v-model="confirmPassword" :type="showPassword ? 'text' : 'password'" autocomplete="new-password" :disabled="isSubmitting" />
                  <Button size="sm" class="h-full" type="button" variant="outline" :disabled="isSubmitting" @click="togglePasswordVisibility">
                    <Eye v-if="!showPassword" class="size-4" />
                    <EyeOff v-else class="size-4" />
                  </Button>
                </div>
              </FormControl>
              <FormMessage />
            </FormItem>
          </FormField>

          <Button class="w-full" type="submit" :disabled="isSubmitting" :loading="isSubmitting">
            Register
          </Button>
        </Form>
      </CardContent>
    </Card>
  </div>
</template>
