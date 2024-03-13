<template>
  <div style="padding-left: 20px;margin-top: 20px">
    <!-- 搜索表单 -->
    <div style="margin-bottom: 20px">
      <el-input style="width: 240px" placeholder="请输入姓名"></el-input>
      <el-input style="width: 240px;margin-left: 10px" placeholder="请输入地址"></el-input>
      <el-button style="margin-left: 5px" type="primary">
        <i class="el-icon-search"></i>
        <span>搜索</span>
      </el-button>
    </div>
    <el-table
        :data="tableData"
        style="width: 100%"
        stripe>
      <el-table-column prop="name" label="姓名" width="180"></el-table-column>
      <el-table-column prop="address" label="地址" width="180"></el-table-column>
      <el-table-column prop="sexual" label="性别" width="180"></el-table-column>
      <el-table-column prop="phone" label="联系方式"></el-table-column>
    </el-table>
    <div class="block">
      <el-pagination
          background
          :page-size="4"
          layout="prev, pager, next"
          :total="20">
      </el-pagination>
    </div>
  </div>
</template>

<script>
// @ is an alias to /src
import HelloWorld from '@/components/HelloWorld.vue'

export default {
  name: 'HomeView',
  data(){
    return{
      tableData:[
        { name: '王二', age: 20, address: '北京市', phone: '13276513101', sexual:'男'},
        { name: '王二', age: 20, address: '北京市', phone: '13276513101', sexual:'男'},
        { name: '王二', age: 20, address: '北京市', phone: '13276513101', sexual:'男'},
      ]
    }
  }
}
</script>
