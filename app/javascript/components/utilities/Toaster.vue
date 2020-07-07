<template>
<p v-show="isShowed" class="toaster">
  {{alert}}
  {{backAlert}}
</p>

</template>

<script>
export default {
  props: {
    alert: String
  },
  data: function () {
    return { 
      isShowed: false,
      backAlert: ""
    }
  },
  created() {
    this.$eventBus.$on('toaster:show', (data) => {
      this.show(data)
    })
  },
  methods: {
    show(data) {
      this.backAlert = data.data.error
      this.isShowed = true
      setTimeout( () => this.isShowed = false, 3000 )
    }
  }
  
}
</script>

<style lang="scss" scoped>
  .toaster {
    position: fixed;
    bottom: 30px;
    right: 30px;
    padding: 10px;
    width: 240px;
    border: 1px solid black;
    border-left: 3px solid red;
  }
</style>>