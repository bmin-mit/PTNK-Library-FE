import type { AxiosError } from 'axios'
import { defineNuxtRouteMiddleware, useCookie } from '#app'
import { useUser } from '~/store/user'

export default defineNuxtRouteMiddleware(async () => {
  const accessToken = useCookie('accessToken').value

  if (!accessToken)
    return

  const userStore = useUser()

  try {
    await userStore.fetchUser()
  }
  catch (e) {
    console.log('Failed to fetch user data on middleware with message:', (e as AxiosError).code)
  }
})
