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
          token: "t.2eKpo8Wh0txdsnFNBnlnAePwYXtFXKwaiAhCmqYyRELa9Iv-dSXPwlM-mw1CzpPJs-4nXLjdXsYA7-R8uHhNdA"
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