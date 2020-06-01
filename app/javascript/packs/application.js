// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("jquery")
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import VModal from 'vue-js-modal'
import App from '../app.vue'
import axios from 'axios'
import VueAxios from 'vue-axios'

import BrokerCard from '../components/BrokerCard.vue'
import CreatePortfolio from '../components/CreatePortfolio.vue'
import { sidebarCollapser } from './sidebar.js'

Vue.use(TurbolinksAdapter)
Vue.use(VModal)
Vue.use(VueAxios, axios)
Vue.component('app', App)
Vue.component('broker-card', BrokerCard)
Vue.component('create-portfolio', CreatePortfolio)

document.addEventListener('turbolinks:load', () => {
  axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  sidebarCollapser()
  const app = new Vue({
    el: "[data-behavior='vue']",
  })
})
