<template>
  <div class="body">
    <div class="mention">
      <svg width="60" height="60" viewBox="0 0 48 48" fill="none" style="margin-top:30px;float: left;"><path d="M6 24c0-9.941 8.059-18 18-18s18 8.059 18 18-8.059 18-18 18S6 33.941 6 24zM24 28V14M24 30v4" stroke="#4E5969" stroke-width="2"/></svg>
      <div style="padding-top: 15px">
        <p class="mentionInfo">
          1、学生根据课题情况填写开题报告信息，填写完成后点“暂存”或者“提交”按钮，即可保存开题报告信息到系统中。
        </p>
        <p class="mentionInfo">
          2、开题报告提交后需等待指导教师的审核，待指导教师审核通过后即可完成开题报告操作。
        </p>
        <p class="mentionInfo">
          3、学生的开题报告内容需在开题报告时间范围内填写。
        </p>
        <p class="mentionInfo">
          4、 如果您的开题报告中有大量的数学公式，请以图片形式上传，或者请以附件形式上传您的开题报告到系统中。
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
        <el-table-column prop="userMajor" label="所属专业" min-width="10%" align="center"></el-table-column>
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
      <el-dialog
          :title="dialogTitle"
          :visible.sync="showDialog"
          width="45%">
        <el-row :gutter="15">
          <el-form :model="tableForm" :rules="rules" size="small" label-width="10px"
                   label-position="top" >
            <el-col>
              <el-row>
                <el-col :span="24">
                  <el-form-item label="课题名称" porp="processName">
                    <el-input v-model="tableForm.processName" placeholder="课题名称" clearable
                              :style="{width: '100%'}" :disabled="true"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="24">
                  <el-form-item class="item" label="课题目标" porp="missionGoal">
                    <el-input v-model="tableForm.missionGoal" type="textarea"
                              show-word-limit :autosize="{minRows: 4, maxRows: 4}"
                              :disabled="condition" :style="{width: '100%'}"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="24">
                  <el-form-item label="课题任务内容" prop="missionContent">
                    <el-input v-model="tableForm.missionContent" type="textarea"
                              show-word-limit :autosize="{minRows: 4, maxRows: 4}"
                              :disabled="condition" :style="{width: '100%'}"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="24">
                  <el-form-item label="课题进度安排" prop="missionPlan">
                    <el-input v-model="tableForm.missionPlan" type="textarea"
                              show-word-limit :autosize="{minRows: 4, maxRows: 4}"
                              :disabled="condition" :style="{width: '100%'}"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="24">
                  <el-form-item label="参考文献" prop="missionReferences">
                    <el-input v-model="tableForm.missionReferences" type="textarea"
                              show-word-limit :autosize="{minRows: 2, maxRows: 2}"
                              :disabled="condition" :style="{width: '100%'}"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="24">
                  <!--                  <el-form-item label="附件上传" prop="submissionFile">-->
                  <!--                    <el-upload ref="submissionFile" :file-list="fileList"-->
                  <!--                               :action="submissionFileAction" :auto-upload="false"-->
                  <!--                               :before-upload="submissionFileBeforeUpload" accept=".doc,.docx">-->
                  <!--                      <el-button size="small" type="primary" icon="el-icon-upload" :disabled="condition">上传</el-button>-->
                  <!--                      <div slot="tip" class="el-upload__tip">只能上传不超过 50MB 的.doc,.docx文件</div>-->
                  <!--                    </el-upload>-->
                  <!--                  </el-form-item>-->
                </el-col>
                <el-col :span="24">
                  <el-form-item label="任务书教师审核"  porp="submissionTeacherReview">
                    <el-input v-model="tableForm.missionTeacherReview" type="text" :disabled="true"></el-input>
                  </el-form-item >
                </el-col>
                <el-col :span="24">
                  <el-form-item label="任务书专家审核"  porp="submissionExpertReview">
                    <el-input v-model="tableForm.missionExpertReview" type="text" :disabled="true"></el-input>
                  </el-form-item >
                </el-col>
                <el-col :span="3">
                  <el-form-item label-width="5px" label="" prop="field114">
                    <el-button type="primary" size="middle" plain :disabled="condition" @click="setCurrentTime();processSubmit()">确认</el-button>
                  </el-form-item>
                </el-col>
                <el-col :span="3">
                  <el-form-item label-width="5px" label="" prop="field114">
                    <el-button plain size="middle" :disabled="condition" @click="closeDialog">取消</el-button>
                  </el-form-item>
                </el-col>
              </el-row>
            </el-col>
          </el-form>
        </el-row>
      </el-dialog>
    </div>
  </div>
</template>
<script>
import request from "@/utils/request";

export default {
  name: "MissionReportSubmission",
  data(){
    return {
      tableData: [{}],
      fileList:[],
      tableForm:{},
      showDialog:false,
      condition:false,
      deadTime:'',
      dialogTitle:"申报信息",
      formData: "",
      params:{
        processCreateBy:sessionStorage.getItem('userID'),
        processID:'',
      },
      rules: {
        missionGoal: [{
          required: true,
          message: '课题目标',
          trigger: 'change'
        }],
        missionContent: [{
          required: true,
          message: '课题任务内容',
          trigger: 'change'
        }],
        missionPlan: [{
          required: true,
          message: '课题进度安排',
          trigger: 'blur'
        }],
        missionReferences: [{
          required: true,
          message: '参考文献',
          trigger: 'blur'
        }],
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
        let today = new Date()
        //因为提交的是任务书，所以需要在开题报告之后，任务书截止之前
        let dateBegin = new Date(res.data.reportDeadline)
        let dateEnd = new Date(res.data.missionDeadline)
        //如果不在的话，显示查看按钮
        if(today < dateBegin || today > dateEnd){
          this.condition = true
        }
        //设置一下任务书截止日期
        this.deadTime = this.isoDateForMat(res.data.midCheckDeadline)
      })
      //获取当前学生的流程信息，如果没有则显示一条空信息并只能查看空信息
      await request.get('/process/listProcess',{params:that.params}).then(res =>{
        if (res.code === '200'){
          //console.log("查询到了数据")
          that.tableData = res.data
          that.condition = res.data[0].processCondition !== "开题报告审核通过";
          that.tableData.forEach((item) =>{
            item.userType=2
            item.groupID=sessionStorage.getItem("groupID")
            item.userMajor=sessionStorage.getItem("userMajor")
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
      await request.get('/process/listMission',{params:row}).then(res=>{
        if(res.code === "200"){
          this.tableForm = res.data[0]
        }
        console.log(res)
      })
      this.$set(this.tableForm, 'processName', row.processName);
      this.showDialog = true
    },
    async processSubmit(){
      this.tableForm.processDeadTime = this.deadTime
      console.log(this.tableForm)
      this.tableForm.groupID=sessionStorage.getItem("groupID")
      await request.post('/process/createMission',this.tableForm).then(res=>{
        if(res.code === '200'){
          this.tableForm.missionID = res.data
          this.tableForm.processCondition= "任务书等待审核";
        }
      })
      await request.post('/process/updateProcess',this.tableForm).then(res=>{
        if(res.code === '200'){
          this.$message.success("申报成功")
        }else {
          this.$message.error("申报失败")
        }
      })
      //this.$refs.upload.submit();
      this.tableForm={}
      await this.fetchData();
      this.showDialog = false;
    },
    uploadFile (file) {
      let formData = new FormData();
      formData.append("file", this.fileList[0].raw);//拿到存在fileList的文件存放到formData中
      //下面数据是我自己设置的数据,可自行添加数据到formData(使用键值对方式存储)
      formData.append("title", this.title);
      request().post("/file/upload", this.formData, {
        "Content-Type": "multipart/form-data;charset=utf-8"
      }).then(res => {
        if (res.data === "200") {
          this.$notify({
            title: '成功',
            message: '提交成功',
            type: 'success',
            duration: 1000
          });
        }
      })
    },
    closeDialog(){
      this.tableForm={}
      this.tableData=[{}]
      this.fetchData();
      this.showDialog = false;
    },
    handleRemove(file, fileList) {
      console.log(file, fileList);
    },
    handlePreview(file) {
      console.log(file);
    },
    beforeRemove(file, fileList) {
      return this.$confirm(`确定移除 ${ file.name }？`);
    },
    delFile () {
      this.fileList = [];
    },
    setCurrentTime() {
      //获取当前时间并打印
      let yy = new Date().getFullYear();
      let mm = new Date().getMonth() + 1;
      let dd = new Date().getDate();
      let hh = new Date().getHours();
      let mf = new Date().getMinutes() < 10 ? '0' + new Date().getMinutes() : new Date().getMinutes();
      let ss = new Date().getSeconds() < 10 ? '0' + new Date().getSeconds() : new Date().getSeconds();
      this.tableForm.processCreateTime = yy + '-' + mm + '-' + dd + ' ' + hh + ':' + mf + ':' + ss;
      this.tableForm.processChangeTime = yy + '-' + mm + '-' + dd + ' ' + hh + ':' + mf + ':' + ss;
      console.log(this.tableForm)
    },
    isoDateForMat(time) {
      let date = new Date(time)
      let year = date.getFullYear();
      let month = date.getMonth() + 1;
      let strDate = date.getDate();
      let hour = date.getHours();
      let minute = date.getMinutes();
      let second = date.getSeconds();
      month = month > 9 ? month : '0' + month
      strDate = strDate > 9 ? strDate : '0' + strDate
      hour = hour > 9 ? hour : '0' + hour
      minute = minute > 9 ? minute : '0' + minute
      second = second > 9 ? second : '0' + second
      return (year + '-' + month + '-' + strDate + ' ' + hour + ':' + minute + ':' + second);
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