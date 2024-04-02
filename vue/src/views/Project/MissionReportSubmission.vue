<template>
  <div class="body">
    <div class="mention">
      <svg width="60" height="60" viewBox="0 0 48 48" fill="none" style="margin-top:30px;float: left;"><path d="M6 24c0-9.941 8.059-18 18-18s18 8.059 18 18-8.059 18-18 18S6 33.941 6 24zM24 28V14M24 30v4" stroke="#4E5969" stroke-width="2"/></svg>
      <div style="padding-top: 15px">
        <p class="mentionInfo">
          1、学生根据课题情况填写任务书信息，填写完成后点“暂存”或者“提交”按钮，即可保存任务信息到系统中。
        </p>
        <p class="mentionInfo">
          2、学生填写的任务书内容需在填写任务书的时间范围内填写。
        </p>
      </div>
    </div>
    <div class="submission">
      <el-table
          :data="tableData"
          :row-style="{ height:'80px'}"
          style="font-size: 15px"
          :header-cell-style="{'text-align':'center','background-color':'whitesmoke'}"
          stripe
          border>
        <el-table-column prop="processID" label="序号" min-width="5%" align="center"></el-table-column>
        <el-table-column prop="processName" label="课题名称" min-width="15%" align="center"></el-table-column>
        <el-table-column prop="processMajor" label="所属专业" min-width="10%" align="center"></el-table-column>
        <el-table-column prop="processGroup" label="指导教师" min-width="10%" align="center"></el-table-column>
        <el-table-column prop="processCreateTime" label="申报日期" min-width="10%" align="center"></el-table-column>
        <el-table-column prop="processCondition" label="状态" min-width="10%" align="center"></el-table-column>
        <el-table-column  label="操作" min-width="10%" align="center">
          <template slot-scope="scope">
            <el-button type="primary" size="middle" v-if="condition === true" @click="informationView(scope.row)" plain>查看</el-button>
            <el-button type="primary" size="middle" v-else @click="informationView(scope.row)" plain>提交</el-button>
          </template>
        </el-table-column>
      </el-table>
      <MissionDialog
          v-if="showMissionDialog"
          ref="MissionDialog"
          :reportInputData="tableForm"
          :dialog-title="dialogTitle"
          :condition="condition"
          :deadTime="deadTime"
          @closeDialog="closeDialog"
      ></MissionDialog>
    </div>
  </div>
</template>
<script>
import request from "@/utils/request";
import MissionDialog from "@/components/MissionDialog.vue";

export default {
  name: "MissionReportSubmission",
  components:{MissionDialog },
  data(){
    return {
      tableData: [{}],
      tableForm:{},
      showMissionDialog:false,
      condition:false,
      deadTime:'',
      dialogTitle:"申报信息",
      params:{
        processCreateBy:sessionStorage.getItem('userID'),
        processID:''
      },

    }
  },
  created() {
    this.fetchData();
  },
  methods:{
    async fetchData() {
      const that = this;
      //先判断是不是在提交时间内
      await request.get('/date/list').then( res =>{
        //设置一下任务书截止日期
        this.deadTime = res.data.midCheckDeadline
        let today = new Date()
        //因为提交的是任务书，所以需要在开题报告之后，任务书截止之前
        let dateBegin = new Date(res.data.reportDeadline)
        let dateEnd = new Date(res.data.missionDeadline)
        //如果不在的话，显示查看按钮
        if(today < dateBegin || today > dateEnd){
          this.condition = true
        }
      })
      //获取当前学生的流程信息，如果没有则显示一条空信息并只能查看空信息
      await request.get('/process/listProcess',{params:that.params}).then(res =>{
        if (res.code === '200'){
          //console.log("查询到了数据")
          that.tableData = res.data
          that.condition = res.data[0].processCondition !== "开题报告审核通过";
          that.tableData.forEach((item) =>{
            item.userType=2
            request.get('/user/listGroup',{params:item}).then(res=>{
              if(res.code === '200'){
                this.$set(item,"processGroup",res.data[0].userRealName)
              }else {
                this.$set(item,"processGroup","查询失败")
              }
            })
          })
        }
      })
    },
    async informationView(row){
      this.tableForm = row
      this.tableForm.deadTime = this.deadTime
      await request.get('/process/listMission',{params:row}).then(res=>{
        if(res.code === "200"){
          this.tableForm = res.data[0]
        }
      })
      //因为弹窗里需要展示课题名称，所以把row里的课题名称赋给tableForm传进弹窗
      this.$set(this.tableForm, 'processName', row.processName);
      this.showMissionDialog = true
      this.$nextTick(() => {
        this.$refs["MissionDialog"].showMissionDialog = true;
      });
    },
    closeDialog(){
      this.fetchData();
      this.showMissionDialog = false
    },
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
  padding: 25px;
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
