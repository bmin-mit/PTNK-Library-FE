<script setup lang="ts">
import type { DateValue } from '@internationalized/date'
import type { Book } from '~/types/book.entity'
import { toTypedSchema } from '@vee-validate/zod'
import { useForm } from 'vee-validate'

import { ref } from 'vue'
import { toast } from 'vue-sonner'
import * as z from 'zod'
import { Button } from '~/components/ui/button'
import { DatePicker } from '~/components/ui/date-picker'
import { FormControl, FormField, FormItem, FormLabel, FormMessage } from '~/components/ui/form'
import { Input } from '~/components/ui/input'
import { requestLending } from '~/utils/book'

const { book } = defineProps<{
  book: Book
}>()

const formSchema = toTypedSchema(z.object({
  returnDate: z.string().date('Empty date of birth'),
  quantity: z.number().gt(0),
}))

const { handleSubmit, setFieldValue, isSubmitting } = useForm({
  validationSchema: formSchema,
  initialValues: {
    returnDate: '',
    quantity: 1,
  },
  validateOnMount: false,
})

const onSubmit = handleSubmit((values) => {
  requestLending(book.id, values.quantity, values.returnDate)
    .then(() => toast.success('Lending request sent successfully'))
    .catch(error => toast.error(`Failed to send lending request: ${error.message}`))
})

const returnDate = ref<DateValue>()

function setReturnDateField(value?: DateValue) {
  if (value) {
    setFieldValue('returnDate', value.toString())
  }
  else {
    setFieldValue('returnDate', undefined)
  }
}
</script>

<template>
  <form class="space-y-4" @submit="onSubmit">
    <FormField v-slot="{ componentField }" name="quantity">
      <FormItem>
        <FormLabel>Quantity</FormLabel>
        <FormControl>
          <Input :disabled="isSubmitting" type="number" placeholder="Quantity to lend" v-bind="componentField" />
        </FormControl>
        <FormMessage />
      </FormItem>
    </FormField>

    <FormField name="returnDate">
      <FormItem>
        <FormLabel for="returnDate">
          Return date
        </FormLabel>
        <DatePicker v-model="returnDate" :disabled="isSubmitting" @update:model-value="setReturnDateField" />
        <FormMessage />
      </FormItem>
    </FormField>

    <Button class="w-full" :disabled="isSubmitting">
      Request
    </Button>
  </form>
</template>
