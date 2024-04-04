<template>
  <div class="body">
    <div class="mention">
      <svg width="60" height="60" viewBox="0 0 48 48" fill="none" style="margin-top:30px;float: left;"><path d="M6 24c0-9.941 8.059-18 18-18s18 8.059 18 18-8.059 18-18 18S6 33.941 6 24zM24 28V14M24 30v4" stroke="#4E5969" stroke-width="2"/></svg>
      <div style="padding-top: 15px">
        <p class="mentionInfo">
          1、教师可查看指导学生的流程进度，点“审核”按钮，即可查看学生课题并进行审核。
        </p>
        <p class="mentionInfo">
          2、教务可查看学院下学生的流程进度，点“审核”按钮，即可查看学生课题并进行审核。
        </p>
      </div>
    </div>
    <div class="submission">
      <!-- 搜索表单 -->
      <div style="margin-bottom: 20px">
        <el-input style="width: 240px" placeholder="请输入学号" v-model="params.userID"></el-input>
        <el-button style="margin-left: 5px" type="primary" @click="search"><i class="el-icon-search"></i><span>搜索</span></el-button>
        <el-button style="margin-left: 5px" type="warning" @click="reset"><i class="el-icon-refresh"></i><span>重置</span></el-button>
      </div>
      <el-table
          v-loading="tableLoading"
          :data="tableData"
          :row-style="{ height:'80px' }"
          style="font-size: 15px"
          stripe
          :cell-style="cellStyle"
          :header-cell-style="{'text-align':'center'}">
        <el-table-column prop="processName" label="课题名称" min-width="15%"></el-table-column>
        <el-table-column prop="processCreateBy" label="所属学生" min-width="5%"></el-table-column>
        <el-table-column prop="groupID" label="所属小组" min-width="10%"></el-table-column>
        <el-table-column prop="processChangeTime" label="流程更新日期" min-width="10%"></el-table-column>
        <el-table-column prop="processDeadTime" label="流程截止日期" min-width="10%"></el-table-column>
        <el-table-column prop="processCondition" label="流程状态" min-width="10%"></el-table-column>
        <el-table-column label="操作" min-width="5%">
        <template v-slot="scope">
          <el-button size="middle" @click="Review(scope.row);" style="font-size: 15px">审核</el-button>
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
      <!--四种弹窗审核开始-->
      <SubmissionDialog
          v-if="showSubmissionDialog"
          ref="SubmissionDialog"
          :submissionInputData="tableForm"
          :dialog-title="dialogTitle"
          :condition="condition"
          @closeDialog="closeDialog"
      ></SubmissionDialog>
      <ReportDialog
          v-if="showReportDialog"
          ref="ReportDialog"
          :reportInputData="tableForm"
          :dialog-title="dialogTitle"
          :condition="condition"
          @closeDialog="closeDialog"
      ></ReportDialog>
      <MissionDialog
          v-if="showMissionDialog"
          ref="MissionDialog"
          :reportInputData="tableForm"
          :dialog-title="dialogTitle"
          :condition="condition"
          @closeDialog="closeDialog"
      ></MissionDialog>
      <MidCheckDialog
          v-if="showMidCheckDialog"
          ref="MidCheckDialog"
          :midCheckInputData="tableForm"
          :dialog-title="dialogTitle"
          :condition="condition"
          @closeDialog="closeDialog"
      ></MidCheckDialog>
      <!--四种弹窗审核结束-->
    </div>
  </div>
</template>
<script>
import request from "@/utils/request";
import MidCheckDialog from "@/components/MidCheckDialog.vue";
import SubmissionDialog from "@/components/SubmissionDialog.vue";
import ReportDialog from "@/components/ReportDialog.vue";
import MissionDialog from "@/components/MissionDialog.vue";

export default {
  name: "ProcessManage",
  components:{SubmissionDialog,ReportDialog,MissionDialog,MidCheckDialog},
  data(){
    return{
      total: 0,
      tableData:[],
      tableForm:{},
      tableLoading:false,
      condition:true,
      showSubmissionDialog:false,
      showReportDialog:false,
      showMissionDialog:false,
      showMidCheckDialog:false,
      dialogTitle:"审核信息",
      params:{
        userID:undefined,
        groupID:undefined,
        userType:sessionStorage.getItem("userType"),
        pageNum: 1,
        pageSize: 10
      },
    }
  },
  created() {
    this.fetchData()
  },
  methods:{
    fetchData(){
      this.tableLoading = true;
      if(this.params.userType === '2'){
        this.params.groupID=sessionStorage.getItem('groupID')
      }
      request.get('/process/listByProcess',{params:this.params}).then( res =>{
        this.tableData = res.data.list
      })
      setTimeout(() => {
        this.tableLoading = false;
      }, 400  );
    },
    //根据搜索内容自定义查询学生课题(学生姓名\学号)
    search(){
      this.tableLoading = true;
      request.get('/process/listByProcess',{params:this.params}).then( res=>{
        if(res.code === '200'){
          this.tableData = res.data.list
          this.total = res.data.total
        }else {
          this.tableData = []
          this.total = 1
        }
      })
      setTimeout(() => {
        this.tableLoading = false;
      }, 300  );
    },
    reset(){
      this.params={
        pageNum: 1,
        pageSize: 10,
        userID:undefined,
        groupID:undefined,
        userType:sessionStorage.getItem("userType")
      }
      this.fetchData()
    },
    async Review(row){
      switch (row.processCondition){
        case '课题申报等待审核':{
          //这里可以直接用row或者赋值后的tableForm，其实只需要这条process中的submissionID
          await request.get('/process/listSubmission',{params:row}).then(res=>{
            if(res.code === "200"){
              //因为弹窗里需要展示课题名称，所以把row里的课题名称赋给tableForm传进弹窗
              this.tableForm = res.data[0]
              this.tableForm.processID = row.processID
              this.tableForm.processName=row.processName
            }
          })
          //开启弹窗
          this.showSubmissionDialog = true
          this.$nextTick(() => {
            this.$refs["SubmissionDialog"].showSubmissionDialog = true;
          });}
          break;
        case '开题报告等待审核':{
          await request.get('/process/listReport',{params:row}).then(res=>{
          if(res.code === "200"){
            this.tableForm = res.data[0]
            this.tableForm.processID = row.processID
            this.tableForm.processName=row.processName
          }
        })
          //开启弹窗
          this.showReportDialog = true
          this.$nextTick(() => {
            this.$refs["ReportDialog"].showReportDialog = true;
          })}
          break;
        case '任务书等待审核':{
          await request.get('/process/listMission',{params:row}).then(res=>{
            if(res.code === "200"){
              this.tableForm = res.data[0]
              this.tableForm.processID = row.processID
              this.tableForm.processName=row.processName
            }
          })
          //开启弹窗
          this.showMissionDialog = true
          this.$nextTick(() => {
            this.$refs["MissionDialog"].showMissionDialog = true;
          });
        }break;
        case '中期检查等待审核':{
          await request.get('/process/listMidCheck',{params:row}).then(res=>{
            if(res.code === "200"){
              this.tableForm = res.data[0]
              this.tableForm.processID = row.processID
              this.tableForm.processName=row.processName
            }
          })
          //因为弹窗里需要展示课题名称，所以把row里的课题名称赋给tableForm传进弹窗
          //开启弹窗
          this.showMidCheckDialog = true
          this.$nextTick(() => {
            this.$refs["MidCheckDialog"].showMidCheckDialog = true;
          });
        }break;
        default:this.$message.error("当前流程暂不需要审核！")
      }
    },
    closeDialog(){
      this.fetchData();
      this.showSubmissionDialog = false
      this.showReportDialog = false
      this.showMissionDialog = false
      this.showMidCheckDialog = false
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
<style scoped>
.body {
  min-height:calc(100vh - 110px);
  width: 100%;
  border-radius:5px;
  padding: 10px;
}
.mention{
  height: 120px;
  width: 100%;
  background-color:white;
  box-shadow: 0 0 5px 1px rgba(153, 153, 153, 0.5);
  border-radius:5px;
  padding: 0 20px 0 10px;
  flex-direction: column;
}
.mentionInfo{
  font-size: 17px;
  float: unset;
  margin: 0;
}
.submission{
  margin-top: 15px;
  padding: 1%;
  height: calc(100vh - 265px);
  width: 100%;
  background-color:white;
  box-shadow: 0 0 5px 1px rgba(153, 153, 153, 0.5);
  border-radius:5px;
}
/deep/ .el-form-item__label{
  font-size: 15px;
}
</style>
