<template>
  <div id="app">
    <!-- 头部区域 -->
    <div style="height: 60px;line-height: 60px;width:100%;background-color: white;border-radius:5px 5px 5px 5px">
      <div class="logo" onclick="location.href='/Home'">
        <img src="../../assets/logo_nobackground.png" alt="" style="width: 60px;height: 60px;position: relative;left: 10px;">
        <span style="margin-left: 10px;font-size: 25px;float: right;">毕业论文管理系统</span>
      </div>
      <div class="login">
        <el-button size="middle" @click="loginOut">您好！{{userRealName}}。您的角色:{{userType}}</el-button>
      </div>
    </div>
    <!-- 侧边栏和主体 -->
    <div style="display: flex;margin-top: 5px">
      <!-- 侧边栏导航 -->
      <div style="width: 200px;min-height:calc(100vh - 70px);overflow: hidden;margin-right: 5px;background-color: white;border-radius:5px 5px 5px 5px">
        <el-menu :default-active="$router.path" router class="el-menu-demo">
          <el-menu-item index="/Home">
            <i class="el-icon-house"></i>
            <span>首页</span>
          </el-menu-item>
          <el-submenu index="/Project">
            <template slot="title">
              <i class="el-icon-folder-opened"></i>
              <span>课题申报</span>
            </template>
            <el-menu-item index="/Project/ProjectSubmission">
              <i class="el-icon-document-add"></i>
              <span>申报课题</span>
            </el-menu-item>
            <el-menu-item index="/Project/ProjectReportSubmission">
              <i class="el-icon-document"></i>
              <span>填写开题报告</span>
            </el-menu-item>
            <el-menu-item index="/Project/MissionReportSubmission">
              <i class="el-icon-document"></i>
              <span>填写任务书</span>
            </el-menu-item>
            <el-menu-item index="/Project/MidCheckSubmission">
              <i class="el-icon-document"></i>
              <span>填写中期检查</span>
            </el-menu-item>
          </el-submenu>
          <el-submenu index="/Thesis">
            <template slot="title">
              <i class="el-icon-folder-opened"></i>
              <span>论文管理</span>
            </template>
            <el-menu-item index="/Thesis/ThesisFirstDraftSubmission">
              <i class="el-icon-document-add"></i>
              <span>初稿提交</span>
            </el-menu-item>
            <el-menu-item index="/Thesis/ThesisFirstDraftEdit">
              <i class="el-icon-document"></i>
              <span>初稿修改</span>
            </el-menu-item>
            <el-menu-item index="/Thesis/ThesisFinalizeSubmission">
              <i class="el-icon-document-add"></i>
              <span>定稿提交</span>
            </el-menu-item>
            <el-menu-item index="/Thesis/ThesisFinalSubmission">
              <i class="el-icon-document-add"></i>
              <span>终稿提交</span>
            </el-menu-item>
            <el-menu-item index="/Thesis/ThesisCheck">
              <i class="el-icon-takeaway-box"></i>
              <span>格式检测</span>
            </el-menu-item>
            <el-menu-item index="/Thesis/ThesisView">
              <i class="el-icon-notebook-2"></i>
              <span>论文查看</span>
            </el-menu-item>
            <el-menu-item index="/Thesis/ThesisReview">
              <i class="el-icon-takeaway-box"></i>
              <span>论文审核</span>
            </el-menu-item>
          </el-submenu>
          <el-submenu index="/OralDefense">
            <template slot="title">
              <i class="el-icon-folder-opened"></i>
              <span>答辩管理</span>
            </template>
            <el-menu-item index="/OralDefense/OralDefenseInformation">
              <i class="el-icon-notebook-2"></i>
              <span>答辩信息</span>
            </el-menu-item>
            <el-menu-item index="/OralDefense/OralDefenseMaterial">
              <i class="el-icon-document-add"></i>
              <span>材料提交</span>
            </el-menu-item>
          </el-submenu>
          <el-submenu index="/User">
            <template slot="title">
              <i class="el-icon-user"></i>
              <span>人员管理</span>
            </template>
            <el-menu-item index="/User/StudentList">
              <i class="el-icon-tickets"></i>
              <span>学生列表</span>
            </el-menu-item>
            <el-menu-item index="/User/StudentManage">
              <i class="el-icon-circle-plus-outline"></i>
              <span>组员管理</span>
            </el-menu-item>
            <el-menu-item index="/User/TeacherList">
              <i class="el-icon-tickets"></i>
              <span>教师列表</span>
            </el-menu-item>
            <el-menu-item index="/User/UserManage">
              <i class="el-icon-edit-outline"></i>
              <span>信息修改</span>
            </el-menu-item>
          </el-submenu>
          <el-submenu index="/Process">
            <template slot="title">
              <i class="el-icon-files"></i>
              <span>流程管理</span>
            </template>
            <el-menu-item index="/Process/ProcessView">
              <i class="el-icon-tickets"></i>
              <span>流程查看</span>
            </el-menu-item>
            <el-menu-item index="/Process/ProcessManage">
              <i class="el-icon-edit-outline"></i>
              <span>流程管理</span>
            </el-menu-item>
          </el-submenu>
          <el-submenu index="/About">
            <template slot="title">
              <i class="el-icon-more-outline"></i>
              <span>关于</span>
            </template>
            <el-menu-item index="/About/AppView">
              <i class="el-icon-chat-dot-round"></i>
              <span>应用信息</span>
            </el-menu-item>
            <el-menu-item index="/About/Develop">
              <i class="el-icon-coffee-cup"></i>
              <span>开发人员</span>
            </el-menu-item>
          </el-submenu>
        </el-menu>
      </div>
      <!-- 主体内容 -->
      <div style="flex: 1;min-height:calc(100vh - 70px);background-color: white;border-radius:5px 5px 5px 5px;">
        <div style="height: 40px;padding-left: 20px;padding-top: 14px;background-color:whitesmoke;border-radius:5px 5px 0 0">
          <el-breadcrumb separator="/">
            <el-breadcrumb-item v-for="breadCrumbItem in breadCrumbList" :key="breadCrumbItem.path" :to="breadCrumbItem.path">
              {{breadCrumbItem.meta.title}}
            </el-breadcrumb-item>
          </el-breadcrumb>
        </div>
        <router-view></router-view>
      </div>
    </div>
  </div>
</template>

<script>
import router from "@/router";
import {defineComponent, watch} from "vue";
export default defineComponent({
  name: 'Home',
  data(){
    return{
      userType:'',
      userRealName:'',
    }
  },
  created() {
    this.setUserType();
  },
  methods: {
    router() {
      return router
    },
    setUserType(){
      this.userType = sessionStorage.getItem("userType");
      this.userRealName = sessionStorage.getItem("userRealName");
      if(this.userType === '0'){
        this.userType = '管理员';
      }else if(this.userType === '1'){
        this.userType = '教务';
      }else if(this.userType === '2'){
        this.userType = '教师';
      }else{
        this.userType = '学生';
      }
    },
    loginOut(){
      sessionStorage.clear();
      this.$message.success("登出成功");
      setTimeout(() => {
        this.$router.push('/');
      }, 1000);
    }
  },
  computed: {
    breadCrumbList() {
      return this.$route.matched;
    }
  },
})
</script>
<style  scoped>
/* 父标签跟随当前选中子标签栏高亮 */
::v-deep.el-submenu.is-active > .el-submenu__title {
  color: #409eff !important;
}
/* icon图标也跟着变 */
::v-deep .el-submenu.is-active > .el-submenu__title i {
  color: #409eff !important;
}
.login{
float: right;
  margin-right: 20px;
}
</style>