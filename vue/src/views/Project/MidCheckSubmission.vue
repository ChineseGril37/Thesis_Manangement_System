<template>
  <div class="body">
    <div class="mention">
      <svg width="60" height="60" viewBox="0 0 48 48" fill="none" style="margin-top:30px;float: left;"><path d="M6 24c0-9.941 8.059-18 18-18s18 8.059 18 18-8.059 18-18 18S6 33.941 6 24zM24 28V14M24 30v4" stroke="#4E5969" stroke-width="2"/></svg>
      <div style="padding-top: 15px">
        <p class="mentionInfo">
          1、学生填写自己课题的中期检查信息。
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
                  <el-form-item class="item" label="阶段性总结" porp="midcheckSummary">
                    <el-input v-model="tableForm.midcheckSummary" type="textarea"
                              show-word-limit :autosize="{minRows: 4, maxRows: 4}"
                              :disabled="condition" :style="{width: '100%'}"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="24">
                  <el-form-item label="存在的问题" prop="midcheckProblem">
                    <el-input v-model="tableForm.midcheckProblem" type="textarea"
                              show-word-limit :autosize="{minRows: 4, maxRows: 4}"
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
                  <el-form-item label="中期检查教师审核"  porp="midcheckTeacherReview">
                    <el-input v-model="tableForm.midcheckTeacherReview" type="text" :disabled="true"></el-input>
                  </el-form-item >
                </el-col>
                <el-col :span="24">
                  <el-form-item label="中期检查专家审核"  porp="midcheckExpertReview">
                    <el-input v-model="tableForm.midcheckExpertReview" type="text" :disabled="true"></el-input>
                  </el-form-item >
                </el-col>
                <el-col :span="3">
                  <el-form-item label-width="5px" label="" prop="field114">
                    <el-button type="primary" size="middle" plain :disabled="condition" @click="processSubmit()">确认</el-button>
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
  name: "MidCheckSubmission",
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
        midcheckSummary: [{
          required: true,
          message: '阶段性总结',
          trigger: 'change'
        }],
        midcheckProblem: [{
          required: true,
          message: '研究现状',
          trigger: 'change'
        }]
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
        //因为提交的是中期检查，所以需要在任务书截止之后，开题报告截止之前
        let dateBegin = new Date(res.data.missionDeadline)
        let dateEnd = new Date(res.data.midCheckDeadline)
        //如果不在的话，显示查看按钮
        if(today < dateBegin || today > dateEnd){
          this.condition = true
        }
        //设置一下中期报告提交之后的论文初稿截止日期
        this.deadTime = this.isoDateForMat(res.data.draftThesisDeadline)
      })
      //获取当前学生的流程信息，如果没有则显示一条空信息并只能查看空信息
      await request.get('/process/listProcess',{params:that.params}).then(res =>{
        if (res.code === '200'){
          //console.log("查询到了数据")
          that.tableData = res.data
          that.condition = res.data[0].processCondition !== "任务书审核通过";
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
      await request.get('/process/listMidCheck',{params:row}).then(res=>{
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
      this.tableForm.groupID=sessionStorage.getItem("groupID")
      console.log(this.tableForm)
      await request.post('/process/createMidCheck',this.tableForm).then(res=>{
        if(res.code === '200'){
          this.tableForm.midcheckID = res.data
          this.tableForm.processCondition= "中期检查等待审核";
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
