<template>
  <el-dialog
      class="submissionDialog"
      :title="dialogTitle"
      :visible.sync="showSubmissionDialog"
      @close="closeDialog"
  >
      <el-row :gutter="15">
        <el-form :model="submissionData"
                 :rules="rules"
                 ref="submissionData"
                 label-width="10px"
                 label-position="top" >
          <el-col>
            <el-row>
              <el-col :span="24">
                <el-form-item label="课题名称" porp="processName">
                  <el-input v-model="submissionData.processName"
                            placeholder="课题名称"
                            clearable
                            :style="{width: '100%'}"
                            :disabled="condition"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="是否以实验、实习、工程实践和社会调查为基础" porp="submissionBase">
                  <el-select v-model="submissionData.submissionBase"
                             :disabled="condition"
                             placeholder="请选择"
                             style="width: 100%;">
                    <el-option label="是" value = 1></el-option>
                    <el-option label="否" value = 0></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="课题类别" porp="submissionType">
                  <el-select v-model="submissionData.submissionType"
                             :disabled="condition"
                             placeholder="请选择"
                             style="width: 100%;">
                    <el-option label="毕业设计" value = "毕业设计"></el-option>
                    <el-option label="毕业论文" value = "毕业论文"></el-option>
                  </el-select>
                </el-form-item >
              </el-col>
              <el-col :span="24">
                <el-form-item label="选题依据及课题简介" prop="submissionBrief">
                  <el-input v-model="submissionData.submissionBrief"
                            type="textarea"
                            placeholder="选题依据及课题简介"
                            show-word-limit
                            :autosize="{minRows: 6, maxRows: 6}"
                            :disabled="condition"
                            :style="{width: '100%'}"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="24">
                <el-form-item label="论文研究方向" prop="submissionDirection">
                  <el-input v-model="submissionData.submissionDirection"
                            placeholder="论文研究方向"
                            clearable
                            style="width: 100%;"
                            :disabled="condition"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="撰写语种" prop="submissionLanguage">
                  <el-input v-model="submissionData.submissionLanguage"
                            placeholder="撰写语种"
                            clearable
                            :style="{width: '100%'}"
                            :disabled="condition"></el-input>
                </el-form-item>
              </el-col>
<!--              <el-col :span="24">-->
<!--                <el-form-item label="附件上传" prop="submissionFile">-->
<!--                  <el-upload ref="submissionFile" :file-list="fileList"-->
<!--                             :action="submissionFileAction" :auto-upload="false"-->
<!--                             :before-upload="submissionFileBeforeUpload" accept=".doc,.docx">-->
<!--                    <el-button size="small" type="primary" icon="el-icon-upload" :disabled="condition">上传</el-button>-->
<!--                    <div slot="tip" class="el-upload__tip">只能上传不超过 50MB 的.doc,.docx文件</div>-->
<!--                  </el-upload>-->
<!--                </el-form-item>-->
<!--              </el-col>-->
              <el-col :span="24">
                <el-form-item label="专业教师审核"  porp="submissionTeacherReview">
                  <el-input v-model="submissionData.submissionTeacherReview"
                            type="text"
                            :disabled="true"></el-input>
                </el-form-item >
              </el-col>
              <el-col :span="24">
                <el-form-item label="专业专家审核"  porp="submissionExpertReview">
                  <el-input v-model="submissionData.submissionExpertReview"
                            type="text"
                            :disabled="true"></el-input>
                </el-form-item >
              </el-col>
              <el-col :span="3">
                <el-form-item label-width="5px" label="" prop="field114">
                  <el-button type="primary" size="middle" plain :disabled="condition" @click="processSubmit()">确认</el-button>
                </el-form-item>
              </el-col>
              <el-col :span="3">
                <el-form-item label-width="5px" label="" prop="field114">
                  <el-button plain size="middle" :disabled="condition" @click="closeDialog()">取消</el-button>
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
  name: "SubmissionDialog",
  props:{
    condition:{
      type: Boolean,
      default: true
    },
    showSubmissionDialog:{
      type: Boolean,
      default: false
    },
    dialogTitle:{
      type: String,
      default: "申报信息"
    },
    submissionInputData:{
      type: Object,
      default: function (){
        return {};
      }
    },

  },
  data(){
    return{
      submissionData:JSON.parse(JSON.stringify(this.submissionInputData)),
      rules: {
        processName: [{required: true,message: '课题名称',trigger: 'blur'}],
        submissionBase: [{required: true,message: '课题依据',trigger: 'change'}],
        submissionType: [{required: true,message: '课题类型',trigger: 'change'}],
        submissionBrief: [{required: true,message: '选题依据及课题简介',trigger: 'blur'}],
        submissionDirection: [{required: true,message: '论文研究方向',trigger: 'blur'}],
        submissionLanguage: [{required: true,message: '撰写语种',trigger: 'blur'}],
      },
    }
  },
  methods:{
    async processSubmit(){
      this.tableForm.processCreateTime = setCurrentTime();
      this.tableForm.processChangeTime = setCurrentTime();
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
      this.showSubmissionDialog = false;
    },
    closeDialog(){
      console.log("closeDialog调用")
      this.$refs["submissionData"].resetFields();
      this.fetchData();
      this.showDialog = false;
    },
  }
}
</script>
<style scoped>

</style>
