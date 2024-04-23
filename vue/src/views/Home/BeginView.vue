 <template>
  <div class="body">
    <div class="userinfo" >
      <div class="userinfo_title">学院介绍</div>
      <div class="userinfo_info">
        您所在的学院:
        <el-select v-model="params.userAcademy" @change="getAcademyData" :disabled="this.processJudge" style="width: 85%">
          <el-option
              v-for="item in options"
              :key="item.value"
              :label="item.label"
              :value="item.value">
          </el-option>
        </el-select>
        <div class="academy_info">
          <p style="font-size: 25%;color: #b7aeb4">当前人数</p>
          <a style="padding-left:3%">{{this.academyCount}}</a>
        </div>
      </div>
    </div>
    <div class="userinfo">
      <div class="userinfo_title">系统公告栏</div>
        <el-table
            :data="postData">
          <el-table-column prop="post"></el-table-column>
        </el-table>
    </div>
    <div class="userinfo" v-if="this.processJudge">
      <div class="userinfo_title">流程速览</div>
      <div class="process_info">
        <el-steps
            :active="currentStep"
            align-center>
          <el-step v-for="(step, index) in stepData" :key="index">
            <template slot="description">
              <div style="margin: 5px">{{ step.title }}</div>
              <div>{{ step.description }}</div>
            </template>
          </el-step>
        </el-steps>
      </div>
    </div>
    <div class="userinfo" >
    <div class="userinfo_title">截止日期提醒</div>
    <div class="userinfo_info">
      <p v-if="deadLineJudge">{{ deadLine }}</p>
      <p v-else>暂无日期设置</p>
    </div>
  </div>
    <div class="userinfo" >
      <div class="userinfo_title">优秀论文展览</div>
      <div class="userinfo_info">
    </div>
    </div>
    <div class="userinfo" >
      <div class="userinfo_title">这是一个</div>
      <div class="userinfo_info">
    </div>
    </div>
  </div>
</template>

<script>
// @ is an alias to /src
import request from "@/utils/request";
import router from "@/router";
import {defineComponent, watch} from "vue";
export default {
  name: 'BeginView',
  data(){
    return{
      params:{
        userID:sessionStorage.getItem('userID'),
        userAcademy:sessionStorage.getItem('userAcademy'),
      },
      academyCount:0,
      processJudge:false,
      postData:[],
      processData:[],
      paperData:[],
      deadLineData:[],
      options: [],
      stepData: [], // 存储从后端获取的流程状态数据
      currentStep: 0,// 当前激活的步骤，默认为第一步
      deadLine:'',

    }
  },
  created(){
    this.load();
  },
  methods:{
    async load(){
      //判断是否显示流程进度框
      this.processJudge = sessionStorage.getItem('userType') === '3'
      //获取学院信息
      await request.get('/user/listAcademy').then(res=>{
        if(res.code === '200'){
          Object.keys(res.data).forEach((item) => {
            let arr ={value:res.data[item],label:res.data[item]}
            this.options.push(arr)
          })
        }else {
          let arr ={value:"暂无数据",label:"暂无数据"}
          this.options.push(arr)
        }
      })
      //获取学院人数信息
      await this.getAcademyData(this.value)
      //获取截止日期信息
      await this.getDeadLineData()
      //如果用户为学生则加载流程速览数据
      if(this.processJudge){
        await this.getProcessData()
      }
    },
    getAcademyData(){
      console.log(this.params)
      request.get('/user/count',{params:this.params}).then(res=>{
        if(res.code === '200'){
          this.academyCount = res.data
          console.log("this.academyCount=")
          console.log(this.academyCount)
        }
      })
    },
    async getProcessData(){
      try {
        const response = await request.get('/process/processQuickView',this.params);
        const { processCondition } = response.data;
        // 处理从后端获取的流程状态数据，这里 processCondition 是一个数组
        this.stepData = processCondition.map((condition, index) => ({
          title: `Step ${index + 1}`, // 假设标题为默认格式，可根据实际数据调整
          description: condition.description // 流程状态的描述在 condition 对象中的 description 字段
        }));
        // 根据实际情况设置当前激活的步骤
        this.currentStep = 2; // 示例中默认将第三步设为激活状态
      } catch (error) {
        console.error('Error fetching process data:', error);
      }
    },
    getDeadLineData(){
      request.get('/date/list').then(res=>{
        if(res.code==='200'){
          this.deadLineData = res.data
        }
        else {
          this.deadLine = '暂无日期'
        }
      })
      console.log(this.deadLineData)
    },
    deadLineJudge(){
    }
  },
}
</script>
<style>
.body{
  height: calc(100vh - 105px);
  border-radius:0 0 5px 5px;
}
.userinfo{
  float: left;
  flex-direction:column;
  min-height: 25vh;
  min-width: 75vh;
  margin-top: 3vh;
  margin-left: 3vh;
  padding: 5px;
  border-radius:5px 5px 5px 5px;
  box-shadow: 0 0 15px 15px rgba(153, 153, 153, 0.2 );
}
.userinfo_title{
  margin-bottom: 10px;
  padding: 8px 8px 8px 10px;
  box-shadow: 0 1px 0 0 rgba(153, 153, 153, 0.3);
}
.userinfo_info{
  margin: 3%;
  padding: 5px;
}
.academy_info{
  padding-left: 40%;
  font-size: 70px;
  color: #3366cc;
}
.process_info{
  margin-top:10%;
}
</style>
