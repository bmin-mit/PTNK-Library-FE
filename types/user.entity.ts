import type { UserRole } from '~/types/user-role.enum'

export interface User {
  name: string
  email?: string
  dateOfBirth: Date
  role: UserRole
}
