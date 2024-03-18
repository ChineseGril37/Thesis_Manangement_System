import Vue from 'vue'
import VueRouter from 'vue-router'
import User from "@/views/User/User.vue";
import Project from "@/views/Project/Project.vue";
import Thesis from "@/views/Thesis/Thesis.vue";
import OralDefense from "@/views/OralDefense/OralDefense.vue";
import Process from "@/views/Process/Process.vue";
import About from "@/views/About/About.vue";


Vue.use(VueRouter)

const routes = [
  {
    path: '/Home',
    component: () => import("@/views/Home.vue"),
    meta: { title: '首页'}
  },
  {
    path: '/Project',
    name: 'Project',
    component: Project,
    meta:{ title:'课题申报'},
    children:[{
      //申报课题(学生)
      path: 'ProjectSubmission',
      component: () => import(/* webpackChunkName: "about" */ '../views/Project/ProjectSubmission.vue'),
      meta:{ title:'申报课题'}
    },{
      //填写开题报告(学生)
      path: 'ProjectReportSubmission',
      component: () => import(/* webpackChunkName: "about" */ '../views/Project/ProjectReportSubmission.vue'),
      meta:{ title:'开题报告'}
    },{
      //填写任务书(学生)
      path: 'MissionReportSubmission',
      component: () => import(/* webpackChunkName: "about" */ '../views/Project/MissionReportSubmission.vue'),
      meta:{ title:'填写任务书'}
    },{
      //填写中期检查(学生)
      path: 'MidCheckSubmission',
      component: () => import(/* webpackChunkName: "about" */ '../views/Project/MidCheckSubmission.vue'),
      meta:{ title:'中期检查'}
    },]
  },
  {
    path: '/Thesis',
    name: 'Thesis',
    component: Thesis,
    meta:{ title:'论文管理'},
    children:[{
      //论文初稿提交(学生)
      path: 'ThesisFirstDraftSubmission',
      component: () => import(/* webpackChunkName: "about" */ '../views/Thesis/ThesisFirstDraftSubmission.vue'),
      meta:{ title:'论文初稿'}
    },{
      //论文定稿提交(学生)
      path: 'ThesisFinalizeSubmission',
      component: () => import(/* webpackChunkName: "about" */ '../views/Thesis/ThesisFinalizeSubmission.vue'),
      meta:{ title:'论文定稿'}
    },{
      //论文终稿提交(学生)
      path: 'ThesisFinalSubmission',
      name: 'ThesisFinalSubmission',
      component: () => import(/* webpackChunkName: "about" */ '../views/Thesis/ThesisFinalSubmission.vue'),
      meta:{ title:'论文终稿'}
    },
      {
        //论文初稿修改(学生)
        path: 'ThesisFirstDraftEdit',
        name: 'ThesisFirstDraftEdit',
        component: () => import(/* webpackChunkName: "about" */ '../views/Thesis/ThesisFirstDraftEdit.vue'),
        meta:{ title:'论文初稿修改'}
      },
      {
        //论文格式检查(学生)
        path: 'ThesisCheck',
        name: 'ThesisCheck',
        component: () => import(/* webpackChunkName: "about" */ '../views/Thesis/ThesisCheck.vue'),
        meta:{ title:'格式检查'}
      },
      {
        //论文查看(全角色)
        path: 'ThesisView',
        name: 'ThesisView',
        component: () => import(/* webpackChunkName: "about" */ '../views/Thesis/ThesisView.vue'),
        meta:{ title:'论文查看'}
      },
      {
        //论文审核(教师/教务/管理员)
        path: 'ThesisReview',
        name: 'ThesisReview',
        component: () => import(/* webpackChunkName: "about" */ '../views/Thesis/ThesisReview.vue'),
        meta:{ title:'论文审核'}
      }]
  },
  {
    path: '/OralDefense',
    name: 'OralDefense',
    component: OralDefense,
    meta:{ title:'答辩管理'},
    children:[{
      //答辩信息(全角色)
      path: 'OralDefenseInformation',
      name: 'OralDefenseInformation',
      component: () => import(/* webpackChunkName: "about" */ '../views/OralDefense/OralDefenseInformation.vue'),
      meta:{ title:'答辩信息'}
    },
      {
        //答辩材料提交(学生)
        path: 'OralDefenseMaterial',
        name: 'OralDefenseMaterial',
        component: () => import(/* webpackChunkName: "about" */ '../views/OralDefense/OralDefenseMaterial.vue'),
        meta:{ title:'材料提交'}
      },]
  },
  {
    path: '/User',
    name: 'User',
    component: User,
    meta:{ title:'人员管理'},
    children:[{
      //用户管理(管理员)
      path: 'UserManage',
      name: 'UserManage',
      component: () => import('@/views/User/UserManage.vue'),
      meta:{ title:'用户管理'}
    },
      {
        //教师列表查询(管理员)
        path: 'TeacherList',
        name: 'TeacherList',
        component: () => import('@/views/User/TeacherList.vue'),
        meta:{ title:'教师列表查询'}
      },
      {
        //学生列表查询(教师/教务)
        path: 'StudentList',
        name: 'StudentList',
        component: () => import('@/views/User/StudentsList.vue'),
        meta:{ title:'学生列表查询'}
      },
      {
        //学生管理(教务)
        path: 'StudentManage',
        name: 'StudentManage',
        component: () => import('@/views/User/StudentManage.vue'),
        meta:{ title:'学生管理'}
      },
      {
        //学生管理(教务)
        path: 'UserDialog',
        name: 'UserDialog',
        component: () => import('@/views/User/UserDialog.vue'),
        meta:{ title:'用户管理弹窗'}
      },]
  },
  {
    path: '/Process',
    name:'Process',
    component: Process,
    meta:{ title:'流程管理'},
    children:[{
      //流程查看(全角色)
      path: 'ProcessView',
      name: 'ProcessView',
      component: () => import(/* webpackChunkName: "about" */ '../views/Process/ProcessView.vue'),
      meta:{ title:'流程查看'}
    },
      {
        //流程管理(教务/管理员)
        path: 'ProcessManage',
        name: 'ProcessManage',
        component: () => import(/* webpackChunkName: "about" */ '../views/Process/ProcessManage.vue'),
        meta:{ title:'流程管理'}
      },]
  },
  {
    path: '/About',
    name: 'About',
    component: About,
    meta:{ title:'关于'},
    children:[{
      path: 'AppView',
      name: 'AppView',
      component: () => import(/* webpackChunkName: "about" */ '../views/About/AppView.vue'),
      meta:{ title:'应用信息'}
    },
      {
        path: 'Develop',
        name: 'Develop',
        component: () => import(/* webpackChunkName: "about" */ '../views/About/Develop.vue'),
        meta:{ title:'开发人员'}
      }]
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

//修复面包屑点击当前路由导致的报错
const originalPush = VueRouter.prototype.push
//修改原型对象中的push方法
VueRouter.prototype.push = function push(location) {
  return originalPush.call(this, location).catch(err => err)
}

export default router
