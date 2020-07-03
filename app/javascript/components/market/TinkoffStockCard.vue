<template>
  
</template>

<script>
console.log(123)
export default {
  data() {
    return {
      amount: "",
      account: "",
      token: "t.7f1IjgwZ1TBgXSdeix0ckbDv5gy4njGrJaMezYvpjWM1f0isGKCTrP-y5Omp8WfDygqJDg8o5xBtHtf-ZsL3kg"
    }
  },
  methods: {
    buy: function(figi) {
      this.axios.post(`/user_stocks`, {amount: this.amount, token: this.token, figi: figi})
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