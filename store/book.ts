import type { Book } from '~/types/book.entity'
import { createAuthAxios } from '#imports'
import { defineStore } from 'pinia'
import { FetchStatus } from '~/types/fetch-status.enum'

export const useBookStore = defineStore('book', {
  state: () => ({ books: [] as Book[], status: FetchStatus.UNINITIALIZED }),

  getters: {},

  actions: {
    async fetchBooks() {
      const axios = createAuthAxios()

      this.status = FetchStatus.FETCHING
      try {
        const res = await axios.get<Book[]>('/book')
        this.books = res.data
        this.status = FetchStatus.SUCCESS
      }
      catch {
        this.status = FetchStatus.FAILED
      }
    },
  },
})
