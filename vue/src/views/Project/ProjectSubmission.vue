<template>
  <div class="body">
    <div class="mention">
      <svg width="60" height="60" viewBox="0 0 48 48" fill="none" style="float: left;"><path d="M6 24c0-9.941 8.059-18 18-18s18 8.059 18 18-8.059 18-18 18S6 33.941 6 24zM24 28V14M24 30v4" stroke="#4E5969" stroke-width="2"/></svg>
      <p class="mentionInfo">
        1、学生填写申报课题信息，填写完成后根据课题填写的情况，点“暂存”或者“提交”按钮，即可保存课题到系统中。
      </p>
      <p class="mentionInfo">
        2、学生申报课题要选择课题的指导教师，并在课题申报时间范围内申报并填写课题申报界面内容。
      </p>
    </div>
    <div class="submission">

    </div>
  </div>
</template>
<script>
export default {
  name: "ProjectSubmission"
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
  background-color:whitesmoke;
  box-shadow: 0 0 5px 1px rgba(153, 153, 153, 0.3);
  border-radius:5px;
  padding: 30px 20px 10px 10px;
  flex-direction: column;
}
.mentionInfo{
  font-size: 17px;
  float: unset;
  margin: 5px;
}
.submission{
  margin-top: 15px;
  height: 50vh;
  width: 100%;
  background-color:whitesmoke;
  box-shadow: 0 0 5px 1px rgba(153, 153, 153, 0.3);
  border-radius:5px;
}
</style>