import type { LendingRequest } from '~/types/lending-request.entity'
import { createAuthAxios } from '#imports'
import { defineStore } from 'pinia'
import { useUser } from '~/store/user'
import { FetchStatus } from '~/types/fetch-status.enum'
import { LendingStatus } from '~/types/lending-status.enum'
import { UserRole } from '~/types/user-role.enum'

export const useLendingRequestsStore = defineStore('lendingRequests', {
  state: () => ({ lendingRequests: [] as LendingRequest[], status: FetchStatus.UNINITIALIZED }),

  actions: {
    async fetchLendingRequests() {
      const axios = createAuthAxios()
      const user = useUser().user
      this.status = FetchStatus.FETCHING

      try {
        const url = user?.role === UserRole.ADMIN ? '/book/all-lending-status' : '/book/request-lending'
        const res = await axios.get<LendingRequest[]>(url)
        this.lendingRequests = res.data
        this.status = FetchStatus.SUCCESS
      }
      catch {
        this.status = FetchStatus.FAILED
      }
    },

    updateLendingRequestStatus(lendingRequestId: number, status: LendingStatus) {
      this.lendingRequests = this.lendingRequests.map((lendingRequest) => {
        if (lendingRequest.id === lendingRequestId) {
          return { ...lendingRequest, status }
        }
        return lendingRequest
      })
    },

    async approveLendingRequest(lendingRequestId: number) {
      const axios = createAuthAxios()
      await axios.post(`/book/approve-lending/${lendingRequestId}`)

      this.updateLendingRequestStatus(lendingRequestId, LendingStatus.APPROVED)
    },

    async rejectLendingRequest(lendingRequestId: number) {
      const axios = createAuthAxios()
      await axios.post(`/book/reject-lending/${lendingRequestId}`)

      this.updateLendingRequestStatus(lendingRequestId, LendingStatus.REJECTED)
    },

    async returnLendingRequest(lendingRequestId: number) {
      const axios = createAuthAxios()
      await axios.post(`/book/return-lending/${lendingRequestId}`)

      this.updateLendingRequestStatus(lendingRequestId, LendingStatus.RETURNED)
    },
  },
})
