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
          width="30%">
        <el-row :gutter="15">
          <el-form :model="tableForm" :rules="rules" size="small" label-width="10px"
                   label-position="top" >
            <el-col>
              <el-row>
                <el-col :span="24">
                  <el-form-item label="课题名称" porp="processName">
                    <el-input v-model="tableForm.processName" placeholder="课题名称" clearable
                              prefix-icon='el-icon-edit-outline' :style="{width: '100%'}" :disabled="condition"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="12">
                  <el-form-item label="是否以实验、实习、工程实践和社会调查为基础" porp="submissionBase">
                    <el-select v-model="tableForm.submissionBase" :disabled="condition" placeholder="请选择" :style="{width: '100%'}">
                      <el-option label="是" value = 1></el-option>
                      <el-option label="否" value = 0></el-option>
                    </el-select>
                  </el-form-item>
                </el-col>
                <el-col :span="12">
                  <el-form-item label="课题类别" porp="submissionType">
                    <el-select v-model="tableForm.submissionType" :disabled="condition" placeholder="请选择" style="width: 100%;">
                      <el-option label="毕业设计" value = "毕业设计"></el-option>
                      <el-option label="毕业论文" value = "毕业论文"></el-option>
                    </el-select>
                  </el-form-item >
                </el-col>
                <el-col :span="24">
                  <el-form-item label="选题依据及课题简介" prop="submissionBrief">
                    <el-input v-model="tableForm.submissionBrief" type="textarea" placeholder="选题依据及课题简介"
                              show-word-limit :autosize="{minRows: 4, maxRows: 4}"
                              :disabled="condition" :style="{width: '100%'}"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="24">
                  <el-form-item label="论文研究方向" prop="submissionDirection">
                    <el-input v-model="tableForm.submissionDirection" placeholder="论文研究方向" clearable
                              :style="{width: '100%'}" :disabled="condition"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="撰写语种" prop="submissionLanguage">
                    <el-input v-model="tableForm.submissionLanguage" placeholder="撰写语种" clearable
                              :style="{width: '100%'}" :disabled="condition"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="24">
                  <el-form-item label="附件上传" prop="submissionFile">
                    <el-upload ref="submissionFile" :file-list="fileList"
                               :action="submissionFileAction" :auto-upload="false"
                               :before-upload="submissionFileBeforeUpload" accept=".doc,.docx">
                      <el-button size="small" type="primary" icon="el-icon-upload" :disabled="condition">上传</el-button>
                      <div slot="tip" class="el-upload__tip">只能上传不超过 50MB 的.doc,.docx文件</div>
                    </el-upload>
                  </el-form-item>
                </el-col>
                <el-col :span="24">
                  <el-form-item label="专业教师审核"  porp="submissionTeacherReview">
                    <el-input v-model="tableForm.submissionTeacherReview" type="text" :disabled="true"></el-input>
                  </el-form-item >
                </el-col>
                <el-col :span="24">
                  <el-form-item label="专业专家审核"  porp="submissionExpertReview">
                  <el-input v-model="tableForm.submissionExpertReview" type="text" :disabled="true"></el-input>
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
  name: "ProjectSubmission",
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
        processName: [{
          required: true,
          message: '课题名称',
          trigger: 'blur'
        }],
        submissionBase: [{
          required: true,
          message: '是',
          trigger: 'change'
        }],
        submissionType: [{
          required: true,
          message: '',
          trigger: 'change'
        }],
        submissionBrief: [{
          required: true,
          message: '选题依据及课题简介',
          trigger: 'blur'
        }],
        submissionDirection: [{
          required: true,
          message: '论文研究方向',
          trigger: 'blur'
        }],
        submissionLanguage: [{
          required: true,
          message: '撰写语种',
          trigger: 'blur'
        }],
      },
      submissionFileAction: '/file/upload',
      submissionFilefileList: [],
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
        let dateBegin = new Date(res.data.submissionBegin)
        let dateEnd = new Date(res.data.submissionEnd)
        if(today < dateBegin || today > dateEnd){
          this.condition = true
        }
        //设置一下课题申报截止日期
        this.deadTime = this.isoDateForMat(res.data.reportDeadline)
      })
      //获取当前学生的流程信息，如果没有则显示一条空信息，如果在申报期内显示提交否则显示查看
      await request.get('/process/listProcess',{params:that.params}).then(res =>{
        if (res.code === '200'){
          //console.log("查询到了数据")
          that.tableData = res.data
          that.condition = true
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
      await request.get('/process/listSubmission',{params:row}).then(res=>{
        if(res.code === "200"){
          this.tableForm = res.data[0]
        }
      })
      this.$set(this.tableForm, 'processName', row.processName);
      this.showDialog = true
    },
    async processSubmit(){
      this.tableForm.processDeadTime = this.deadTime
      this.tableForm.groupID = sessionStorage.getItem('groupID')
      console.log(this.tableForm)
      await request.post('/process/createSubmission',this.tableForm).then(res=>{
        if(res.code === '200'){
          this.tableForm.submissionID = res.data
          this.tableForm.processCreateBy = sessionStorage.getItem('userID')
          this.tableForm.groupID=sessionStorage.getItem("groupID")
          this.tableForm.processCondition= "课题申报等待审核";
          console.log("2")
        }
      })
      await request.post('/process/createProcess',this.tableForm).then(res=>{
        this.$message.success("申报成功")
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