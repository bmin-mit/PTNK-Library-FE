import tailwindcss from '@tailwindcss/vite'

// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2024-11-01',
  devtools: { enabled: true },
  modules: ['@nuxt/eslint', '@nuxt/fonts', '@nuxt/image', '@nuxtjs/color-mode'],
  typescript: {
    typeCheck: true,
  },
  colorMode: {
    classSuffix: '',
  },
  css: ['~/assets/css/tailwind.css'],
  vite: {
    plugins: [
      tailwindcss(),
    ],
  },
  imports: {
    autoImport: false,
  },
  eslint: {
    config: {
      standalone: false,
    },
  },
})
