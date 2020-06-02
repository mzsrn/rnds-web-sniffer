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
          <input type="text" name="login" v-model="login">
        </div>
        <div>
          <label for="password">Пароль</label>
          <input type="password" name="password" v-model="password">
        </div>
        <button @click="createPortfolio">
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
  data: function () {
    return {
      password: ""
    }
  },
  methods: {
    show: function() {
      this.$modal.show("123")
    },
    createPortfolio: function() {
      this.axios.post('/resource_settings/10/portfolios', {login: this.login, password: this.password})
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