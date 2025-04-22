import { defineNuxtRouteMiddleware, navigateTo, useCookie } from '#app'
import { useUser } from '~/store/user'

export default defineNuxtRouteMiddleware(async () => {
  const accessToken = useCookie('accessToken').value

  if (!accessToken) {
    return navigateTo('/login')
  }

  const userStore = useUser()
  if (userStore.user)
    return

  try {
    await userStore.fetchUser()

    if (!userStore.user)
      return navigateTo('/login')
  }
  catch {
    return navigateTo('/login')
  }
})
