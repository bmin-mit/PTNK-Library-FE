import type { Book } from '~/types/book.entity'
import type { LendingStatus } from '~/types/lending-status.enum'
import type { User } from '~/types/user.entity'

export interface LendingRequest {
  id: number
  book: Book
  user: User
  status: LendingStatus
  quantity: number
  returnDate: Date
}
