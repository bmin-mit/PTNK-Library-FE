<script setup lang="ts">
import type { DateValue } from '@internationalized/date'
import { navigateTo } from '#app'
import { definePageMeta, useHead } from '#imports'
import { Button } from '@/components/ui/button'
import { Card, CardContent } from '@/components/ui/card'
import { DatePicker } from '@/components/ui/date-picker'
import { FormControl, FormField, FormItem, FormLabel, FormMessage } from '@/components/ui/form'
import { Input } from '@/components/ui/input'
import { H3 } from '@/components/ui/typography'

import { useRegister } from '@/composables/useRegister'
import { toTypedSchema } from '@vee-validate/zod'
import { Eye, EyeOff } from 'lucide-vue-next'
import { useField, useForm } from 'vee-validate'
import { ref } from 'vue'
import { toast } from 'vue-sonner'
import * as z from 'zod'

useHead({
  title: 'PTNK Library - Register',
})

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

const { handleSubmit, isSubmitting, setFieldValue } = useForm({
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

const register = useRegister()

const onSubmit = handleSubmit(async (values) => {
  try {
    await register(values)

    toast.success('Registration successful, please log in')
    await navigateTo('/login')
  }
  catch (e: any) {
    toast.error(e.response.data.message)
  }
})

const showPassword = ref(false)
function togglePasswordVisibility() {
  showPassword.value = !showPassword.value
}

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

const dateOfBirth = ref<DateValue>()

function setDateOfBirthField(value?: DateValue) {
  if (value) {
    setFieldValue('dateOfBirth', value.toString())
  }
  else {
    setFieldValue('dateOfBirth', undefined)
  }
}
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
              <DatePicker v-model="dateOfBirth" @update:model-value="setDateOfBirthField" />
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

    <div class="mt-4 text-sm text-muted-foreground">
      Already have an account? <NuxtLink to="/login" class="text-primary underline">
        Log in
      </NuxtLink>
    </div>
  </div>
</template>
