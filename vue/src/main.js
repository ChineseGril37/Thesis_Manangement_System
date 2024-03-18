import Vue from 'vue'
import App from './App.vue'
import router from './router'
import ElementUI from 'element-ui';
import Plugin from 'v-fit-columns';
import 'element-ui/lib/theme-chalk/index.css';
import  '@/assets/global.css'
Vue.config.productionTip = false
Vue.use(ElementUI, {size: 'small ' });// medium small mini
Vue.use(Plugin);
new Vue({
  router,
  render: h => h(App)
}).$mount('#app')