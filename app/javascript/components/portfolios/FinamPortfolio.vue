<template></template>

<script>
export default {
  name: "FinamPortfolio",
  data: function() {
    return {
      portfolio: {},
      hasPortfolio: false,
      login: "",
      password: "",
    }
  },
  props: {
    portfolioId: String
  },
  created: async function() {
    try {
      const { data } = await this.axios.get(`/portfolios/${this.portfolioId}.json`)
      console.log(data)
      this.portfolio = data.portfolio
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
    refreshPortfolio () {
      this.axios.patch(`/portfolios/${this.portfolioId}.json`, {params: {broker: "finam", credentials: {login: this.login, password: this.password}}})
        .then( function(res) {
          window.Turbolinks.visit(`/portfolios`)
        }).catch((err) =>
          console.error(err)
        )
    }
  }
}
</script>

<style>

</style>