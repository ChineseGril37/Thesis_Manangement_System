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
      <el-form :model="manageForm" inline="true">
        <el-form-item label="学号/教务号" :label-width="formLabelWidth">
          <el-input v-model="manageForm.userId" autocomplete="off" clearable></el-input>
        </el-form-item >
        <el-form-item label="姓名" :label-width="formLabelWidth" clearable>
          <el-input v-model="manageForm.userRealName" autocomplete="off" clearable></el-input>
        </el-form-item>
        <el-form-item label="年龄" :label-width="formLabelWidth" clearable>
          <el-input v-model="manageForm.userAge" autocomplete="off" clearable></el-input>
        </el-form-item>
        <el-form-item label="性别" :label-width="formLabelWidth">
          <el-select v-model="manageForm.sexual" placeholder="请选择" >
            <el-option label="男" value = 1></el-option>
            <el-option label="女" value = 0></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="用户名" :label-width="formLabelWidth" clearable>
          <el-input v-model="manageForm.userName" autocomplete="off" clearable></el-input>
        </el-form-item>
        <el-form-item label="密码" :label-width="formLabelWidth" clearable>
          <el-input v-model="manageForm.passWord" autocomplete="off" clearable></el-input>
        </el-form-item>
        <el-form-item label="创建时间" :label-width="formLabelWidth" clearable>
          <el-input v-model="manageForm.accountCreateTime" autocomplete="off" clearable></el-input>
        </el-form-item>
        <el-form-item label="联系方式" :label-width="formLabelWidth" clearable>
          <el-input v-model="manageForm.phoneNum" autocomplete="off" clearable></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="userManage = false">确 定</el-button>
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
        accountCreateTime:'',
        accountChangeTime:'',
        phoneNum:'',
        email:'',
        ancestralPlace:'',
        politicalStatus:'',
        groupID:'',
        userAge:'',
        registerCode:''
      },
      formLabelWidth: '100px'
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
  }
}
</script>