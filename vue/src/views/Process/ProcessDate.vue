<template>
  <div class="body">
    <div class="mention">
      <svg width="60" height="60" viewBox="0 0 48 48" fill="none" style="margin-top:30px;float: left;"><path d="M6 24c0-9.941 8.059-18 18-18s18 8.059 18 18-8.059 18-18 18S6 33.941 6 24zM24 28V14M24 30v4" stroke="#4E5969" stroke-width="2"/></svg>
      <div style="padding-top: 15px">
        <p class="mentionInfo">
          1、教务管理人员根据学校安排设置毕业论文(设计)开始截止日期
        </p>
        <p class="mentionInfo">
          2、截止日期后学生无法继续提交相关文件，教师和教务可继续审核
        </p>
        <p class="mentionInfo">
          3、如有特殊情况需要修改流程，请联系系统管理员
        </p>
      </div>
    </div>
    <div class="setDate">
      <el-form
          class="dateView"
          :model="dateForm">
        <div
            class="dateDiv">
          申报开始截止日期:
          <el-date-picker
              v-model="range"
              type="datetimerange"
              format="yyyy-MM-dd HH:mm:ss"
              value-format="yyyy-MM-dd HH:mm:ss"
              start-placeholder="开始日期"
              end-placeholder="结束日期"
              @input="dateChange"
              style="float: left;width: 35%;margin-left: 10px;margin-right:60px;height: 50px;"
              :default-time="['00:00:00', '23:59:59']">
          </el-date-picker>
        </div>
        <div class="dateDiv">
          开题报告截止日期:
          <el-date-picker
              class="dateInfo"
              v-model="dateForm.reportDeadline"
              type="datetime"
              placeholder="请选择日期"
              @change="checkEndTime()"
              value-format="yyyy-MM-dd HH:mm:ss">
          </el-date-picker>
          报告提交截止日期:
          <el-date-picker
              class="dateInfo"
              v-model="dateForm.missionDeadline"
              type="datetime"
              placeholder="请选择日期"
              @change=""
              value-format="yyyy-MM-dd HH:mm:ss">
          </el-date-picker>
        </div>
        <div class="dateDiv">
          中期检查截止日期:
          <el-date-picker
              class="dateInfo"
              v-model="dateForm.midCheckDeadline"
              type="datetime"
              placeholder="请选择日期"
              value-format="yyyy-MM-dd HH:mm:ss">
          </el-date-picker>
          论文初稿截止日期:
          <el-date-picker
              class="dateInfo"
              v-model="dateForm.draftThesisDeadline"
              type="datetime"
              placeholder="请选择日期"
              value-format="yyyy-MM-dd HH:mm:ss">
          </el-date-picker>
        </div>
        <div class="dateDiv">
          论文定稿截止日期:
          <el-date-picker
              class="dateInfo"
              v-model="dateForm.finalizeThesisDeadline"
              type="datetime"
              placeholder="请选择日期"
              value-format="yyyy-MM-dd HH:mm:ss">
          </el-date-picker>
          论文终稿截止日期:
          <el-date-picker
              class="dateInfo"
              v-model="dateForm.finalThesisDeadline"
              type="datetime"
              placeholder="请选择日期"
              value-format="yyyy-MM-dd HH:mm:ss">
          </el-date-picker>
        </div>
        <div class="buttonDiv">
          <el-button type="primary" size="medium" @click="changConfirm">确认</el-button>
          <el-button type="primary" size="medium" @click="fetchData">取消</el-button>
        </div>
      </el-form>
    </div>
  </div>
</template>
<script>
import request from "@/utils/request";

export default {
  name: "ProcessDate",
  data(){
    return{
      dateForm: [],
      range: [],
    }
  },
  created() {
    this.fetchData();
  },
  methods:{
    fetchData(){
      request.get('/date/list').then( res => {
        if(res.code === "200"){
          this.dateForm = res.data
          this.range = [res.data.submissionBegin, res.data.submissionEnd]
          console.log(this.dateForm)
        }
      })
    },
    dateChange(){
      this.dateForm.submissionBegin = this.range[0]
      this.dateForm.submissionEnd = this.range[1]
      console.log("range更新")
      console.log(this.dateForm)
    },
    changConfirm(){
      const that = this;
      request.post('/date/update',that.dateForm).then( res =>{
        if(res.code === '200'){
          this.$notify.success("修改成功")
          this.fetchData()
        } else {
          this.$notify.error(res.msg);
        }
      })
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
.setDate{
  margin-top: 15px;
  padding: 25px;
  height: calc(100vh - 265px);
  width: 100%;
  background-color:white;
  box-shadow: 0 0 5px 1px rgba(153, 153, 153, 0.5);
  border-radius:5px;
  display:flex;
  justify-content: center;
  align-items:center;
}
.dateView{
  height: 90%;
  width: 70%;
  padding-top: 50px;
  padding-left: 250px;
}
.dateDiv{
  display:flex;
  margin-top: 50px;
  font-size: 17px;
  text-align:center
}
.dateInfo{
  float: left;
  width: 25%;
  margin-left: 10px;
  margin-right:60px;
}
.buttonDiv{
  margin-top: 10%;
  margin-left: 35%;
}
::v-deep .el-input__inner {
  box-shadow: 1px 1px 5px 1px  RGB(153, 153, 153, 0.1) inset;
  height: 50px;
  font-size: 15px;
}
</style>