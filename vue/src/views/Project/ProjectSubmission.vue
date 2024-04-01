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
      <SubmissionDialog
          v-if="showSubmissionDialog"
          ref="SubmissionDialog"
          :dialog-title="dialogTitle"
          :submissionInputData="tableForm"
          @closeDialog="closeDialog"
      ></SubmissionDialog>
    </div>
  </div>
</template>
<script>
import {setCurrentTime,getJsonDateForMat} from "@/utils/common";
import request from "@/utils/request";
import SubmissionDialog from "@/components/SubmissionDialog.vue";
import UserDialog from "@/views/User/UserDialog.vue";
export default {
  name: "ProjectSubmission",
  components:{UserDialog, SubmissionDialog },
  data(){
    return {
      tableData: [{}],
      fileList:[],
      tableForm:{},
      showSubmissionDialog:false,
      condition:false,
      deadTime:'',
      dialogTitle:"申报信息",
      formData: "",
      params:{
        processCreateBy:sessionStorage.getItem('userID'),
        processID:'',
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
        this.deadTime = res.data.reportDeadline
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
      this.showSubmissionDialog = true
      this.$nextTick(() => {
        this.$refs["SubmissionDialog"].showSubmissionDialog = true;
      });
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
