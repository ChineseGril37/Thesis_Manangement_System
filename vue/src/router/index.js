import Vue from 'vue'
import VueRouter from 'vue-router'
import HomeView from '../views/Home.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/Home',
    name: 'Home',
    component: () => import("@/views/Home.vue")
  },
  {
    path: '/studentList',
    name: 'studentList',
    component: () => import('@/views/Manage/studentsList.vue')
  },
  {
    path: '/teacherList',
    name: 'teacherList',
    component: () => import('@/views/Manage/teacherList.vue')
  },
  {
    path: '/userManage',
    name: 'userManage',
    component: () => import('@/views/Manage/userManage.vue')
  },
  {
    path: '/studentManage',
    name: 'studentManage',
    component: () => import('@/views/Manage/studentManage.vue')
  },
  {
    path: '/about',
    name: 'about',
    component: () => import(/* webpackChunkName: "about" */ '../views/AboutView.vue')
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
