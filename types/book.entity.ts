export interface Book {
  id: number
  name: string
  quantity: number
  stock: number
  position?: string
  author?: string
  publisher?: string
  publishYear?: number
  isbn?: string
  language?: string
}
