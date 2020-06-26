<template>
</template>

<script>
export default {
  data: function() {
    return {
      params: {
        broker: "tinkoff",
        credentials: {
          token: ""
        }
      }
    }
  },
  methods: {
    createPortfolio: function() {
      this.axios.post(`/portfolios`, {params: this.params}).then(
        function(res) {
          window.Turbolinks.visit(`/portfolios/${res.data.id}`)
        }
      )
    },
  },
}
</script>

<style>

</style>