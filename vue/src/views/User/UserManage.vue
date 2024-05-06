<template>
  <div style="padding-left: 20px;margin-top: 20px">
    <!-- 搜索表单 -->
    <div style="margin-bottom: 20px">
      <el-input style="width: 240px" placeholder="请输入学号" v-model="params.userId"></el-input>
      <el-input style="width: 240px;margin-left: 10px" placeholder="请输入姓名" v-model="params.userRealName"></el-input>
      <el-button style="margin-left: 5px" type="primary" @click="load"><i class="el-icon-search"></i><span>搜索</span></el-button>
      <el-button style="margin-left: 5px" type="warning" @click="reset"><i class="el-icon-refresh"></i><span>重置</span></el-button>
      <el-button style="margin-left: 5px" type="primary"  @click="addItem">添加用户</el-button>

    </div>
    <!--  数据表单  -->
    <el-table
        v-loading="tableLoading"
        :data="tableData"
        :row-style="{ height:'80px'}"
        style="font-size: 15px"
        stripe
        :cell-style="cellStyle"
        :header-cell-style="{'text-align':'center'}">
      <el-table-column prop="userId" label="学号/教务号" min-width="10%"></el-table-column>
      <el-table-column prop="userRealName" label="姓名" min-width="8%"></el-table-column>
      <el-table-column prop="userAge" label="年龄" min-width="5%"></el-table-column>
      <el-table-column prop="userAcademy" label="所属学院" min-width="12%"></el-table-column>
      <el-table-column prop="userMajor" label="所属专业" min-width="12%"></el-table-column>
      <el-table-column prop="userClass" label="所属班级" min-width="6%"></el-table-column>
      <el-table-column prop="sexual" label="性别" min-width="6%" >
        <template slot-scope="scope">
          {{ scope.row.sexual === '1' ? '男' : '女' }}
        </template>
      </el-table-column>
      <el-table-column prop="groupID" label="分组" min-width="6%"></el-table-column>
      <el-table-column prop="ancestralPlace" label="籍贯" min-width="10%"></el-table-column>
      <el-table-column prop="politicalStatus" label="政治面貌" min-width="10%"></el-table-column>
      <el-table-column prop="phoneNum" label="联系方式" min-width="12%"></el-table-column>
      <el-table-column prop="email" label="邮箱" min-width="12%"></el-table-column>
      <el-table-column prop="accountChangeTime" label="修改时间" min-width="20%"></el-table-column>
      <el-table-column label="操作" min-width="20%">
        <template v-slot="scope">
          <el-button @click="editRow(scope.row);" style="font-size: 15px">编辑</el-button>
          <el-popconfirm
              style="margin-left: 5px"
              title="确认要删除吗？"
              @confirm="del(scope.row);fetchData()"
          >
            <el-button type="danger" slot="reference" style="font-size: 15px">删除</el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
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
    <!--弹框组件开始-----------------------start-->
    <UserDialog
        v-if="showDialog"
        ref="UserDialog"
        :dialog-title="dialogTitle"
        :editInForm="tableDataRow"
        @closeDialog="closeDialog"
    ></UserDialog>
    <!--弹框组件开始-----------------------end-->
  </div>
</template>

<script>
import request from "@/utils/request";
import UserDialog from "@/components/UserDialog.vue";
export default {
  name: "UserManage",
  components:{ UserDialog },
  data(){
    return{
      showDialog:false,
      showDeleteDialog:false,
      tableLoading:false,
      dialogTitle: "添加人员",
      total: 0,
      tableData:[],
      tableDataRow:{},
      deleteData:[],
      params:{
        pageNum: 1,
        pageSize: 10,
        userRealName: '',
        userId: '',
        userName:''
      },
      formLabelWidth: '100px',
    }
  },
  created() {
    this.load()
  },
  mounted() {
    this.fetchData();
  },
  methods:{
    // 获取表格数据
    // 这里最好把tableData换一个，这tableData是表格数据，给弹窗的应该是表格里面对应的行
    fetchData() {
      //  console.log(JSON.parse(JSON.stringify(this.tableDataRow)));
      const that = this;
      that.tableLoading = true;
      request.get('/user/page', {
        params: this.params
      }).then(res =>{
        if(res.code === '200'){
          console.log(res.data)
          that.tableData = res.data.list
          that.total = res.data.total
        }
      })
      setTimeout(() => {
        that.tableLoading = false;
      }, 500  );
    },
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
    addItem() {
      this.tableDataRow = {}
      this.dialogTitle = "添加人员";
      this.showDialog = true;
      this.$nextTick(() => {
        this.$refs["UserDialog"].showDialog = true;
      });
    },
    editRow(row) {
      this.tableDataRow = row;
      this.dialogTitle = "编辑人员";
      this.showDialog = true;
      this.$nextTick(() => {
        this.$refs["UserDialog"].showDialog = true;
      });
    },
    del(row){
      this.deleteData={userId:row.userId}
      console.log(this.deleteData)
      request.delete("/user/delete" ,{params:this.deleteData}).then(res =>{
        if(res.code === '200'){
          this.$notify.success("删除成功")
          this.fetchData();
        }else {
          this.$notify.error(res.msg)
        }
      })
    },
    closeDialog(flag) {
      if (flag) {
        // 重新刷新表格内容
        this.fetchData();
        this.$refs.UserDialog.resetFields();
      }
      this.showDialog = false;
    },
    reset(){
      //重置当前
      this.params = {
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
    //设置表格内容居中
    cellStyle({row, column, rowIndex, columnIndex}) {
      return {'text-align': 'center'};
    }
  }
}
</script>
