// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("jquery")
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
import 'three-dots/dist/three-dots.css'

import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import VModal from 'vue-js-modal'
import App from '../app.vue'
import axios from 'axios'
import VueAxios from 'vue-axios'
import store from '../store'

import Toaster from '../components/utilities/Toaster.vue'

import BrokerCard from '../components/BrokerCard.vue'
import CreatePortfolio from '../components/CreatePortfolio.vue'
import PortfolioNew from '../components/PortfolioNew.vue'
import FinamPortfolio from '../components/portfolios/FinamPortfolio.vue'
import TinkoffPortfolio from '../components/portfolios/TinkoffPortfolio.vue'

Vue.use(TurbolinksAdapter)
Vue.use(VModal)
Vue.use(VueAxios, axios)
Vue.component('app', App)
Vue.component('toaster', Toaster)
Vue.component('broker-card', BrokerCard)
Vue.component('create-portfolio', CreatePortfolio)
Vue.component('portfolio-new', PortfolioNew)
Vue.component('finam-portfolio', FinamPortfolio)
Vue.component('tinkoff-portfolio', TinkoffPortfolio)

document.addEventListener('turbolinks:load', () => {
  axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  axios.interceptors.request.use(function (config) {
    store.commit('setLoading')
    return config;
  }, function(err) {
    store.commit('setLoading')
    return Promise.reject(error);
  })

  axios.interceptors.response.use(function (response) {
    store.commit('setLoading')
    return response;
  }, function(err) {
    store.commit('setLoading')
    return Promise.reject(error);
  })


  const app = new Vue({
    el: "[data-behavior='vue']",
    store: store
  })
})
