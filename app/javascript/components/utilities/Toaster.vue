<template></template>

<script>
export default {
  data: function () {
    return { isShowed: this.$el?.innerHTML == undefined }
  },
  created() {
    setTimeout( () => this.isShowed = false, 2000)
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