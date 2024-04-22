 <template>
  <div class="body">
    <div class="userinfo" >
      <div class="userinfo_title">学院介绍</div>
      <div class="academy_info">您所在的学院:</div>
      <el-button size="middle">您好！{{userRealName}}。您的角色:{{userType}}</el-button>
      <div class="academy_info"></div>
    </div>
    <div class="userinfo" >
      <div class="userinfo_title">系统公告栏</div>
    </div>
    <div class="userinfo" >
      <div class="userinfo_title">流程速览</div>
    </div>
    <div class="userinfo" >
      <div class="userinfo_title">优秀论文展览</div>
    </div>
    <div class="userinfo" >
      <div class="userinfo_title">截止日期提醒</div>
    </div>
    <div class="userinfo" >
      <div class="userinfo_title">这是一个</div>
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

      },
      academyData:[],
      postData:[],
      processData:[],
      paperData:[],
      deadLineData:[]
    }
  },
  created(){

  },
  methods:{
    load(){
      request.get('/user/count',)
    },
  }
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
  border-radius:5px 5px 5px 5px;
  box-shadow: 0 0 15px 15px rgba(153, 153, 153, 0.2 );
}
.userinfo_title{
  padding: 8px 8px 8px 15px;
  box-shadow: 0 1px 0 0 rgba(153, 153, 153, 0.3);
}
</style>
