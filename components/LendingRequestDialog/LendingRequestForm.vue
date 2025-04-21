<script setup lang="ts">
import type { DateValue } from '@internationalized/date'
import { toTypedSchema } from '@vee-validate/zod'
import { useForm } from 'vee-validate'
import { ref } from 'vue'
import * as z from 'zod'

import { Button } from '~/components/ui/button'
import { DatePicker } from '~/components/ui/date-picker'
import { FormField, FormItem, FormLabel, FormMessage } from '~/components/ui/form'

const formSchema = toTypedSchema(z.object({
  bookId: z.number(),
  returnDate: z.string().date('Empty date of birth'),
  quantity: z.number().gt(0),
}))

const { handleSubmit, setFieldValue } = useForm({
  validationSchema: formSchema,
  initialValues: {
    bookId: 1,
    returnDate: '',
    quantity: 1,
  },
  validateOnMount: false,
})

const onSubmit = handleSubmit((values) => {
  console.log('Form submitted:', values)
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
    <FormField name="returnDate">
      <FormItem>
        <FormLabel for="returnDate">
          Return date
        </FormLabel>
        <DatePicker v-model="returnDate" @update:model-value="setReturnDateField" />
        <FormMessage />
      </FormItem>
    </FormField>

    <Button class="w-full">
      Submit
    </Button>
  </form>
</template>
