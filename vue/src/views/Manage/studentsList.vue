<template>
  <div style="padding-left: 20px;margin-top: 20px">
    <!-- 搜索表单 -->
    <div style="margin-bottom: 20px">
      <el-input style="width: 240px" placeholder="请输入学号" v-model="params.userId"></el-input>
      <el-input style="width: 240px;margin-left: 10px" placeholder="请输入姓名" v-model="params.userRealName"></el-input>
      <el-button style="margin-left: 5px" type="primary" @click="load"><i class="el-icon-search"></i><span>搜索</span></el-button>
      <el-button style="margin-left: 5px" type="warning" @click="reset"><i class="el-icon-refresh"></i><span>重置</span></el-button>
    </div>
    <!--  数据表单  -->
    <el-table :data="tableData" stripe>
      <el-table-column prop="userId" label="学号" width="180"></el-table-column>
      <el-table-column prop="userRealName" label="姓名" width="180"></el-table-column>
      <el-table-column prop="userAge" label="年龄" width="180"></el-table-column>
      <el-table-column prop="sexual" label="性别" width="180">
        <template slot-scope="scope">
          {{ scope.row.sexual === '1' ? '男' : '女' }}
        </template>
      </el-table-column>
      <el-table-column prop="groupID" label="分组" width="180"></el-table-column>
      <el-table-column prop="ancestralPlace" label="籍贯" width="180"></el-table-column>
      <el-table-column prop="politicalStatus" label="政治面貌"></el-table-column>
      <el-table-column prop="phoneNum" label="联系方式"></el-table-column>
      <el-table-column prop="email" label="邮箱"></el-table-column>
    </el-table>
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
// @ is an alias to /src
import HelloWorld from '@/components/HelloWorld.vue'
import request from "@/utils/request";

export default {
  name: 'studentsList',
  data(){
    return{
      tableData:[],
      total: 0,
      params:{
        userType: 3,
        pageNum: 1,
        pageSize: 10,
        userRealName: '',
        userId: ''
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
      this.params = {
        userType: 3,
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
    }
  }
}
</script>