import type { Book } from '~/types/book.entity'
import { createAuthAxios } from '#imports'
import { defineStore } from 'pinia'
import { FetchStatus } from '~/types/fetch-status.enum'
import { createBook } from '~/utils/book'

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

    async createBook(book: Omit<Book, 'id'>) {
      const isSuccess = await createBook(book)
      if (isSuccess) {
        this.books.push(book as Book)
      }
    },

    async deleteBook(id: number) {
      const axios = createAuthAxios()
      const res = await axios.delete(`/book/${id}`)
      if (res.status === 200) {
        this.books = this.books.filter(book => book.id !== id)
      }
    },
  },
})
