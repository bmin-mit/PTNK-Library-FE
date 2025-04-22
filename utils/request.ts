import { useCookie, useRuntimeConfig } from '#app'
import axios from 'axios'

export function createAxios(headers?: object) {
  const config = useRuntimeConfig()
  const baseURL = config.public.apiBase

  return axios.create({
    baseURL,
    headers,
  })
}

export function createAuthAxios() {
  const token = useCookie('accessToken').value
  return createAxios({
    Authorization: `Bearer ${token}`,
  })
}
