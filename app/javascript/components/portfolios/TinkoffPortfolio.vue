<template></template>

<script>
export default {
  name: "TinkoffPortfolio",
  data: function() {
    return {
      portfolio: {},
      hasPortfolio: false,
      token: "",
      account: ""
    }
  },
  props: {
    portfolioId: String
  },
  created: async function() {
    try {
      const { data } = await this.axios.get(`/portfolios/${this.portfolioId}.json`)
      this.portfolio = data.portfolio
      this.hasPortfolio = true
    } catch(err) {
      this.portfolio = null
    }
  },
  methods: {
    create () {
      this.$modal.show("modal")
    },
    refreshPortfolio () {
      params = {
        broker: "tinkoff",
        credentials: {
          token: this.token,
        },
        account: this.account
      }
      this.axios.patch(`/portfolios/${this.portfolioId}.json`, params)
        .then( function(res) {
          window.Turbolinks.visit(`/portfolios/${res.data.id}`)
        }).catch((err) =>
          console.error(err)
        )
    }
  }
}
</script>

<style>

</style>