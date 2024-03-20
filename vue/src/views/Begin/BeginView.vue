<template>
  <div class="body">
    <div class="userinfo" >这是一个学院介绍</div>
    <div class="userinfo" >这是一个系统公告栏</div>
    <div class="userinfo" >这是一个流程速览</div>
    <div class="userinfo" >这是一个优秀论文展览</div>
    <div class="userinfo" >这是一个截止日期提醒</div>
    <div class="userinfo" >这是一个</div>
    <div></div>
  </div>
</template>

<script>
// @ is an alias to /src
import request from "@/utils/request";

import router from "@/router";
import {defineComponent, watch} from "vue";
export default {
  name: 'BeginView',
}
</script>
<style>
.body{
  height: calc(100vh - 105px);
  border-radius:0 0 5px 5px;
}
.userinfo{
  float: left;
  flex-direction:column;
  min-height: calc(25vh);
  width: calc(55vh);
  margin-top: 45px;
  margin-left: 55px;
  background-color:floralwhite;
  border-radius:5px 5px 5px 5px;
}
</style>