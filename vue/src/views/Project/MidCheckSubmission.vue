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
        <el-table-column prop="processMajor" label="所属专业" min-width="10%" align="center"></el-table-column>
        <el-table-column prop="processGroup" label="指导教师" min-width="10%" align="center"></el-table-column>
        <el-table-column prop="processCreateTime" label="申报日期" min-width="10%" align="center"></el-table-column>
        <el-table-column prop="processCondition" label="状态" min-width="10%" align="center"></el-table-column>
        <el-table-column  label="操作" min-width="10%" align="center">
          <template slot-scope="scope">
            <el-button type="primary" size="middle" v-if="scope.row.condition" @click="informationView(scope.row)" plain>查看</el-button>
            <el-button type="primary" size="middle" v-else @click="informationSubmit(scope.row)" plain>提交</el-button>
          </template>
        </el-table-column>
      </el-table>
      <MidCheckDialog
          v-if="showMidCheckDialog"
          ref="MidCheckDialog"
          :midCheckInputData="tableForm"
          :dialog-title="dialogTitle"
          :condition="condition"
          :deadTime="deadTime"
          @closeDialog="closeDialog"
      ></MidCheckDialog>
    </div>
  </div>
</template>
<script>
import request from "@/utils/request";
import MidCheckDialog from "@/components/MidCheckDialog.vue";

export default {
  name: "MidCheckSubmission",
  components:{MidCheckDialog},
  data(){
    return {
      tableData: [],
      tableForm:{},
      showMidCheckDialog:false,
      condition:false,
      deadTime:'',
      dialogTitle:"申报信息",
      params:{
        processCreateBy:sessionStorage.getItem('userID'),
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
        //设置一下中期报告提交之后的论文初稿截止日期
        this.deadTime = res.data.midCheckDeadline
        let today = new Date()
        //因为提交的是中期检查，所以需要在任务书截止之后，开题报告截止之前
        let dateBegin = new Date(res.data.missionDeadline)
        let dateEnd = new Date(res.data.midCheckDeadline)
        //如果不在的话，显示查看按钮
        if(today < dateBegin || today > dateEnd){
          this.condition = true
        }
      })
      //只有两种状态可以显示提交:(1)有一条"课题申报审核通过"，(2)当前流程全都是审核驳回
      //获取当前学生的流程信息，如果没有则默认空信息，如果在申报期内显示提交否则显示查看
      //params中存储信息：从登录session中读取的userID,去查询同一userID的process流程信息列表
      await request.get('/process/listProcess',{params:that.params}).then(res =>{
        if (res.code === '200'){
          //console.log("查询到了数据")
          that.tableData = res.data
          that.tableData.forEach((item) =>{
            item.userType=2
            request.get('/user/listGroup',{params:item}).then(res=>{
              if(res.code === '200'){
                this.$set(item,"processGroup",res.data[0].userRealName)
              }else {
                this.$set(item,"processGroup","查询失败")
              }
            })
            //对每个行的数据进行状态判断，决定显示'提交'或'查看'按钮
            //只有流程状态为'课题申报审核通过'或'开题报告审核驳回'才能提交申请
            item.condition = item.processCondition !== '任务书审核通过' && item.processCondition !== '中期检查审核驳回';
          })
        }
      })
    },
    async informationSubmit(row){
      // row存储单条process信息，用row中保存的reportID去查询申报信息，
      // 因为后台返回的是列表但我们ID对应的有且只有一条，所以使用data[0]给tableForm赋值
      // 给tableForm加一个fetchData里读出的下一流程deadTime，便于课程申报后更新截止日期
      await request.get('/process/listMidCheck',{params:row}).then(res=>{
        if(res.code === "200"){
          this.tableForm = res.data[0]
        }
      })
      //因为弹窗里需要展示课题名称，所以把row里的process信息赋给tableForm传进弹窗
      this.condition = false
      this.tableForm.deadTime = this.deadTime
      this.$set(this.tableForm, 'processID', row.processID);
      this.$set(this.tableForm, 'processName', row.processName);
      this.$set(this.tableForm, 'processCondition', row.processCondition);
      //开启弹窗
      this.showMidCheckDialog = true
      this.$nextTick(() => {
        this.$refs["MidCheckDialog"].showMidCheckDialog = true;
      });
    },
    async informationView(row){
      //因为弹窗里需要展示课题名称，所以把row里的process信息赋给tableForm传进弹窗
      await request.get('/process/listMidCheck',{params:row}).then(res=>{
        if(res.code === "200"){
          this.tableForm = res.data[0]
        }
      })
      //因为弹窗里需要展示课题名称，所以把row里的process信息赋给tableForm传进弹窗
      this.condition = true
      this.tableForm.deadTime = this.deadTime
      this.$set(this.tableForm, 'processID', row.processID);
      this.$set(this.tableForm, 'processName', row.processName);
      this.$set(this.tableForm, 'processCondition', row.processCondition);
      //开启弹窗
      this.showMidCheckDialog = true
      this.$nextTick(() => {
        this.$refs["MidCheckDialog"].showMidCheckDialog = true;
      });
    },
    closeDialog(){
      this.fetchData();
      this.showMidCheckDialog = false
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
