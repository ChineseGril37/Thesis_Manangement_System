<template>
  <div class="app">
  <div class="header">
    <div class="logo" onclick="location.href='/'">
      <img src="@/assets/logo_nobackground.png" alt="" style="width: 80px;height: 80px;position: relative;float: left;">
      <span style="margin-left: 10px;margin-top:10px;font-size: 25px;float: left;">毕业论文(设计)管理系统</span>
    </div>
  </div>
    <div class="main">
      <div class="Post">
        <el-table
            class="PostInside"
            :data="postForm">
          <el-table-column prop="post" label="公告信息" min-width="10%"></el-table-column>
        </el-table>
      </div>
      <div class="Login">
        <div class="LoginMention">
          <p style="font-size: 3vh;margin: 10%">欢迎使用毕业论文(设计)管理程序</p>
          <p style="font-size: 2vh;margin-left: 25vh">请登录</p>
        </div>
        <div class="LoginInput">
          <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="0px" class="login-bok">
            <el-form-item prop="userName">
              <el-input v-model="ruleForm.userName" placeholder="账号">
                <i slot="prepend" class="el-icon-s-custom"/>
              </el-input>
            </el-form-item>
            <el-form-item prop="password">
              <el-input type="password" placeholder="密码" v-model="ruleForm.password">
                <i slot="prepend" class="el-icon-lock"/>
              </el-input>
            </el-form-item>
            <el-form-item prop="code">
              <el-row :span="24">
                <el-col :span="12">
                  <el-input v-model="ruleForm.code" auto-complete="off" placeholder="请输入验证码" size=""></el-input>
                </el-col>
                <el-col :span="12">
                  <div class="login-code" @click="refreshCode">
                    <!--验证码组件-->
                    <s-identify :identifyCode="identifyCode"></s-identify>
                  </div>
                </el-col>
              </el-row>
            </el-form-item>
            <el-form-item>
              <div class="login-btn">
                <el-button type="primary" @click="submitForm()" style="margin-left: auto;width: 35%">登录</el-button>
              </div>
            </el-form-item>
          </el-form>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import SIdentify from '../Login/SIdentify.vue'
import request from "@/utils/request";
import {setHome} from "@/utils/common";
export default {
  name: 'Login',
  components: { SIdentify },
  data() {
    return {
      checkCode: '',
      confirmForm:[],
      postForm:[],
      identifyCodes: '1234567890abcdefjhijklinopqrsduvwxyz',//随机串内容
      identifyCode: '',
      loginForm:{
        userName: '',
        password: '',
      },
      ruleForm: {
        userName: '',
        password: '',
        code: ""
      },
      // 校验
      rules: {
        userName:
            [
              { required: true, message: "请输入用户名", trigger: "blur" }
            ],
        password: [{ required: true, message: "请输入密码", trigger: "blur" }],
        code: [{ required: true, message: "请输入验证码", trigger: "blur" }]
      }
    };
  },
  mounted () {
    // 初始化验证码
    this.identifyCode = ''
    this.makeCode(this.identifyCodes, 4)
  },
  methods:{
    refreshCode () {
      this.identifyCode = ''
      this.makeCode(this.identifyCodes, 4)
    },
    makeCode (o, l) {
      for (let i = 0; i < l; i++) {
        this.identifyCode += this.identifyCodes[this.randomNum(0, this.identifyCodes.length)]
      }
    },
    randomNum (min, max) {
      return Math.floor(Math.random() * (max - min) + min)
    },
    submitForm(){
      if (this.ruleForm.code.toLowerCase() !== this.identifyCode.toLowerCase()) {
        this.$message.error('请填写正确验证码')
        this.refreshCode()
      }else if(this.ruleForm.userName === '' || this.ruleForm.password === ''){
        this.$message.error('请输入用户名或密码')
        this.refreshCode()
      } else {
        this.loginForm.userName = this.ruleForm.userName
        this.loginForm.password = this.ruleForm.password
        request.get('/user/login', {
          params:this.loginForm
        }).then( res=>{
          //console.log(JSON.parse(JSON.stringify(res)))
          if(res.code === '200'){
            if(res.data === null){
              this.$message.error('用户名或密码有误')
              this.refreshCode()
            }else {
              this.confirmForm = res.data
              sessionStorage.setItem("isLogin", "true")
              //这边后面做一个提交，服务器验证，通过之后获得token
              sessionStorage.setItem("userID", this.confirmForm.userId)
              sessionStorage.setItem("userType", this.confirmForm.userType)
              sessionStorage.setItem("userRealName", this.confirmForm.userRealName)
              sessionStorage.setItem("groupID", res.data.groupID)
              sessionStorage.setItem("userMajor", res.data.userMajor)
              this.$message.success("登录成功");
              setHome(this.confirmForm.userType)
              setTimeout(() => {
                this.$router.push("/Home");
              }, 1000);
            }
          }else {
            this.$message.error(res.msg)
            this.refreshCode()
          }
        })
      }
    }
  },
}
</script>
<style scoped>
.app{
  position : absolute;
  width : 100%;
  height : 100%;
  background-image: url("../../../public/background_Login.jpg");
  background-size: cover;
  background-attachment: fixed;
}
.header{
  height: 10vh;
  width:100%;
  background-color: #e3f1ef;
}
.logo{
  margin-left: 10vh;
  line-height: 7vh;
}
.main{
  min-height: calc(100vh - 240px);
  min-width: 100vh;
  display:flex;
  padding-left: 15%;
}
.PostInside{
  margin-top: 35%;
  margin-left: 15%;
  width: 60vh;
  height: 40vh;
  border-radius:5px 5px 5px 5px;
  font-size: 22px;
}
.Login{
  width: 35%;
  min-height: 60vh;
  min-width: 30vh;
  background-color: rgb(0,0,0,0.1);
  border-radius:25px 25px 25px 25px;
  padding-top: 10%;
  margin-left: 10vh;
}
.LoginInput{
  border:1px solid rgba(10, 4, 4, 0.09);
  margin-right: 5%;
  margin-left: 5%;
  padding: 80px;
  border-radius:25px 25px 25px 25px;
}
.foot{
  min-width: 100vh;
  height: 120px;
  background-color: #e3f1ef;
}
</style>
