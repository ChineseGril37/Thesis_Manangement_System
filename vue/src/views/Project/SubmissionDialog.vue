<template>
  <div>
    <el-dialog v-bind="$attrs" v-on="$listeners" @close="onClose" title="申报信息">
      <el-row :gutter="15">
        <el-form ref="elForm" :model="tableForm" :rules="rules" size="small" label-width="10px"
          label-position="top">
          <el-col :span="12">
            <el-row>
              <el-col :span="24">
                <el-form-item label-width="100px" label="课题名称" prop="processName">
                  <el-input v-model="tableForm.processName" placeholder="课题名称" clearable
                    prefix-icon='el-icon-edit-outline' :style="{width: '100%'}"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="是否以实验、实习、工程实践和社会调查为基础" prop="submissionBase">
                  <el-select v-model="tableForm.submissionBase" placeholder="是" clearable
                    :style="{width: '100%'}">
                    <el-option v-for="(item, index) in submissionBaseOptions" :key="index" :label="item.label"
                      :value="item.value" :disabled="item.disabled"></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="课题类别" prop="submissionType">
                  <el-select v-model="tableForm.submissionType" clearable :style="{width: '100%'}">
                    <el-option v-for="(item, index) in submissionTypeOptions" :key="index" :label="item.label"
                      :value="item.value" :disabled="item.disabled"></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="24">
                <el-form-item label="选题依据及课题简介" prop="submissionBrief">
                  <el-input v-model="tableForm.submissionBrief" type="textarea" placeholder="选题依据及课题简介"
                    show-word-limit :autosize="{minRows: 4, maxRows: 4}" :style="{width: '100%'}"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="24">
                <el-form-item label="论文研究方向" prop="submissionDirection">
                  <el-input v-model="tableForm.submissionDirection" placeholder="论文研究方向" clearable
                    :style="{width: '100%'}"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="撰写语种" prop="submissionLanguage">
                  <el-input v-model="tableForm.submissionLanguage" placeholder="撰写语种" clearable
                    :style="{width: '100%'}"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="24">
                <el-form-item label="附件上传" prop="submissionFile">
                  <el-upload ref="submissionFile" :file-list="submissionFilefileList"
                    :action="submissionFileAction" :auto-upload="false"
                    :before-upload="submissionFileBeforeUpload" accept=".doc,.docx">
                    <el-button size="small" type="primary" icon="el-icon-upload">上传</el-button>
                    <div slot="tip" class="el-upload__tip">只能上传不超过 50MB 的.doc,.docx文件</div>
                  </el-upload>
                </el-form-item>
              </el-col>
              <el-col :span="3">
                <el-form-item label-width="5px" label="" prop="field114">
                  <el-button type="success" icon="el-icon-check" size="medium"> 确认 </el-button>
                </el-form-item>
              </el-col>
              <el-col :span="3">
                <el-form-item label="" prop="field115">
                  <el-button type="primary" icon="el-icon-close" size="medium"> 取消 </el-button>
                </el-form-item>
              </el-col>
            </el-row>
          </el-col>
        </el-form>
      </el-row>
      <div slot="footer">
        <el-button @click="close">取消</el-button>
        <el-button type="primary" @click="handelConfirm">确定</el-button>
      </div>
    </el-dialog>
  </div>
</template>
<script>
export default {
  name:"SubmissionDialog",
  inheritAttrs: false,
  components: {},
  props: [],
  data() {
    return {
      tableForm: {
        processName: undefined,
        submissionBase: 1,
        submissionType: "毕业设计",
        submissionBrief: "",
        submissionDirection: undefined,
        submissionLanguage: undefined,
        submissionFile: "",
        field114: undefined,
        field115: undefined,
      },
      rules: {
        processName: [{
          required: true,
          message: '课题名称',
          trigger: 'blur'
        }],
        submissionBase: [{
          required: true,
          message: '是',
          trigger: 'change'
        }],
        submissionType: [{
          required: true,
          message: '',
          trigger: 'change'
        }],
        submissionBrief: [{
          required: true,
          message: '选题依据及课题简介',
          trigger: 'blur'
        }],
        submissionDirection: [{
          required: true,
          message: '论文研究方向',
          trigger: 'blur'
        }],
        submissionLanguage: [{
          required: true,
          message: '撰写语种',
          trigger: 'blur'
        }],
      },
      submissionFileAction: '/file/upload',
      submissionFilefileList: [],
      submissionBaseOptions: [{
        "label": "是",
        "value": 1
      }, {
        "label": "否",
        "value": 0
      }],
      submissionTypeOptions: [{
        "label": "毕业设计",
        "value": "毕业设计"
      }, {
        "label": "毕业论文",
        "value": "毕业论文"
      }],
    }
  },
  watch: {},
  computed: {},
  created() {},
  mounted() {},
  methods: {
    onClose() {
      this.$refs['elForm'].resetFields()
    },
    close() {
      this.$emit('update:visible', false)
    },
    handelConfirm() {
      this.$refs['elForm'].validate(valid => {
        if (!valid) return
        this.close()
      })
    },
    submissionFileBeforeUpload(file) {
      let isRightSize = file.size / 1024 / 1024 < 50
      if (!isRightSize) {
        this.$message.error('文件大小超过 50MB')
      }
      let isAccept = new RegExp('.doc,.docx').test(file.type)
      if (!isAccept) {
        this.$message.error('应该选择.doc,.docx类型的文件')
      }
      return isRightSize && isAccept
    },
    submitUpload() {
      this.$refs['submissionFile'].submit()
    },
  }
}

</script>
<style>
.el-upload__tip {
  line-height: 1.2;
}

</style>
