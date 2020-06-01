<template>
  <div>
    <button href="#" class="btn btn-primary" @click.prevent='show'>Создать</button>
    <modal name="123">
      <h3 class="header">
        Загрузить портфель {{brokerName}}
      </h3>
      <div class="body">
        <div>
          <label for="login">Login</label>
          <input type="text" name="login" disabled="true" v-model="login">
        </div>
        <div>
          <label for="password">Пароль</label>
          <input type="password" name="password">
        </div>
        <button>
          Загрузить
      </button>
      </div>
    </modal>
  </div>
</template>

<script>
export default {
  props: {
    login: String,
    brokerName: String
  },
  methods: {
    show: function() {
      this.$modal.show("123")
    }
  }
}
</script>

<style lang="scss" scoped>
  .header {
    width: 50%;
    margin: auto;
    text-align: center;
  }
  .body {
    width: 50%;
    margin: auto;
    display: flex;
    padding: 20px;
    flex-direction: column;
    button {
      margin: 20px;
    }
  }

</style>