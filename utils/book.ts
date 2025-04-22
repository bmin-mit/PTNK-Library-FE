import type { Book } from '~/types/book.entity'
import { createAuthAxios } from '#imports'

export async function fetchAllBooks() {

}

export async function requestLending(bookId: number, quantity: number, returnDate: string) {
  const axios = createAuthAxios()
  const res = await axios.post('/book/request-lending', {
    bookId,
    quantity,
    returnDate,
  })

  return res.status === 201
}

export async function createBook(book: Omit<Book, 'id'>) {
  const axios = createAuthAxios()
  const res = await axios.post('/book', book)

  return res.status === 201
}
