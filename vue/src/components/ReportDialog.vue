<template>
  <el-dialog
      class="reportDialog"
      :title="dialogTitle"
      :visible.sync="showReportDialog"
      @close="closeDialog">
    <el-row :gutter="15">
      <el-form :model="reportData"
               :rules="rules"
               ref="reportData"
               size="small"
               label-width="10px"
               label-position="top" >
        <el-col>
          <el-row>
            <el-col :span="24">
              <el-form-item label="课题名称" porp="processName">
                <el-input v-model="reportData.processName"
                          placeholder="课题名称"
                          clearable
                          :style="{width: '100%'}"
                          :disabled="true"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="24">
              <el-form-item class="item" label="研究目的" porp="reportMeaning">
                <el-input v-model="reportData.reportMeaning" type="textarea"
                          show-word-limit :autosize="{minRows: 4, maxRows: 4}"
                          :disabled="condition" :style="{width: '100%'}"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="24">
              <el-form-item label="研究现状" prop="reportSituation">
                <el-input v-model="reportData.reportSituation" type="textarea"
                          show-word-limit :autosize="{minRows: 4, maxRows: 4}"
                          :disabled="condition" :style="{width: '100%'}"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="24">
              <el-form-item label="研究目标" prop="reportAim">
                <el-input v-model="reportData.reportAim" type="textarea"
                          show-word-limit :autosize="{minRows: 4, maxRows: 4}"
                          :disabled="condition" :style="{width: '100%'}"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="24">
              <el-form-item label="研究方案" prop="reportWay">
                <el-input v-model="reportData.reportWay" type="textarea"
                          show-word-limit :autosize="{minRows: 5, maxRows: 5}"
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
            <el-form-item label="专业教师审核" porp="reportTeacherReview">
              <el-select v-model="reportData.reportTeacherReview"
                         :disabled="disableTeacher"
                         placeholder="请选择"
                         style="width: 100%;">
                <el-option label="审核通过" value = 1></el-option>
                <el-option label="审核驳回" value = 2></el-option>
              </el-select>
            </el-form-item >
          </el-col>
            <el-col :span="24">
              <el-form-item label="专业专家审核" porp="reportExpertReview">
                <el-select v-model="reportData.reportExpertReview"
                           :disabled="disableManager"
                           placeholder="请选择"
                           style="width: 100%;">
                  <el-option label="审核通过" value = 1></el-option>
                  <el-option label="审核驳回" value = 2></el-option>
                </el-select>
              </el-form-item >
            </el-col>
            <el-col :span="2">
              <el-form-item label-width="5px" prop="confirmButton">
                <el-button type="primary" size="middle" plain :disabled="conditionInfo" @click="processSubmit()">确认</el-button>
              </el-form-item>
            </el-col>
            <el-col :span="2">
              <el-form-item label-width="5px" prop="cancelButton">
                <el-button plain size="middle" :disabled="conditionInfo" @click="closeDialog()">取消</el-button>
              </el-form-item>
            </el-col>
          </el-row>
        </el-col>
      </el-form>
    </el-row>
  </el-dialog>
</template>
<script>
import {setCurrentTime} from "@/utils/common";
import request from "@/utils/request";

export default {
  name: "ReportDialog",
  props:{
    deadTime:{
      type: String
    },
    condition:{
      type: Boolean,
      default: true
    },
    showReportDialog:{
      type: Boolean,
      default: false
    },
    dialogTitle:{
      type: String,
      default: "申报信息"
    },
    reportInputData:{
      type: Object,
      default: function (){
        return {};
      }
    },

  },
  created(){
    this.checkType();
  },
  data(){
    return{
      reportData:JSON.parse(JSON.stringify(this.reportInputData)),
      disableTeacher:true,
      disableManager:true,
      conditionInfo:this.condition,
      rules: {
        reportMeaning: [{
          required: true,
          message: '研究目的',
          trigger: 'blur'
        }],
        reportSituation: [{
          required: true,
          message: '研究现状',
          trigger: 'blur'
        }],
        reportAim: [{
          required: true,
          message: '研究目标',
          trigger: 'blur'
        }],
        reportWay: [{
          required: true,
          message: '研究方案',
          trigger: 'blur'
        }],
      },
    }
  },
  methods:{
    checkType(){
      if(this.reportData.reportTeacherReview === 1){
        this.reportData.reportTeacherReview = '审核通过'
      } else if(this.reportData.submissionTeacherReview === 2){
        this.reportData.submissionTeacherReview = '审核驳回'
      }
      if(this.reportData.reportExpertReview === 1){
        this.reportData.reportExpertReview = '审核通过'
      } else if(this.reportData.reportExpertReview === 2){
        this.reportData.reportExpertReview = '审核驳回'
      }
      if(this.reportData.reportTeacherReview === null && this.reportData.groupID === sessionStorage.getItem('groupID') && sessionStorage.getItem('userType') === '2'){
        this.disableTeacher = false
        this.conditionInfo = false
      }
      if(this.reportData.reportExpertReview === null && (sessionStorage.getItem('userType') === '1' || sessionStorage.getItem('userType') === '0')){
        this.disableManager = false
        this.conditionInfo = false
      }
    },
    async processSubmit(){
      //如果是小组教师或者教务\管理员，那这个页面处于审核流程，update审核流程,否则是学生在进行新report创建并更新流程进度
      if(!this.disableTeacher || !this.disableManager){
        await request.post('/process/updateReport',this.reportData)
        //如果教师和专家都审核通过，更新流程状态
        if((this.reportData.reportTeacherReview === '审核通过' || this.reportData.reportTeacherReview === 1) && (this.reportData.reportExpertReview === '审核通过' || this.reportData.reportExpertReview === '审核通过')){
          await request.post('/process/updateProcess',this.reportData)
          this.reportData.processCondition = "开题报告审核通过"
        }
        this.$message.success("审核提交成功")
      }
      else {
        this.reportData.processChangeTime = setCurrentTime();
        this.reportData.processDeadTime = this.deadTime
        this.reportData.groupID = sessionStorage.getItem('groupID')
        await request.post('/process/createReport',this.reportData).then(res=>{
          if(res.code === '200'){
            this.reportData.reportID = res.data
            this.reportData.processCondition= "开题报告等待审核";
          }
        })
        await request.post('/process/updateProcess',this.reportData).then(res=>{
          this.$message.success("开题报告申报成功")
        })
      }
      this.closeDialog()
    },
    closeDialog(){
      console.log("closeDialog被调用")
      this.$refs["reportData"].resetFields();
      this.showReportDialog = false;
      this.$emit("showReportDialog",false)
      this.$emit("closeDialog");
    },
  }
}
</script>
<style scoped>

</style>
