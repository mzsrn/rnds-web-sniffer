<template>
</template>

<script>
export default {
  data: function() {
    return {
      params: {
        broker: "tinkoff",
        credentials: {}
      }
    }
  },
  methods: {
    createPortfolio: function() {
      this.axios.post(`/portfolios`, {params: this.params}).then(
        function(res) {
          console.log(res)
        }
      )
    },
  },
}
</script>

<style>

</style>