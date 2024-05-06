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
        <el-row>
          <el-col :span="24">
            <el-form-item label="课题名称" porp="processName">
              <el-input v-model="submissionData.processName"
                        placeholder="课题名称"
                        style="width: 100%;"
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
                        :autosize="{minRows: 6, maxRows: 6}"
                        :disabled="condition"
                        :style="{width: '100%'}"
                        show-word-limit></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="论文研究方向" prop="submissionDirection">
              <el-input v-model="submissionData.submissionDirection"
                        placeholder="论文研究方向"
                        style="width: 100%;"
                        :disabled="condition"
                        clearable></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="撰写语种" prop="submissionLanguage">
              <el-input v-model="submissionData.submissionLanguage"
                        placeholder="撰写语种"
                        :disabled="condition"
                        style="width: 100%;"
                        clearable></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="附件上传" prop="submissionFile">
              <el-upload action
                         ref="upload"
                         class="upload"
                         :limit="fileLimit"
                         :headers="headers"
                         :auto-upload="false"
                         :file-list="fileList"
                         :on-change="beforeUpload"
                         :on-exceed="handleExceed"
                         :http-request="uploadFile">
                <el-button slot="trigger"
                           size="small"
                           type="primary"
                           icon="el-icon-upload"
                           :disabled="condition">上传
                </el-button>
                <div slot="tip" class="el-upload__tip">只能上传不超过 50MB 的.doc,.docx文件</div>
              </el-upload>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="专业教师审核"  porp="submissionTeacherReview">
              <el-select v-model="submissionData.submissionTeacherReview"
                         :disabled="disableTeacher"
                         placeholder="请选择"
                         style="width: 100%;">
                <el-option label="审核通过" value = 1></el-option>
                <el-option label="审核驳回" value = 2></el-option>
              </el-select>
            </el-form-item >
          </el-col>
          <el-col :span="24">
            <el-form-item label="专业专家审核"  porp="submissionExpertReview">
              <el-select v-model="submissionData.submissionExpertReview"
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
      </el-form>
    </el-row>
  </el-dialog>
</template>
<script>
import {setCurrentTime} from "@/utils/common";
import request from "@/utils/request";
import axios from "axios";
export default {
  name: "SubmissionDialog",
  props:{
    deadTime:{
      type: String
    },
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
  created(){
    this.checkType();
  },
  data(){
    return{
      submissionData:JSON.parse(JSON.stringify(this.submissionInputData)),
      disableTeacher:true,
      disableManager:true,
      //如果是学生还未填写，传入的condition应该默认是false，其他则是true
      conditionInfo:this.condition,
      rules: {
        processName: [{required: true,message: '课题名称',trigger: 'blur'}],
        submissionBase: [{required: true,message: '课题依据',trigger: 'change'}],
        submissionType: [{required: true,message: '课题类型',trigger: 'change'}],
        submissionBrief: [{required: true,message: '选题依据及课题简介',trigger: 'blur'}],
        submissionDirection: [{required: true,message: '论文研究方向',trigger: 'blur'}],
        submissionLanguage: [{required: true,message: '撰写语种',trigger: 'blur'}],
      },
      // el-upload组件绑定的属性—— :file-list=“fileList”,渲染后fileList[index]是Object类型,而不是后台所需的File类型,
      // 而这个组件已经把对应的File类型存储到了fileList[index].raw这个属性里,直接拿来用就好.
      //上传后的文件列表
      fileList: [],
      // 允许的文件类型
      fileType: [ "pdf", "doc", "docx"],
      // 运行上传文件大小，单位 M
      fileSize: 50,
      // 附件数量限制
      fileLimit: 5,
      //请求标头
      headers: {'Content-Type': 'multipart/form-data'}
    }
  },
  methods:{
    beforeUpload(file,fileList){
      if (file.type !== "" || file.type != null || file.type !== undefined){
        //截取文件的后缀，判断文件类型
        const FileExt = file.name.replace(/.+\./, "").toLowerCase();
        //计算文件的大小
        const isLt5M = file.size / 1024 / 1024 < 50; //这里做文件大小限制
        console.log(isLt5M)
        //如果大于50M
        if (!isLt5M) {
          this.$showMessage('上传文件大小不能超过 50MB!');
          return false;
        }
        //如果文件类型不在允许上传的范围内
        if(this.fileType.includes(FileExt)){
          this.fileList = fileList
          return true;
        }
        else {
          this.$message.error("上传文件格式不正确!");
          return false;
        }
      }
    },
    //超出文件个数的回调
    handleExceed(){
      this.$message({
        type:'warning',
        message:'超出最大上传文件数量的限制！'
      });
      return false;
    },
    //文件上传
    uploadFile(){
      let formData = new FormData()
      formData.append('userID',sessionStorage.getItem('userID'))
      formData.append('fileType','1')
      formData.append('fileCreateTime',setCurrentTime())
      formData.append('fileChangeTime',setCurrentTime())
      for(let i = 0;i < this.fileList.length; i++){
        formData.append('fileList',this.fileList[i].raw)
      }
      axios.post('http://localhost:9090/file/upload',formData,{headers:this.headers}).then(res=>{
        console.log(res)
        if(res.data.code === '200'){
          this.$message({
            type:'success',
            message:'文件上传成功!'
          })
        }else {
          this.$message({
            type:'error',
            message:res.data.msg
          })
        }
      })
    },
    checkType(){
      switch (this.submissionData.submissionTeacherReview){
        case 1:this.submissionData.submissionTeacherReview = '审核通过';break;
        case 2:this.submissionData.submissionTeacherReview = '审核驳回';break;
        default:this.submissionData.submissionTeacherReview = '等待审核'
      }
      switch (this.submissionData.submissionExpertReview){
        case 1:this.submissionData.submissionExpertReview = '审核通过';break;
        case 2:this.submissionData.submissionExpertReview = '审核驳回';break;
        default:this.submissionData.submissionExpertReview = '等待审核'
      }
      //如果教师还未审核，且当前用户为这一流程所属小组教师
      if(
          this.submissionData.submissionTeacherReview === '等待审核'
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
          this.submissionData.submissionExpertReview === '等待审核'
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
      switch (this.submissionData.submissionTeacherReview){
        case '1':
        case '审核通过':this.submissionData.submissionTeacherReview = 1;break;
        case '2':
        case '审核驳回':this.submissionData.submissionTeacherReview = 2;break;
        default:this.submissionData.submissionTeacherReview = 0;
      }
      switch (this.submissionData.submissionExpertReview){
        case '1':
        case '审核通过':this.submissionData.submissionExpertReview = 1;break;
        case '2':
        case '审核驳回':this.submissionData.submissionExpertReview = 2;break;
        default:this.submissionData.submissionExpertReview = 0;
      }
      //如果是小组教师或者教务\管理员，那这个页面处于审核流程，update审核流程,否则是学生在进行新submission创建
      //如果教师审核和专家审核不为空(且用户类型不为学生)
      if((!this.disableTeacher || !this.disableManager) && sessionStorage.getItem('userType') !== '3'){
        //先提交审核内容到相关的过程中
        await request.post('/process/updateSubmission',this.submissionData)
        //如果教师审核与专家审核都为审核通过，更新流程进度为当前流程审核通过
        if(this.submissionData.submissionTeacherReview === 1
            &&
            this.submissionData.submissionExpertReview === 1){
          this.submissionData.processCondition = "课题申报审核通过"
          await request.post('/process/updateProcess',this.submissionData)
        }else if(
            //如果教师审核与专家审核有一个审核驳回，更新流程进度为当前流程审核驳回
            this.submissionData.submissionTeacherReview === 2
            ||
            this.submissionData.submissionExpertReview === 2){
          this.submissionData.processCondition = "课题申报审核驳回"
          await request.post('/process/updateProcess',this.submissionData)
        }
        this.$message.success("审核提交成功")
      }else if(this.submissionData.processCondition === '课题申报审核驳回'){
        this.submissionData.submissionTeacherReview = 0
        this.submissionData.submissionExpertReview = 0
        this.submissionData.processDeadTime = this.deadTime
        this.submissionData.processChangeTime = setCurrentTime();
        this.submissionData.groupID = sessionStorage.getItem('groupID')
        await request.post('/process/updateSubmission',this.submissionData).then(res=>{
          if(res.code === '200'){
            this.submissionData.reportID = res.data
            this.submissionData.processCondition= "课题申报等待审核";
          }
        })
        await request.post('/process/updateProcess',this.submissionData).then(res=>{
          this.$message.success("课题申报更新成功")
        })
      } else {
        this.submissionData.processCreateTime = setCurrentTime();
        this.submissionData.processChangeTime = setCurrentTime();
        this.submissionData.processDeadTime = this.deadTime
        this.submissionData.groupID = sessionStorage.getItem('groupID')
        await request.post('/process/createSubmission',this.submissionData).then(res=>{
          if(res.code === '200'){
            this.submissionData.submissionID = res.data
            this.submissionData.processCreateBy = sessionStorage.getItem('userID')
            this.submissionData.groupID=sessionStorage.getItem("groupID")
            this.submissionData.processMajor= sessionStorage.getItem("userMajor")
            this.submissionData.processCondition= "课题申报等待审核";
          }
        })
        await request.post('/process/createProcess',this.submissionData).then(res=>{
          this.$message.success("课题申报成功")
        })
      }
      if(this.condition){
        this.uploadFile()
      }
      this.closeDialog()
    },
    closeDialog(){
      this.$refs["submissionData"].resetFields()
      this.showSubmissionDialog = false;
      this.$emit("showSubmissionDialog",false)
      this.$emit("closeDialog");
    },
  }
}
</script>
<style scoped>

</style>
