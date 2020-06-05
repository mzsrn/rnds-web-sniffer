<template>
  <div class="modal">
    <table>
      <thead>
        <tr>
          <td v-for="value in tableHead">
            {{value}}
          </td>
        </tr>
      </thead>
      <tbody>
        <tr v-for="row in tableBody">
          <td>{{row.ticker}}</td>
          <td>{{row.quantity}}</td>
          <td>{{row.rate}}</td>
          <td>{{row.equity}}</td>
          <td>{{row.maintReq}}</td>
          <td>{{row.reqEquity}}</td>
          <td>{{row.posAvgPrice}}</td>
          <td>{{row.PLDay}}</td>
          <td>{{row.unrealizedPnl}}</td>
        </tr>
      </tbody>
    </table>
    <button href="#" class="btn btn-primary" @click.prevent='show'>Создать</button>
    <modal name="modal">
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
import consumer from "../channels/consumer"

export default {
  props: {
    brokerName: String,
    brokerId: String,
    body: String
  },
  computed: {
    parseBody: function() {
      console.log(JSON.parse(this.body))
      return JSON.parse(this.body)
    }
  },
  data: function () {
    return {
      login: "",
      password: "",      
      tableHead: {},
      tableBody: {}
    }
  },
  mounted () {
    consumer.subscriptions.create("BobikChannel", {
      received: (data) => {
        var ref, ref1;
        this.tableHead = (ref = data.result) != null ? ref.head : void 0;
        this.tableBody = (ref1 = data.result) != null ? ref1.body : void 0;
        this.$modal.hide("modal")
      }
    })
  },
  methods: {
    show: function() {
      this.$modal.show("modal")
    },
    createPortfolio: function() {
      this.axios.post(`/resource_settings/${this.brokerId}/portfolios`, {resource_setting_id: this.brokerId, login: this.login, password: this.password})
    },
    setPortfolio() {
      this.msg = data
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
  table {
    font-size: 14px;
    table-layout: fixed;
    border-collapse: collapse;
    thead {
      font-weight: bold;
    }
    tr {
      td {
        padding: 6px;
      }
    }
    tbody {
      tr:nth-child(odd) {
        background: lighten(#3b5998, 30%);
      }
    }
  }

</style>