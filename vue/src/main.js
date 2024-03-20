import Vue from 'vue'
import App from './App.vue'
import router from './router'
import ElementUI from 'element-ui';
import Plugin from 'v-fit-columns';
import 'element-ui/lib/theme-chalk/index.css';
import  '@/assets/global.css'
import VueCookies from 'vue-cookies';
Vue.config.productionTip = false
Vue.use(ElementUI, {size: 'small ' });// medium small mini
Vue.use(Plugin);
//这个方法需要放在new Vue之前，不然按F5刷新页面不会调用这个方法
Vue.use(VueCookies)
new Vue({
  router,
  render: h => h(App)
}).$mount('#app')