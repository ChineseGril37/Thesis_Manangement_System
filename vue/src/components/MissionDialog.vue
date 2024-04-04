<template>
  <el-dialog
      class="MissionDialog"
      :title="dialogTitle"
      :visible.sync="showMissionDialog"
      @close="closeDialog">
    <el-row :gutter="15">
      <el-form :model="missionData"
               :rules="rules"
               ref="missionData"
               size="small"
               label-width="10px"
               label-position="top" >
        <el-col>
          <el-row>
            <el-col :span="24">
              <el-form-item label="课题名称" porp="processName">
                <el-input v-model="missionData.processName"
                          placeholder="课题名称"
                          clearable
                          :style="{width: '100%'}"
                          :disabled="true"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="24">
              <el-form-item class="item" label="课题目标" porp="missionGoal">
                <el-input v-model="missionData.missionGoal" type="textarea"
                          show-word-limit :autosize="{minRows: 4, maxRows: 4}"
                          :disabled="condition" :style="{width: '100%'}"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="24">
              <el-form-item label="课题任务内容" prop="missionContent">
                <el-input v-model="missionData.missionContent" type="textarea"
                          show-word-limit :autosize="{minRows: 4, maxRows: 4}"
                          :disabled="condition" :style="{width: '100%'}"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="24">
              <el-form-item label="课题进度安排" prop="missionPlan">
                <el-input v-model="missionData.missionPlan" type="textarea"
                          show-word-limit :autosize="{minRows: 4, maxRows: 4}"
                          :disabled="condition" :style="{width: '100%'}"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="24">
              <el-form-item label="参考文献" prop="missionReferences">
                <el-input v-model="missionData.missionReferences" type="textarea"
                          show-word-limit :autosize="{minRows: 2, maxRows: 2}"
                          :disabled="condition" :style="{width: '100%'}"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="24">
              <!--                  <el-form-item label="附件上传" prop="missionFile">-->
              <!--                    <el-upload ref="missionFile" :file-list="fileList"-->
              <!--                               :action="missionFileAction" :auto-upload="false"-->
              <!--                               :before-upload="missionFileBeforeUpload" accept=".doc,.docx">-->
              <!--                      <el-button size="small" type="primary" icon="el-icon-upload" :disabled="condition">上传</el-button>-->
              <!--                      <div slot="tip" class="el-upload__tip">只能上传不超过 50MB 的.doc,.docx文件</div>-->
              <!--                    </el-upload>-->
              <!--                  </el-form-item>-->
            </el-col>
            <el-col :span="24">
              <el-form-item label="专业教师审核" porp="missionTeacherReview">
                <el-select v-model="missionData.missionTeacherReview"
                           :disabled="disableTeacher"
                           placeholder="请选择"
                           style="width: 100%;">
                  <el-option label="审核通过" value = 1></el-option>
                  <el-option label="审核驳回" value = 2></el-option>
                </el-select>
              </el-form-item >
            </el-col>
            <el-col :span="24">
              <el-form-item label="专业专家审核" porp="missionExpertReview">
                <el-select v-model="missionData.missionExpertReview"
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
  name: "MissionDialog",
  props:{
    deadTime:{
      type: String
    },
    condition:{
      type: Boolean,
      default: true
    },
    showMissionDialog:{
      type: Boolean,
      default: false
    },
    dialogTitle:{
      type: String,
      default: "申报信息"
    },
    missionInputData:{
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
      missionData:JSON.parse(JSON.stringify(this.missionInputData)),
      disableTeacher:true,
      disableManager:true,
      conditionInfo:this.condition,
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
  methods:{
    checkType(){
      if(this.missionData.missionTeacherReview === 1){
        this.missionData.missionTeacherReview = '审核通过'
      } else if(this.missionData.missionTeacherReview === 2){
        this.missionData.missionTeacherReview = '审核驳回'
      }
      if(this.missionData.missionExpertReview === 1){
        this.missionData.missionExpertReview = '审核通过'
      } else if(this.missionData.missionExpertReview === 2){
        this.missionData.missionExpertReview = '审核驳回'
      }
      if(this.missionData.missionTeacherReview === null && this.missionData.groupID === sessionStorage.getItem('groupID') && sessionStorage.getItem('userType') === '2'){
        this.disableTeacher = false
        this.conditionInfo = false
      }
      if(this.missionData.missionExpertReview === null && (sessionStorage.getItem('userType') === '1' || sessionStorage.getItem('userType') === '0')){
        this.disableManager = false
        this.conditionInfo = false
      }
    },
    async processSubmit(){
      //如果是小组教师或者教务\管理员，那这个页面处于审核流程，update审核流程,否则是学生在进行新mission创建
      //如果教师审核和专家审核不为空(且用户类型不为学生)
      if((!this.disableTeacher || !this.disableManager) && sessionStorage.getItem('userType') !== '3'){
        //先提交审核内容到相关的过程中
        await request.post('/process/updateMission',this.missionData)
        //如果教师审核与专家审核都为审核通过，更新流程进度为当前流程审核通过
        if(
            (this.missionData.missionTeacherReview === '审核通过' || this.missionData.missionTeacherReview === 1)
            &&
            (this.missionData.missionExpertReview === '审核通过' || this.missionData.missionExpertReview === 1)){
          this.missionData.processCondition = "任务书审核通过"
          await request.post('/process/updateProcess',this.missionData)
        }else if(
            //如果教师审核与专家审核有一个审核驳回，更新流程进度为当前流程审核驳回
            (this.missionData.missionTeacherReview === '审核驳回' || this.missionData.missionTeacherReview === 2)
            ||
            (this.missionData.missionExpertReview === '审核驳回' || this.missionData.missionExpertReview === 2)){
          this.missionData.processCondition = "任务书审核驳回"
          await request.post('/process/updateProcess',this.missionData)
        }
        this.$message.success("审核提交成功")
      }
      else {
        this.missionData.processChangeTime = setCurrentTime();
        this.missionData.processDeadTime = this.deadTime
        this.missionData.groupID = sessionStorage.getItem('groupID')
        await request.post('/process/createMission',this.missionData).then(res=>{
          if(res.code === '200'){
            this.missionData.missionID = res.data
            this.missionData.processCondition= "任务书等待审核";
          }
        })
        await request.post('/process/updateProcess',this.missionData).then(res=>{
          this.$message.success("任务书申报成功")
        })
      }
      this.closeDialog()
    },
    closeDialog(){
      this.$refs["missionData"].resetFields();
      this.showMissionDialog = false;
      this.$emit("showMissionDialog",false)
      this.$emit("closeDialog");
    },
  }
}
</script>
<style scoped>

</style>
