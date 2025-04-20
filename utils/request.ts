import axios from 'axios'

export function createAxios(baseURL: string) {
  return axios.create({
    baseURL,
  })
}
