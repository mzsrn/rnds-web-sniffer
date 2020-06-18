<template></template>

<script>
export default {
  name: "TinkoffPortfolio",
  data: function() {
    return {
      portfolio: {}
    }
  },
  created: async function() {
    try {
      const { data } = await this.axios.get(`/resource_settings/4/portfolios.json`)
      this.portfolio = data.portfolio?.payload
    } catch(err) {
      this.portfolio = null
    }
  }
}
</script>

<style>

</style>