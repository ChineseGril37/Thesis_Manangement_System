import Vue from 'vue'
import VueRouter from 'vue-router'
import User from "@/views/User/User.vue";
import Project from "@/views/Project/Project.vue";
import Thesis from "@/views/Thesis/Thesis.vue";
import OralDefense from "@/views/OralDefense/OralDefense.vue";
import Process from "@/views/Process/Process.vue";
import About from "@/views/About/About.vue";

Vue.use(VueRouter)
//所有权限通用路由表
//如首页和登录页和一些不用权限的公用页面
export const constantRouterMap = [
  {
    path: '/',          // 路径
    redirect: '/Login'  // 重定向
  },
  {
    path: '/Login',
    component: () => import("@/views/Login/LoginView.vue"),
    meta: {
      title: '登录',
      requireAuth:false,
    }
  },
  {
    path: '/SIdentify',
    component:()=>import("@/views/Login/SIdentify.vue"),
    meta:{
      title: '验证码生成',
      requireAuth:false
    }
  },
  {
    path: '/Home',
    name:'Home',
    redirect: '/BeginView',
    component: () => import("@/views/Home/Home.vue"),
    meta: {
      title: '首页',
      requireAuth:true,
    },
    children:[
      {
        path: '/BeginView',
        meta: {
          title: '首页',
          requireAuth:true
        },
        component: () => import("@/views/Home/BeginView.vue"),
      },
      {
        path: '/About',
        name: 'About',
        component: About,
        meta:{
          title:'关于',
          requireAuth:true
        },
        children:[{
          path: 'AppView',
          name: 'AppView',
          component: () => import(/* webpackChunkName: "about" */ '../views/About/AppView.vue'),
          meta:{
            title:'应用信息',
            requireAuth:true
          }
        },
          {
            path: 'Develop',
            name: 'Develop',
            component: () => import(/* webpackChunkName: "about" */ '../views/About/Develop.vue'),
            meta:{
              title:'开发人员',
              requireAuth:true
            }
          }]
      }
    ]
  },
  {
    path: '/404',          // 路径
    component: () => import('@/views/Error/Error.vue'),
  },
  {
    path: '*',
    redirect: '/404',
    hidden: true
  }
]
export const asyncRoutes = [
  {
    path: '/Project',
    name: 'Project',
    component: Project,
    meta:{
      title:'课题申报',
      requireAuth:true,
      role:[3]
    },
    children:[{
      //申报课题(学生)
      path: 'ProjectSubmission',
      component: () => import('@/views/Project/ProjectSubmission.vue'),
      meta:{
        title:'申报课题',
        requireAuth:true,
        role:[3]
      },
    },{
      //填写开题报告(学生)
      path: 'ProjectReportSubmission',
      component: () => import('@/views/Project/ProjectReportSubmission.vue'),
      meta:{
        title:'开题报告',
        requireAuth:true,
        role:[3]
      }
    },{
      //填写任务书(学生)
      path: 'MissionReportSubmission',
      component: () => import( '@/views/Project/MissionReportSubmission.vue'),
      meta:{
        title:'填写任务书',
        requireAuth:true,
        role:[3]
      }
    },{
      //填写中期检查(学生)
      path: 'MidCheckSubmission',
      component: () => import('@/views/Project/MidCheckSubmission.vue'),
      meta:{
        title:'中期检查',
        requireAuth:true,
        role:[3]
      }
    }]
  },
  {
    path: '/Thesis',
    name: 'Thesis',
    component: Thesis,
    meta:{
      title:'论文管理',
      requireAuth:true,
      role:[0,1,2,3]
    },
    children:[{
      //论文初稿提交(学生)
      path: 'ThesisFirstDraftSubmission',
      component: () => import(/* webpackChunkName: "about" */ '../views/Thesis/ThesisFirstDraftSubmission.vue'),
      meta:{
        title:'论文初稿',
        requireAuth:true,
        role:[3]
      }
    },{
      //论文定稿提交(学生)
      path: 'ThesisFinalizeSubmission',
      component: () => import(/* webpackChunkName: "about" */ '../views/Thesis/ThesisFinalizeSubmission.vue'),
      meta:{
        title:'论文定稿',
        requireAuth:true,
        role:[3]
      }
    },{
      //论文终稿提交(学生)
      path: 'ThesisFinalSubmission',
      name: 'ThesisFinalSubmission',
      component: () => import(/* webpackChunkName: "about" */ '../views/Thesis/ThesisFinalSubmission.vue'),
      meta:{
        title:'论文终稿',
        requireAuth:true,
        role:[3]
      }
    },
      {
        //论文初稿修改(学生)
        path: 'ThesisFirstDraftEdit',
        name: 'ThesisFirstDraftEdit',
        component: () => import(/* webpackChunkName: "about" */ '../views/Thesis/ThesisFirstDraftEdit.vue'),
        meta:{
          title:'论文初稿修改',
          requireAuth:true,
          role:[3]
        }
      },
      {
        //论文格式检查(学生)
        path: 'ThesisCheck',
        name: 'ThesisCheck',
        component: () => import(/* webpackChunkName: "about" */ '../views/Thesis/ThesisCheck.vue'),
        meta:{
          title:'格式检查',
          requireAuth:true,
          role:[3]
        }
      },
      {
        //论文查看(全角色)
        path: 'ThesisView',
        name: 'ThesisView',
        component: () => import(/* webpackChunkName: "about" */ '../views/Thesis/ThesisView.vue'),
        meta:{
          title:'论文查看',
          requireAuth:true,
          role:[0,1,2,3]
        }
      },
      {
        //论文审核(教师/教务/管理员)
        path: 'ThesisReview',
        name: 'ThesisReview',
        component: () => import(/* webpackChunkName: "about" */ '../views/Thesis/ThesisReview.vue'),
        meta:{
          title:'论文审核',
          requireAuth:true,
          role:[0,1,2]
        }
      }]
  },
  {
    path: '/OralDefense',
    name: 'OralDefense',
    component: OralDefense,
    meta:{
      title:'答辩管理',
      requireAuth:true,
      role:[0,1,2,3]
    },
    children:[{
      //答辩信息(全角色)
      path: 'OralDefenseInformation',
      name: 'OralDefenseInformation',
      component: () => import(/* webpackChunkName: "about" */ '../views/OralDefense/OralDefenseInformation.vue'),
      meta:{
        title:'答辩信息',
        requireAuth:true,
        role:[0,1,2,3]
      }
    },
      {
        //答辩材料提交(学生)
        path: 'OralDefenseMaterial',
        name: 'OralDefenseMaterial',
        component: () => import(/* webpackChunkName: "about" */ '../views/OralDefense/OralDefenseMaterial.vue'),
        meta:{
          title:'材料提交',
          requireAuth:true,
          role:[3]
        }
      },]
  },
  {
    path: '/User',
    name: 'User',
    component: User,
    meta:{
      title:'人员管理',
      requireAuth:true,
      role:[0,1,2,3]
    },
    children:[{
      //用户管理(管理员)
      path: 'UserManage',
      name: 'UserManage',
      component: () => import('@/views/User/UserManage.vue'),
      meta:{
        title:'用户管理',
        requireAuth:true,
        role:[0]
      }
    },
      {
        //教师列表查询(管理员)
        path: 'TeacherList',
        name: 'TeacherList',
        component: () => import('@/views/User/TeacherList.vue'),
        meta:{
          title:'教师列表查询',
          requireAuth:true,
          role:[0,1]
        }
      },
      {
        //学生列表查询(教师/教务)
        path: 'StudentList',
        name: 'StudentList',
        component: () => import('@/views/User/StudentsList.vue'),
        meta:{
          title:'学生列表查询',
          requireAuth:true,
          role:[0,1,2]
        }
      },
      {
        //学生管理(教务)
        path: 'StudentManage',
        name: 'StudentManage',
        component: () => import('@/views/User/StudentManage.vue'),
        meta:{
          title:'组员管理',
          requireAuth:true,
          role:[2]
        }
      },
      {
        //学生管理(教务)
        path: 'UserDialog',
        name: 'UserDialog',
        component: () => import('@/components/UserDialog.vue'),
        meta:{
          title:'用户管理弹窗',
          requireAuth:true,
          role:[0,1]
        }
      },]
  },
  {
    path: '/Process',
    name:'Process',
    component: Process,
    meta:{
      title:'流程管理',
      requireAuth:true,
      role:[0,1,2,3]
    },
    children:[{
      //流程查看(全角色)
      path: 'ProcessView',
      name: 'ProcessView',
      component: () => import(/* webpackChunkName: "about" */ '../views/Process/ProcessView.vue'),
      meta:{
        title:'流程查看',
        requireAuth:true,
        role:[0,1,2,3]
      }
    },
      {
        //流程管理(教务/管理员)
        path: 'ProcessManage',
        name: 'ProcessManage',
        component: () => import(/* webpackChunkName: "about" */ '../views/Process/ProcessManage.vue'),
        meta:{
          title:'流程管理',
          requireAuth:true,
          role:[0,1]
        }
      },{
        path: 'ProcessDate',
        name:'ProcessDate',
        component:() => import('../views/Process/ProcessDate.vue'),
        meta: {
          title: '截止日期',
          requireAuth: true,
          role:[0,1]
        }
      }]
  }
]

//修复面包屑点击当前路由导致的报错
const originalPush = VueRouter.prototype.push
//修改原型对象中的push方法
VueRouter.prototype.push = function push(location) {
  return originalPush.call(this, location).catch(err => err)
}
export default new VueRouter({
  mode: 'history',
  routes: constantRouterMap
});
