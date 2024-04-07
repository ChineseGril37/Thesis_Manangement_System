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

router.beforeEach((to,from,next) =>{
  let isLogin = sessionStorage.getItem("isLogin");
  switch (sessionStorage.getItem('userType')){
    case '0':
  }
  if(to.path === '' || to.path === '/Login'){//当前路由跳转是否为Login页面
    //console.log("是Login，继续跳转");
    if(isLogin === "true"){
      next({
        path: '/Home'
      });
    }else {
      next();
    }
  } else {
    //console.log("不是Login，进行判断")
    //定义变量isLogin读取session中的登录状态并console输出查看
    //console.log("isLogin=" + isLogin);
    if(to.meta.requireAuth){//当前路由是否需要登录？
      //console.log("equireAuth=true时，表示需要登录");
      if(isLogin === null || isLogin === ''){
        //console.log("isLogin没有值或者为空值时，表示没有登录");
        Vue.prototype.$message({
          type: "error",
          message: "请先登录"
        });
        next({
          path: '/Login'
        });
      }else {
        //console.log("isLogin==true时，表示已经登录继续跳转");
        next();
      }
    }else {
      //console.log("requireAuth=false时，表示不需要登录");
      next();
    }
  }
})
//如果要实现vue-router全局路由守卫，要不然把beforeEach放main.js，但是new Vue一定要在它之后
//要不然就放在router的index.js里放在new VueRouter之后
//总之就是在new之前进行路由守卫
new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
