<template></template>

<script>
export default {
  name: "TinkoffPortfolio",
  data: function() {
    return {
      portfolio: {},
      hasPortfolio: false,
      token: ""
    }
  },
  created: async function() {
    try {
      const { data } = await this.axios.get(`/resource_settings/5/portfolios.json`)
      this.portfolio = data.portfolio?.payload
      this.hasPortfolio = true
    } catch(err) {
      this.portfolio = null
    }
  },
  methods: {
    refresh () {
      console.log(123)
    },
    create () {
      this.$modal.show("modal")
    },
    async createPortfolio () {
      try {
        const { data } = await this.axios.post(`/resource_settings/5/portfolios`, {token: this.token, resource_setting_id: 4, target: "tinkoff"})
      } catch(err) {
        console.log(err)
      }
    }
  }
}
</script>

<style>

</style>