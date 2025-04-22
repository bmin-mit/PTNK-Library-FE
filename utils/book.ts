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
