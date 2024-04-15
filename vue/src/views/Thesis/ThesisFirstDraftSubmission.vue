<template>
  <div class="body">
    <div class="mention">
      <svg width="60" height="100%" viewBox="0 0 48 48" fill="none" style="margin-top:30px;float: left;"><path d="M6 24c0-9.941 8.059-18 18-18s18 8.059 18 18-8.059 18-18 18S6 33.941 6 24zM24 28V14M24 30v4" stroke="#4E5969" stroke-width="2"/></svg>
      <div style="padding-top: 15px">
        <p class="mentionInfo">
          1、学生提交的毕业论文(设计)初稿由两部分组成：论文(设计)文件 和 附件，其中论文(设计)文件必须上传，附件可选。
        </p>
        <p class="mentionInfo">
          2、学生点击“确认”按钮，初稿才最终提交，进入到等待指导教师审核的状态。
        </p>
        <p class="mentionInfo">
          3、毕业论文(设计)初稿文件: 毕业设计说明书或毕业论文，包括封面、中外文摘和关键字、目录、正文、及参考文献等内容，格式建议：pdf文件。
        </p>
        <p class="mentionInfo">
          4、毕业论文(设计)初稿附件：附件指毕业论文(设计)过程中产生的成果，包括图纸、视频等材料，格式建议：zip压缩包，具体要求：
        </p>
        <p class="mentionInfo">
          ▲ 音频：推荐使用 MP3格式；
        </p>
        <p class="mentionInfo">
          ▲ 视频：推荐使用 WMV、 RM、 AVI(常用的编码格式)；
        </p>
        <p class="mentionInfo">
          ▲ 图片：推荐使用 JPG 或 GIF格式；
        </p>
        <p class="mentionInfo">
          ▲ 文本：推荐使用 PDF 格式；
        </p>
        <p class="mentionInfo">
          ▲ 动画：推荐使用 flash、gif格式；
        </p>
        <p class="mentionInfo">
          ▲ 文件大小最好小于50M；
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
        <el-table-column prop="processID" label="流程序号" min-width="5%" align="center"></el-table-column>
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
      <SubmissionDialog
          v-if="showSubmissionDialog"
          ref="SubmissionDialog"
          :submissionInputData="tableForm"
          :dialog-title="dialogTitle"
          :condition="condition"
          :deadTime="deadTime"
          @closeDialog="closeDialog"
      ></SubmissionDialog>
    </div>
  </div>
</template>
<script>
import SubmissionDialog from "@/components/SubmissionDialog.vue";

export default {
  name: "ThesisFirstDraftSubmission",
  components: {SubmissionDialog}
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
  height: 250px;
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
