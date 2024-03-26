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
          border
          v-if="showTable">
        <el-table-column prop="processID" label="序号" min-width="5%" align="center"></el-table-column>
        <el-table-column prop="processName" label="课题名称" min-width="15%" align="center"></el-table-column>
        <el-table-column prop="userId" label="所属专业" min-width="10%" align="center"></el-table-column>
        <el-table-column prop="processGroup" label="指导教师" min-width="10%" align="center"></el-table-column>
        <el-table-column prop="processCreateTime" label="申报日期" min-width="10%" align="center"></el-table-column>
        <el-table-column prop="processCondition" label="状态" min-width="10%" align="center"></el-table-column>
        <el-table-column  label="操作" min-width="10%" align="center">
          <template slot-scope="scope">
            <el-button type="primary" size="middle" v-if="condition === true" @click="informationView" plain>查看</el-button>
            <el-button type="primary" size="middle" v-else @click="informationInput" plain>提交</el-button>
            <el-upload
                class="upload-demo"
                ref="upload"
                action="/file/upload"
                :on-preview="handlePreview"
                :on-remove="handleRemove"
                :file-list="fileList"
                :auto-upload="false"
                v-if="condition === 0">
              <el-button slot="trigger" size="middle" type="primary">上传</el-button>
            </el-upload>
          </template>
        </el-table-column>
      </el-table>
      <el-form
          class="formView"
          v-if="showForm"
          :data="tableData"
      >
        <el-input>

        </el-input>
        <el-button size="middle" type="text" icon="el-icon-back" @click="closeView">返回</el-button>
        <el-button size="middle" @click="test">测试</el-button>
      </el-form>
    </div>
  </div>
</template>
<script>
import request from "@/utils/request";
export default {
  name: "ProjectSubmission",
  data(){
    return {
      tableData: [{processID:1}],
      tableLoading:false,
      showTable:true,
      showForm:false,
      condition:false,
      params:{
        processCreateBy:sessionStorage.getItem('userId'),
        processID:'',
      }
    }
  },
  async created() {
    //先判断是不是在提交时间内
    await request.get('/date/list').then( res =>{
      let today = new Date()
      let dateBegin = new Date(res.data.submissionBegin)
      let dateEnd = new Date(res.data.submissionEnd)
      this.condition = !(today > dateBegin && today < dateEnd);
    })
    const that = this;
    that.tableLoading = false;
    await request.get('/process/listBy',{params:that.params}).then(res =>{
      if (res.code === '200'){
        //如果查询到了
        that.tableData = res.data
        this.condition = true
      }
    })
  },
  methods:{
    async fetchData() {
      //先判断是不是在提交时间内
      await request.get('/date/list').then( res =>{
        let today = new Date()
        let dateBegin = new Date(res.data.submissionBegin)
        let dateEnd = new Date(res.data.submissionEnd)
        if(today > dateBegin && today < dateEnd){
          this.condition = false
          //console.log("在日期内,设置condition=" + this.condition)
        }else {
          this.condition = true
          //console.log("不在日期内,设置condition=" + this.condition)
        }
      })
      const that = this;
      that.tableLoading = false;
      await request.get('/process/listBy',{params:that.params}).then(res =>{
        if (res.code === '200'){
          //如果查询到了
          that.tableData = res.data
          this.condition = true
        }
      })
      await request.get('/user/list',{})
    },
    informationInput(){
      this.showForm = true;
      this.showTable = false;
    },
    informationView(){
      this.showForm = true;
      this.showTable = false;
    },
    test(){
      request.post('/process/createSubmission',this.tableData[0]).then( res =>{
        if(res.code === '200'){
          this.tableData[0].processSubmission=res.data
          this.$message.success("this.tableData[0].processSubmission="+this.tableData[0].processSubmission)
        }
      })
    },
    submitProject(){
      request.post('/process/createSubmission',this.tableData[0]).then( res =>{
        if(res.code === '200'){
          this.tableData[0].processSubmission=res.data
        }
      })
    },
    closeView(){
      if(this.condition === false){
      }
      this.showForm = false;
      this.showTable = true;
      this.fetchData()
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
.formView{
  height: 100%;
  border-radius:5px;
}
</style>