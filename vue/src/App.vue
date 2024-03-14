<template>
  <div id="app">
    <!-- 头部区域 -->
    <div style="height: 60px;line-height: 60px;background-color: white;border-radius:5px 5px 5px 5px">
      <div class="logo" onclick="location.href='http://localhost:8080/'">
        <img src="@/assets/logo_nobackground.png" alt="" style="width: 60px;height: 60px;position: relative;left: 10px;">
        <span style="margin-left: 10px;font-size: 25px;float: right;">毕业论文管理系统</span>
      </div>
    </div>
    <!-- 侧边栏和主体 -->
    <div style="display: flex;margin-top: 5px">
      <!-- 侧边栏导航 -->
      <div style="width: 200px;min-height:calc(100vh - 70px);overflow: hidden;margin-right: 5px;background-color: white;border-radius:5px 5px 5px 5px">
        <el-menu :default-active="$router.path" :default-openeds="['课题申报','论文管理']" router class="el-menu-demo">
          <el-menu-item index="/">
            <i class="el-icon-house"></i>
            <span>首页</span>
          </el-menu-item>
          <el-submenu index="课题申报">
            <template slot="title">
              <i class="el-icon-folder-opened"></i>
              <span>课题申报</span>
            </template>
            <el-menu-item index="申报课题">
              <i class="el-icon-document-add"></i>
              <span>申报课题</span>
            </el-menu-item>
            <el-menu-item index="填写开题报告">
              <i class="el-icon-document"></i>
              <span>填写开题报告</span>
            </el-menu-item>
            <el-menu-item index="填写任务书">
              <i class="el-icon-document"></i>
              <span>填写任务书</span>
            </el-menu-item>
            <el-menu-item index="填写开题报告">
              <i class="el-icon-document"></i>
              <span>填写开题报告</span>
            </el-menu-item>
          </el-submenu>
          <el-submenu index="论文管理">
            <template slot="title">
              <i class="el-icon-folder-opened"></i>
              <span>论文管理</span>
            </template>
            <el-menu-item index="初稿提交">
              <i class="el-icon-document-add"></i>
              <span>初稿提交</span>
            </el-menu-item>
            <el-menu-item index="初稿修改">
              <i class="el-icon-document"></i>
              <span>初稿修改</span>
            </el-menu-item>
            <el-menu-item index="格式检测">
              <i class="el-icon-takeaway-box"></i>
              <span>格式检测</span>
            </el-menu-item>
            <el-menu-item index="定稿提交">
              <i class="el-icon-document-add"></i>
              <span>定稿提交</span>
            </el-menu-item>
          </el-submenu>
          <el-submenu index="3">
            <template slot="title">
              <i class="el-icon-more-outline"></i>
              <span>更多信息</span>
            </template>
            <el-menu-item index="/about">
              <i class="el-icon-info"></i>
              <span>关于页面</span>
            </el-menu-item>
          </el-submenu>
        </el-menu>
      </div>
      <!-- 主体数据 -->
      <div style="flex: 1;min-height:calc(100vh - 70px);background-color: white;border-radius:5px 5px 5px 5px">
        <router-view/>

      </div>
    </div>
  </div>
</template>
<script>
import router from "@/router";
import {defineComponent} from "vue";
export default defineComponent({
  methods: {
    router() {
      return router
    }
  }
})
</script>