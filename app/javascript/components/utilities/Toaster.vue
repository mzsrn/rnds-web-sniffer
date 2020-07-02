<template>
<p>
  {{alert}}
</p>

</template>

<script>
export default {
  props: {
    alert: String
  },
  data: function () {
    return { isShowed: this.$el?.innerHTML == undefined }
  },
  created() {
    this.$eventBus.$on('toaster:show', (data) => (console.log(data)))
  },
  methods: {
    show() {
      setTimeout( () => this.isShowed = false, 2000 )
    }
  }
  
}
</script>

<style lang="scss" scoped>
  .toaster {
    position: fixed;
    bottom: 30px;
    right: 30px;
    padding: 100px;
  }
</style>>