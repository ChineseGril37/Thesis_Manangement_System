<template>
  <el-dialog
      class="MidCheckDialog"
      :title="dialogTitle"
      :visible.sync="showMidCheckDialog"
      @close="closeDialog">
    <el-row :gutter="15">
      <el-form :model="midCheckData"
               :rules="rules"
               ref="midCheckData"
               size="small"
               label-width="10px"
               label-position="top" >
        <el-col>
          <el-row>
            <el-col :span="24">
              <el-form-item label="课题名称" porp="processName">
                <el-input v-model="midCheckData.processName"
                          placeholder="课题名称"
                          clearable
                          :style="{width: '100%'}"
                          :disabled="true"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="24">
              <el-form-item class="item" label="阶段性总结" porp="midCheckSummary">
                <el-input v-model="midCheckData.midCheckSummary" type="textarea"
                          show-word-limit :autosize="{minRows: 4, maxRows: 4}"
                          :disabled="condition" :style="{width: '100%'}"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="24">
              <el-form-item label="存在的问题" prop="midCheckProblem">
                <el-input v-model="midCheckData.midCheckProblem" type="textarea"
                          show-word-limit :autosize="{minRows: 4, maxRows: 4}"
                          :disabled="condition" :style="{width: '100%'}"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="24">
              <!--                  <el-form-item label="附件上传" prop="midCheckFile">-->
              <!--                    <el-upload ref="midCheckFile" :file-list="fileList"-->
              <!--                               :action="midCheckFileAction" :auto-upload="false"-->
              <!--                               :before-upload="midCheckFileBeforeUpload" accept=".doc,.docx">-->
              <!--                      <el-button size="small" type="primary" icon="el-icon-upload" :disabled="condition">上传</el-button>-->
              <!--                      <div slot="tip" class="el-upload__tip">只能上传不超过 50MB 的.doc,.docx文件</div>-->
              <!--                    </el-upload>-->
              <!--                  </el-form-item>-->
            </el-col>
            <el-col :span="24">
              <el-form-item label="专业教师审核" porp="midCheckTeacherReview">
                <el-select v-model="midCheckData.midCheckTeacherReview"
                           :disabled="disableTeacher"
                           placeholder="请选择"
                           style="width: 100%;">
                  <el-option label="审核通过" value = 1></el-option>
                  <el-option label="审核驳回" value = 2></el-option>
                </el-select>
              </el-form-item >
            </el-col>
            <el-col :span="24">
              <el-form-item label="专业专家审核" porp="midCheckExpertReview">
                <el-select v-model="midCheckData.midCheckExpertReview"
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
  name: "MidCheckDialog",
  props:{
    deadTime:{
      type: String
    },
    condition:{
      type: Boolean,
      default: true
    },
    showMidCheckDialog:{
      type: Boolean,
      default: false
    },
    dialogTitle:{
      type: String,
      default: "申报信息"
    },
    midCheckInputData:{
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
      midCheckData:JSON.parse(JSON.stringify(this.midCheckInputData)),
      disableTeacher:true,
      disableManager:true,
      conditionInfo:this.condition,
      rules: {
        midCheckSummary: [{
          required: true,
          message: '阶段性总结',
          trigger: 'change'
        }],
        midCheckProblem: [{
          required: true,
          message: '研究现状',
          trigger: 'change'
        }]
      },
    }
  },
  methods:{
    checkType(){
      switch (this.midCheckData.midCheckTeacherReview){
        case 1:this.midCheckData.midCheckTeacherReview = '审核通过';break;
        case 2:this.midCheckData.midCheckTeacherReview = '审核驳回';break;
        default:this.midCheckData.midCheckTeacherReview = '等待审核'
      }
      switch (this.midCheckData.midCheckExpertReview){
        case 1:this.midCheckData.midCheckExpertReview = '审核通过';break;
        case 2:this.midCheckData.midCheckExpertReview = '审核驳回';break;
        default:this.midCheckData.midCheckExpertReview = '等待审核'
      }
      //如果教师还未审核，且当前用户为这一流程所属小组教师
      if(
          this.midCheckData.midCheckTeacherReview === '等待审核'
          &&
          parseInt(sessionStorage.getItem('groupID'))
          &&
          sessionStorage.getItem('userType') === '2'
      ){
        this.disableTeacher = false
        this.conditionInfo = false
      }
      //如果专家还未审核，且当前用户为教务或者管理员
      if(
          this.midCheckData.midCheckExpertReview === '等待审核'
          &&
          (
              sessionStorage.getItem('userType') === '1'
              ||
              sessionStorage.getItem('userType') === '0'
          )
      ){
        this.disableManager = false
        this.conditionInfo = false
      }
    },
    async processSubmit(){
      //先把刚才为了提示用户显示转换的审核状态转换回数字
      switch (this.midCheckData.midCheckTeacherReview){
        case '1':
        case '审核通过':this.midCheckData.midCheckTeacherReview = 1;break;
        case '2':
        case '审核驳回':this.midCheckData.midCheckTeacherReview = 2;break;
        default:this.midCheckData.midCheckTeacherReview = 0;
      }
      switch (this.midCheckData.midCheckExpertReview){
        case '1':
        case '审核通过':this.midCheckData.midCheckExpertReview = 1;break;
        case '2':
        case '审核驳回':this.midCheckData.midCheckExpertReview = 2;break;
        default:this.midCheckData.midCheckExpertReview = 0;
      }
      //如果是小组教师或者教务\管理员，那这个页面处于审核流程，update审核流程,否则是学生在进行新midCheck创建
      //如果教师审核和专家审核不为空(且用户类型不为学生)
      if((!this.disableTeacher || !this.disableManager) && sessionStorage.getItem('userType') !== '3'){
        //先提交审核内容到相关的过程中
        await request.post('/process/updateMidCheck',this.midCheckData)
        //如果教师审核与专家审核都为审核通过，更新流程进度为当前流程审核通过
        if(this.midCheckData.midCheckTeacherReview === 1
            &&
            this.midCheckData.midCheckExpertReview === 1){
          this.midCheckData.processCondition = "中期检查审核通过"
          await request.post('/process/updateProcess',this.midCheckData)
        }else if(
            //如果教师审核与专家审核有一个审核驳回，更新流程进度为当前流程审核驳回
            this.midCheckData.midCheckTeacherReview === 2
            ||
            this.midCheckData.midCheckExpertReview === 2){
          this.midCheckData.processCondition = "中期检查审核驳回"
          await request.post('/process/updateProcess',this.midCheckData)
        }
        this.$message.success("审核提交成功")
      } else if(this.midCheckData.processCondition === '中期检查审核驳回'){
        this.midCheckData.midCheckTeacherReview = 0
        this.midCheckData.midCheckExpertReview = 0
        this.midCheckData.processDeadTime = this.deadTime
        this.midCheckData.processChangeTime = setCurrentTime();
        this.midCheckData.groupID = sessionStorage.getItem('groupID')
        await request.post('/process/updateMidCheck',this.midCheckData).then(res=>{
          if(res.code === '200'){
            this.midCheckData.midCheckID = res.data
            this.midCheckData.processCondition= "中期检查等待审核";
          }
        })
        await request.post('/process/updateProcess',this.midCheckData).then(res=>{
          this.$message.success("中期检查更新成功")
        })
      } else {
        this.midCheckData.processDeadTime = this.deadTime
        this.midCheckData.processChangeTime = setCurrentTime();
        this.midCheckData.groupID = sessionStorage.getItem('groupID')
        await request.post('/process/createMidCheck',this.midCheckData).then(res=>{
          if(res.code === '200'){
            this.midCheckData.midCheckID = res.data
            this.midCheckData.processCondition= "中期检查等待审核";
          }
        })
        await request.post('/process/updateProcess',this.midCheckData).then(res=>{
          this.$message.success("中期检查申报成功")
        })
      }
      this.closeDialog()
    },
    closeDialog(){
      this.$refs["midCheckData"].resetFields();
      this.showMidCheckDialog = false;
      this.$emit("showMidCheckDialog",false)
      this.$emit("closeDialog");
    },
  }
}
</script>
<style scoped>

</style>
