<script setup lang="ts">
import { navigateTo } from '#app'
import { definePageMeta, useLogin } from '#imports'
import { Button } from '@/components/ui/button'
import { Card, CardContent } from '@/components/ui/card'
import { FormControl, FormField, FormItem, FormLabel, FormMessage } from '@/components/ui/form'
import { Input } from '@/components/ui/input'
import { toTypedSchema } from '@vee-validate/zod'
import { Eye, EyeOff } from 'lucide-vue-next'
import { useField, useForm } from 'vee-validate'
import { ref } from 'vue'
import { toast } from 'vue-sonner'
import * as z from 'zod'
import H3 from '~/components/ui/typography/H3.vue'

definePageMeta({
  layout: 'auth',
})

const login = useLogin()

const formSchema = toTypedSchema(z.object({
  email: z.string().email(),
  password: z.string(),
}))

const { handleSubmit, isSubmitting } = useForm({
  validationSchema: formSchema,
  initialValues: {
    email: '',
    password: '',
  },
  validateOnMount: false,
})

const onSubmit = handleSubmit(async (values) => {
  try {
    await login(values.email, values.password)

    toast.success('Log in successfully')
    await navigateTo('/books')
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
</script>

<template>
  <div class="flex flex-col items-center p-4">
    <H3 class="mb-4 text-center">
      Sign in to PTNK Library
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

          <FormField v-slot="{ componentField }" name="password">
            <FormItem>
              <FormLabel for="password">
                Password
              </FormLabel>
              <FormControl>
                <div class="flex justify-between gap-2">
                  <Input :type="showPassword ? 'text' : 'password'" autocomplete="current-password" v-bind="componentField" :disabled="isSubmitting" />
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
            Log in
          </Button>
        </form>
      </CardContent>
    </Card>

    <div class="mt-4 text-sm text-muted-foreground">
      Don't have an account? <NuxtLink to="/register" class="text-primary underline">
        Register
      </NuxtLink>
    </div>
  </div>
</template>
