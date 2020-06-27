<template>
</template>

<script>
import consumer from "../channels/consumer"

export default {
  data: function() {
    return {
      errors: "",
      params: {
        broker: "tinkoff",
        credentials: {
          token: "t.KqViz0MEZrQkRpFJWI5d-NCMTjkrl56XhbHB5u_jUTUICnlEb8ZrT7bZ5eIFN21bjmip09zf9HyvDJ5EiwyttQ"
        }
      }
    }
  },
  mounted () {
    consumer.subscriptions.create("BobikChannel", {
      received: (data) => {
        console.log(data)
      }
    })
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