<template>
  <div style="padding-left: 20px;margin-top: 20px">
    <!-- 搜索表单 -->
    <div style="margin-bottom: 20px">
      <el-input style="width: 240px" placeholder="请输入学号" v-model="params.userId"></el-input>
      <el-input style="width: 240px;margin-left: 10px" placeholder="请输入姓名" v-model="params.userRealName"></el-input>
      <el-button style="margin-left: 5px" type="primary" @click="load"><i class="el-icon-search"></i><span>搜索</span></el-button>
      <el-button style="margin-left: 5px" type="warning" @click="reset"><i class="el-icon-refresh"></i><span>重置</span></el-button>
      <el-button style="margin-left: 5px" type="primary"  @click="userManage = true">添加用户</el-button>

    </div>
    <!--  数据表单  -->
    <el-table :data="tableData" stripe>
      <el-table-column prop="userId" label="学号/教务号" width="180"></el-table-column>
      <el-table-column prop="userRealName" label="姓名" width="180"></el-table-column>
      <el-table-column prop="userAge" label="年龄" width="180"></el-table-column>
      <el-table-column prop="sexual" label="性别" width="180" >
        <template slot-scope="scope">
          {{ scope.row.sexual === '1' ? '男' : '女' }}
        </template>
      </el-table-column>
      <el-table-column prop="groupID" label="分组" width="180"></el-table-column>
      <el-table-column prop="ancestralPlace" label="籍贯" width="180"></el-table-column>
      <el-table-column prop="politicalStatus" label="政治面貌"></el-table-column>
      <el-table-column prop="phoneNum" label="联系方式"></el-table-column>
      <el-table-column prop="email" label="邮箱" ></el-table-column>
      <el-table-column prop="accountChangeTime" label="修改时间"></el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button size="mini" @click="userManage = true">编辑</el-button>
          <el-button size="mini" type="danger" @click="open">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <!-- 编辑用户表单弹窗 -->
    <el-dialog title="用户管理" :visible.sync="userManage">
      <el-form :model="manageForm" inline="true" rule="checkRules">
        <el-form-item label="学号/教务号" :label-width="formLabelWidth">
          <el-input v-model="manageForm.userId" type="text" maxlength="10" show-word-limit clearable></el-input>
        </el-form-item >
        <el-form-item label="用户名" :label-width="formLabelWidth">
          <el-input v-model="manageForm.userName" clearable></el-input>
        </el-form-item>
        <el-form-item label="密码" :label-width="formLabelWidth">
        <el-input v-model="manageForm.passWord" clearable></el-input>
      </el-form-item>
        <el-form-item label="姓名" :label-width="formLabelWidth">
          <el-input v-model="manageForm.userRealName" clearable></el-input>
        </el-form-item>
        <el-form-item label="年龄" :label-width="formLabelWidth">
          <el-input v-model="manageForm.userAge" clearable></el-input>
        </el-form-item>
        <el-form-item label="性别" :label-width="formLabelWidth">
          <el-select v-model="manageForm.sexual" placeholder="请选择" >
            <el-option label="男" value = 1></el-option>
            <el-option label="女" value = 0></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="联系方式" :label-width="formLabelWidth">
          <el-input type="text" v-model="manageForm.phoneNum" placeholder="联系方式" maxlength="11" show-word-limit clearable></el-input>
        </el-form-item>
        <el-form-item label="分组" :label-width="formLabelWidth">
          <el-input v-model="manageForm.groupID" clearable></el-input>
        </el-form-item>
        <el-form-item label="籍贯" :label-width="formLabelWidth">
          <el-input v-model="manageForm.ancestralPlace" clearable></el-input>
        </el-form-item>
        <el-form-item label="政治面貌" :label-width="formLabelWidth">
          <el-select v-model="manageForm.politicalStatus" placeholder="请选择" >
            <el-option label="党员" value = "党员"></el-option>
            <el-option label="预备党员" value = "预备党员"></el-option>
            <el-option label="民主党派人士" value = "民主党派人士"></el-option>
            <el-option label="群众" value = "群众"></el-option>
            <el-option label="共青团员" value = "共青团员"></el-option>
            <el-option label="无党派人士" value = "无党派人士"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="邮箱" :label-width="formLabelWidth">
          <el-input v-model="manageForm.email" clearable></el-input>
        </el-form-item>
      </el-form>
      <!-- 确认和取消 -->
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="setCurrentTime();change();userManage = false">确 定</el-button>
        <el-button @click="userManage = false">取 消</el-button>
      </div>
    </el-dialog>
    <!-- 分页 -->
    <div class="block">
      <el-pagination
          background
          :current-page="params.pageNum"
          :page-size="params.pageSize"
          layout="prev, pager, next"
          @current-change="handelCurrentChange"
          :total="total">
      </el-pagination>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";
export default {
  name: "userManage",
  data(){
    var checkEmail = (rule, value, callback) => {
      const mailReg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/
      if (!value) {
        return callback(new Error('邮箱不能为空'))
      }
      setTimeout(() => {
        if (mailReg.test(value)) {
          callback()
        } else {
          callback(new Error('请输入正确的邮箱格式'))
        }
      }, 100)
    }
    var checkPhone = (rule, value, callback) => {
      const phoneReg = /^1[3|4|5|7|8][0-9]{9}$/
      if (!value) {
        return callback(new Error('电话号码不能为空'))
      }
      setTimeout(() => {
        // Number.isInteger是es6验证数字是否为整数的方法,但是我实际用的时候输入的数字总是识别成字符串
        // 所以我就在前面加了一个+实现隐式转换
        if (!Number.isInteger(+value)) {
          callback(new Error('请输入数字值'))
        } else {
          if (phoneReg.test(value)) {
            callback()
          } else {
            callback(new Error('电话号码格式不正确'))
          }
        }
      }, 100)
    }
    return{
      tableData:[],
      total: 0,
      params:{
        pageNum: 1,
        pageSize: 10,
        userRealName: '',
        userId: ''
      },
      userManage:false,
      manageForm: {
        userId:'',
        userType:'',
        userRealName:'',
        userName:'',
        passWord:'',
        sexual:'',
        accountChangeTime:'',
        phoneNum:'',
        email:'',
        ancestralPlace:'',
        politicalStatus:'',
        groupID:'',
        userAge:'',
        registerCode:''
      },
      formLabelWidth: '100px',
      checkRules:{
        phoneNum:[
      { validator: checkPhone, trigger: 'blur' }
    ],
        email:[
          { validator: checkEmail, trigger: 'blur' }
        ]
      }
    }
  },
  created() {
    this.load()
  },
  methods:{
    load() {
      request.get('/user/page', {
        params: this.params
      }).then(res =>{
        if(res.code === '200'){
          this.tableData = res.data.list
          this.total = res.data.total
        }
      })
    },
    reset(){
      //重置当前
      this.params = {
        userType: 2,
        pageNum: 1,
        pageSize: 10,
        name: '',
        userId: ''
      }
      this.load()
    },
    handelCurrentChange(pageNum){
      //  点击翻页按键触发产生交互
      this.params.pageNum = pageNum
      this.load()
    },
    change(){
      //把表单中的内容推送到后端
      request.post('/user/change')
    },
    setCurrentTime() {
      //获取当前时间并打印
      let yy = new Date().getFullYear();
      let mm = new Date().getMonth()+1;
      let dd = new Date().getDate();
      let hh = new Date().getHours();
      let mf = new Date().getMinutes()<10 ? '0'+new Date().getMinutes() : new Date().getMinutes();
      let ss = new Date().getSeconds()<10 ? '0'+new Date().getSeconds() : new Date().getSeconds();
      this.accountChangeTime = yy+'-'+mm+'-'+dd+' '+hh+':'+mf+':'+ss;
    }
  }
}
</script>