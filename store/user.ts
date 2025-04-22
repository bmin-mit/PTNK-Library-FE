import type { User } from '~/types/user.entity'
import { createAuthAxios } from '#imports'
import { defineStore } from 'pinia'

export const useUser = defineStore('user', {
  state: () => ({
    user: null as User | null,
  }),

  actions: {
    async fetchUser() {
      const axios = createAuthAxios()
      const res = await axios.get<User>('/user/me')
      this.user = res.data
    },
  },
})
