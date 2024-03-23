<template>
  <div class="body">
    <div class="mention">
      <svg width="60" height="60" viewBox="0 0 48 48" fill="none" style="margin-top:30px;float: left;"><path d="M6 24c0-9.941 8.059-18 18-18s18 8.059 18 18-8.059 18-18 18S6 33.941 6 24zM24 28V14M24 30v4" stroke="#4E5969" stroke-width="2"/></svg>
      <div style="padding-top: 15px">
        <p class="mentionInfo">
          1、学生根据课题情况填写开题报告信息，填写完成后点“暂存”或者“提交”按钮，即可保存开题报告信息到系统中。
        </p>
        <p class="mentionInfo">
          2、开题报告提交后需等待指导教师的审核，待指导教师审核通过后即可完成开题报告操作。
        </p>
        <p class="mentionInfo">
          3、学生的开题报告内容需在开题报告时间范围内填写。
        </p>
        <p class="mentionInfo">
          4、 如果您的开题报告中有大量的数学公式，请以图片形式上传，或者请以附件形式上传您的开题报告到系统中。
        </p>
      </div>
    </div>
    <div class="submission">
      <el-table
          :data="tableData"
          :row-style="{ height:'80px'}"
          style="font-size: 15px"
          :cell-style="rowStyle"
          :header-cell-style="{'text-align':'center','background-color':'whitesmoke'}"
          stripe
          border>
        <el-table-column prop="userId" label="课题名称" min-width="15%" ></el-table-column>
        <el-table-column prop="userId" label="所属专业" min-width="10%"></el-table-column>
        <el-table-column prop="userId" label="指导教师" min-width="10%"></el-table-column>
        <el-table-column prop="userId" label="申报日期" min-width="10%"></el-table-column>
        <el-table-column prop="userId" label="状态" min-width="10%"></el-table-column>
        <el-table-column prop="userId" label="操作" min-width="10%"></el-table-column>
      </el-table>
    </div>
  </div>
</template>
<script>
export default {
  name: "ProjectReportSubmission",
  data(){
    return{
      tableData:[{}],
    }
  },
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
  height: 50vh;
  width: 100%;
  background-color:white;
  box-shadow: 0 0 5px 1px rgba(153, 153, 153, 0.5);
  border-radius:5px;
}
</style>