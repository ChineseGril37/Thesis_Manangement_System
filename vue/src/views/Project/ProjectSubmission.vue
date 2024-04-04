<template>
  <div class="body">
    <div class="mention">
      <svg width="60" height="60" viewBox="0 0 48 48" fill="none" style="margin-top:30px;float: left;"><path d="M6 24c0-9.941 8.059-18 18-18s18 8.059 18 18-8.059 18-18 18S6 33.941 6 24zM24 28V14M24 30v4" stroke="#4E5969" stroke-width="2"/></svg>
      <div style="padding-top: 15px">
        <p class="mentionInfo">
          1、学生填写申报课题信息，填写完成后根据课题填写的情况，点“提交”按钮，即可保存课题到系统中。
        </p>
        <p class="mentionInfo">
          2、学生申报课题要选择课题的指导教师，并在课题申报时间范围内申报并填写课题申报界面内容。
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
        <el-table-column prop="processID" label="流程序号" min-width="5%" align="center"></el-table-column>
        <el-table-column prop="processName" label="课题名称" min-width="15%" align="center"></el-table-column>
        <el-table-column prop="processMajor" label="所属专业" min-width="10%" align="center"></el-table-column>
        <el-table-column prop="processGroup" label="指导教师" min-width="10%" align="center"></el-table-column>
        <el-table-column prop="processCreateTime" label="申报日期" min-width="10%" align="center"></el-table-column>
        <el-table-column prop="processCondition" label="状态" min-width="10%" align="center"></el-table-column>
        <el-table-column  label="操作" min-width="10%" align="center">
          <template slot-scope="scope">
            <el-button type="primary" size="middle" v-if="scope.row.condition" @click="informationView(scope.row)" plain>查看</el-button>
            <el-button type="primary" size="middle" v-else @click="informationSubmit(scope.row)" plain>提交</el-button>
          </template>
        </el-table-column>
      </el-table>
        <SubmissionDialog
            v-if="showSubmissionDialog"
            ref="SubmissionDialog"
            :submissionInputData="tableForm"
            :dialog-title="dialogTitle"
            :condition="condition"
            :deadTime="deadTime"
            @closeDialog="closeDialog"
        ></SubmissionDialog>
    </div>
  </div>
</template>
<script>
import request from "@/utils/request";
import SubmissionDialog from "@/components/SubmissionDialog.vue";
export default {
  name: "ProjectSubmission",
  components:{ SubmissionDialog },
  data(){
    return {
      tableData: [],
      tableForm:{},
      showSubmissionDialog:false,
      //condition负责判断弹窗内是否需要禁止输入和提交,row.condition负责当前行的按钮显示
      condition:false,
      deadTime:'',
      dialogTitle:"申报信息",
      params:{
        processCreateBy:sessionStorage.getItem('userID'),
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
      await request.get('/date/list').then( res=> {
        //设置好提交后的下一个流程(开题报告)截止日期
        this.deadTime = res.data.reportDeadline
        let today = new Date()
        let dateBegin = new Date(res.data.submissionBegin)
        let dateEnd = new Date(res.data.submissionEnd)
        //如果当前日期不在课题申报的开始和截止日期，将condition设置为true，只有false才能进行申报
        if(today < dateBegin || today > dateEnd){
          this.condition = true
        }
      })
      //获取当前学生的流程信息，如果没有则默认显示一条空信息，如果在申报期内显示提交否则显示查看
      //params中存储信息：从登录session中读取的userID,去查询同一userID的process流程信息列表
      await request.get('/process/listProcess',{params:that.params}).then(res =>{
        let judge = true
        if (res.code === '200'){
          //console.log("如果查询到了数据")
          that.condition = true
          that.tableData = res.data
          //遍历刚才读取的到tableData中的每一条process信息，设置userType为2=教师,每条item查询process绑定小组所属的教师名称
          that.tableData.forEach((item) =>{
            if(item.processCondition !== '课题申报审核驳回'){
              judge = false
            }
            //每一个能查到的tableData都统统改成true显示查看，无论是什么状态反正都已经提交了
            item.condition = true
            item.userType=2
            //通过每个流程的小组ID查询指导老师的姓名
            request.get('/user/listGroup',{params:item}).then(res=>{
              if(res.code === '200'){
                this.$set(item,"processGroup",res.data[0].userRealName)
              }else {
                this.$set(item,"processGroup","查询失败")
              }
            })
            console.log(judge)
          })
        }
        if(judge){
          that.condition = false
          that.tableData.push({})
        }
      })
    },
    async informationSubmit(row){
      // row存储单条process信息，用row中保存的submissionID去查询申报信息，
      // 因为后台返回的是列表但我们ID对应的有且只有一条，所以使用data[0]给tableForm赋值
      // 给tableForm加一个fetchData里读出的下一流程deadTime，便于课程申报后更新截止日期
      this.tableForm = row
      this.tableForm.deadTime = this.deadTime
      //这里可以直接用row或者赋值后的tableForm，其实只需要这条process中的submissionID
      await request.get('/process/listSubmission',{params:row}).then(res=>{
        if(res.code === "200"){
          this.tableForm = res.data[0]
        }
      })
      //因为弹窗里需要展示课题名称，所以把row里的课题名称赋给tableForm传进弹窗
      this.$set(this.tableForm, 'processName', row.processName);
      //开启弹窗
      this.showSubmissionDialog = true
      this.$nextTick(() => {
        this.$refs["SubmissionDialog"].showSubmissionDialog = true;
      });
    },
    async informationView(row){
      this.condition = true
      this.tableForm = row
      this.tableForm.deadTime = this.deadTime
      //这里可以直接用row或者赋值后的tableForm，其实只需要这条process中的submissionID
      await request.get('/process/listSubmission',{params:row}).then(res=>{
        if(res.code === "200"){
          this.tableForm = res.data[0]
        }
      })
      //因为弹窗里需要展示课题名称，所以把row里的课题名称赋给tableForm传进弹窗
      this.$set(this.tableForm, 'processName', row.processName);
      console.log(this.tableForm)
      //开启弹窗
      this.showSubmissionDialog = true
      this.$nextTick(() => {
        this.$refs["SubmissionDialog"].showSubmissionDialog = true;
      });
    },
    closeDialog(){
      this.tableData = []
      this.fetchData();
      this.showSubmissionDialog = false
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
