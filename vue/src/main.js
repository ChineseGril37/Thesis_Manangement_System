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
router.beforeEach((to,from,next) =>{
  if(to.meta.requireAuth){//当前路由是否需要登录？
    //requireAuth=true时，表示需要登录
    if(sessionStorage.getItem("isLogin") === "true"){//判断当前是否已经登录,登录后isLogin=true
      //isLogin=true时，表示已经登录
      next();
    }else {
      //isLogin=false时，表示没有登录
      Vue.prototype.$message({
        type: "error",
        message: "请先登录"
      });
      next({
        path: '/Login'
      })
    }
  }else {
    //requireAuth=false时，表示不需要登录
    next();
  }
})
