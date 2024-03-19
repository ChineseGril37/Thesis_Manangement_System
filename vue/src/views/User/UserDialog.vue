<template>
  <!-- 编辑用户表单弹窗 -->
  <transition name="dialog-fade">
    <el-dialog
        v-if="showDialog"
        :title="dialogTitle"
        :visible.sync="showDialog"
        class="UserDialog"
        @close="closeDialog(0)">
      <el-form ref="editForm"
               :model="editForm"
               inline="true"
               rule="checkRules">
        <el-form-item label="学号/教务号" :label-width="formLabelWidth" prop="userId">
          <el-input v-model="editForm.userId" type="text" maxlength="10" show-word-limit clearable></el-input>
        </el-form-item >
        <el-form-item label="所属学院" :label-width="formLabelWidth" prop="userId">
        <el-input v-model="editForm.userAcademy" type="text" clearable></el-input>
      </el-form-item >
        <el-form-item label="所属专业" :label-width="formLabelWidth" prop="userId">
        <el-input v-model="editForm.userMajor" type="text" clearable></el-input>
      </el-form-item >
        <el-form-item label="所属班级" :label-width="formLabelWidth" prop="userId">
        <el-input v-model="editForm.userClass" type="text" maxlength="4" show-word-limit clearable></el-input>
      </el-form-item >
        <el-form-item label="用户名" :label-width="formLabelWidth" prop="userName">
          <el-input v-model="editForm.userName" clearable></el-input>
        </el-form-item>
        <el-form-item label="密码" :label-width="formLabelWidth" prop="password">
          <el-input v-model="editForm.password" clearable></el-input>
        </el-form-item>
        <el-form-item label="姓名" :label-width="formLabelWidth" prop="userRealName">
          <el-input v-model="editForm.userRealName" clearable></el-input>
        </el-form-item>
        <el-form-item label="年龄" :label-width="formLabelWidth"prop="userAge">
          <el-input v-model="editForm.userAge" clearable></el-input>
        </el-form-item>
        <el-form-item label="联系方式" :label-width="formLabelWidth" prop="phoneNum">
          <el-input type="text" v-model="editForm.phoneNum" maxlength="11" show-word-limit clearable></el-input>
        </el-form-item>
        <el-form-item label="用户类型" :label-width="formLabelWidth" prop="userType">
          <el-select v-model="editForm.userType" placeholder="请选择" >
            <el-option label="管理员" value = 0></el-option>
            <el-option label="教务" value = 1></el-option>
            <el-option label="教师" value = 2></el-option>
            <el-option label="学生" value = 3></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="性别" :label-width="formLabelWidth" prop="sexual">
          <el-select v-model="editForm.sexual" placeholder="请选择" >
            <el-option label="男" value = 1></el-option>
            <el-option label="女" value = 0></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="政治面貌" :label-width="formLabelWidth" prop="politicalStatus">
          <el-select v-model="editForm.politicalStatus" placeholder="请选择" >
            <el-option label="党员" value = "党员"></el-option>
            <el-option label="预备党员" value = "预备党员"></el-option>
            <el-option label="民主党派人士" value = "民主党派人士"></el-option>
            <el-option label="群众" value = "群众"></el-option>
            <el-option label="共青团员" value = "共青团员"></el-option>
            <el-option label="无党派人士" value = "无党派人士"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="邮箱" :label-width="formLabelWidth" prop="email">
          <el-input v-model="editForm.email" clearable></el-input>
        </el-form-item>
        <el-form-item label="籍贯" :label-width="formLabelWidth" prop="ancestralPlace">
          <el-input v-model="editForm.ancestralPlace" clearable></el-input>
        </el-form-item>
        <el-form-item label="分组" :label-width="formLabelWidth" prop="groupID">
          <el-input v-model="editForm.groupID" clearable></el-input>
        </el-form-item>
      </el-form>
      <!-- 确认和取消 -->
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="setCurrentTime();editUser();">确 定</el-button>
        <el-button @click="setCurrentTime();closeDialog(0)">取 消</el-button>
      </div>
    </el-dialog>
  </transition>
</template>
<script>
import request from "@/utils/request";

export default {
  name: "UserDialog",
  props:{
    showDialog: {
      type: Boolean,
      default: false
    },
    dialogTitle:{
      type: String,
      default: "修改信息"
    },
    editInForm:{
      type: Object,
      default: function (){
        return {};
      }
    }
  },
  data() {
    return {
      editForm: JSON.parse(JSON.stringify(this.editInForm)),
      formLabelWidth: '100px',
    }
  },
  methods: {
    editUser() {
      const that = this;
      console.log(JSON.parse(JSON.stringify(this.editForm)))
      //把表单中的内容推送到后端
      request.post('/user/addUser', that.editForm).then(res => {
        if (res.code === '200') {
          this.$notify.success('修改成功');
          that.closeDialog(1);
        } else {
          this.$notify.error(res.msg);
        }
      })
    },
    closeDialog(flag) {
      this.$refs["editForm"].resetFields();
      this.showDialog = false;
      this.$emit("closeDialog", flag);
    },
    setCurrentTime() {
      //获取当前时间并打印
      let yy = new Date().getFullYear();
      let mm = new Date().getMonth() + 1;
      let dd = new Date().getDate();
      let hh = new Date().getHours();
      let mf = new Date().getMinutes() < 10 ? '0' + new Date().getMinutes() : new Date().getMinutes();
      let ss = new Date().getSeconds() < 10 ? '0' + new Date().getSeconds() : new Date().getSeconds();
      if(this.dialogTitle === "添加人员"){
        this.editForm.accountCreateTime = yy + '-' + mm + '-' + dd + ' ' + hh + ':' + mf + ':' + ss;
      }
      this.editForm.accountChangeTime = yy + '-' + mm + '-' + dd + ' ' + hh + ':' + mf + ':' + ss;
    },
  },
}
</script>