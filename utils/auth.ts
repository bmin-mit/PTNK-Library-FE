import type { LoginResDto } from '~/types/login.dto'
import { useCookie, useRuntimeConfig } from '#app'
import { createAxios } from '~/utils/request'

function createAuthAxios() {
  const config = useRuntimeConfig()
  const baseUrl = config.public.apiBase
  return createAxios(baseUrl)
}

export async function login(email: string, password: string) {
  const axios = createAuthAxios()

  const res = await axios.post<LoginResDto>(
    '/auth/login',
    {
      email,
      password,
    },
  )

  if (res.status === 201) {
    saveToken(res.data.accessToken)
  }
}

function saveToken(token: string) {
  const cookie = useCookie('accessToken')
  cookie.value = token
}

export async function register(fields: {
  email: string
  name: string
  dateOfBirth: string
  password: string
}) {
  const axios = createAuthAxios()
  const res = await axios.post('/auth/register', fields)
  if (res.status === 201) {
    return true
  }

  return true
}
