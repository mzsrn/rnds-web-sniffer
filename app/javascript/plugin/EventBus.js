import Vue from 'vue/dist/vue.esm'
const eventBus = new Vue()

export default class {
  static install (Vue, options) {
    Vue.prototype.$eventBus = eventBus
  }
}
export { eventBus }