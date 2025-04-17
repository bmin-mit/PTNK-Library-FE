<script setup lang="ts">
import { Button } from '@/components/ui/button'
import { Card, CardContent } from '@/components/ui/card'
import { FormControl, FormField, FormItem, FormLabel } from '@/components/ui/form'
import { Input } from '@/components/ui/input'

import { toTypedSchema } from '@vee-validate/zod'
import { Eye, EyeOff } from 'lucide-vue-next'
import { useForm } from 'vee-validate'
import { ref } from 'vue'
import * as z from 'zod'
import H3 from '~/components/ui/typography/H3.vue'

const formSchema = toTypedSchema(z.object({
  email: z.string().email(),
  password: z.string(),
}))

const { handleSubmit } = useForm({
  validationSchema: formSchema,
  initialValues: {
    email: '',
    password: '',
  },

})

const onSubmit = handleSubmit((values) => {
  console.log(values)
})

const showPassword = ref(false)
function togglePasswordVisibility() {
  showPassword.value = !showPassword.value
}
</script>

<template>
  <div class="flex flex-col items-center p-4">
    <NuxtImg src="/logo.svg" class="w-16 my-8" />

    <H3 class="mb-4 text-center">
      Sign in to PTNK Library
    </H3>

    <Card class="max-w-80 w-full">
      <CardContent>
        <form class="space-y-4" @submit="onSubmit">
          <FormField v-slot="{ componentField }" name="email">
            <FormItem>
              <FormLabel for="email">
                Email
              </FormLabel>
              <FormControl>
                <Input type="email" autocomplete="email" v-bind="componentField" />
              </FormControl>
            </FormItem>
          </FormField>

          <FormField v-slot="{ componentField }" name="password">
            <FormItem>
              <FormLabel for="password">
                Password
              </FormLabel>
              <FormControl>
                <div class="flex justify-between gap-2">
                  <Input :type="showPassword ? 'text' : 'password'" autocomplete="current-password" v-bind="componentField" />
                  <Button size="sm" class="h-full" type="button" variant="outline" @click="togglePasswordVisibility">
                    <Eye v-if="!showPassword" class="size-4" />
                    <EyeOff v-else class="size-4" />
                  </Button>
                </div>
              </FormControl>
            </FormItem>
          </FormField>

          <Button class="w-full" type="submit">
            Log in
          </Button>
        </form>
      </CardContent>
    </Card>
  </div>
</template>
