import { defineNuxtRouteMiddleware, navigateTo } from '#app'
import { useUser } from '~/store/user'

export default defineNuxtRouteMiddleware(async () => {
  const userStore = useUser()
  if (!userStore.user)
    return navigateTo('/login')
})
