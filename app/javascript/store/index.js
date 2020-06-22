import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex';

Vue.use(Vuex);

const store = new Vuex.Store({
  state: {
    network: {
      isLoading: false
    }
  },
  mutations: {
    setLoading (state) {
      state.network.isLoading = !state.network.isLoading
    }
  }
})

export default store