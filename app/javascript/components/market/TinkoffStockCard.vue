<template>
  
</template>

<script>
console.log(123)
export default {
  data() {
    return {
      amount: "1",
      account: "",
      token: "t.7f1IjgwZ1TBgXSdeix0ckbDv5gy4njGrJaMezYvpjWM1f0isGKCTrP-y5Omp8WfDygqJDg8o5xBtHtf-ZsL3kg"
    }
  },
  methods: {
    buy (figi) {
      this.axios.post(`/user_stocks`, {amount: this.amount, token: this.token, account: this.account, figi: figi, operation: "Buy"})
        .then( function(res) {
          window.Turbolinks.visit(`/portfolios/${res.data.id}`)
        }).catch((err) =>
          console.error(err)
        )
    },
    sell (figi) {
      this.axios.post(`/user_stocks`, {amount: this.amount, token: this.token, account: this.account, figi: figi, operation: "Sell"})
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