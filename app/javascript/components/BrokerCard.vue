<template>
  <div class="resource_card">
    <div class="head">
      ESIA
    </div>
    <div class="body">
      <div class="row">
        <div class="key">Логин</div>
        <div class="value">ЛУЛ</div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['data'],
  data: function(){
    return {
      kek: "lol",
      brokers: []
    }
  },
  created: function(){
    this.axios
      .get('/resource_settings.json')
      .then(res => {  
        this.brokers = res.data
      })
  }
}
</script>

<style>

</style>