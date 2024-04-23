<template>
  <div>
    <p v-if="nearestDeadline">{{ nearestDeadline }}</p>
    <p v-else>暂无日期设置</p>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      deadlines: null // 存储从后端获取的日期数据
    };
  },
  created() {
    // 在组件创建时发起后端请求获取日期数据
    this.fetchDeadlines();
  },
  methods: {
    async fetchDeadlines() {
      try {
        const response = await axios.get('/date/list');
        this.deadlines = response.data.data;
        this.showNearestDeadline();
      } catch (error) {
        console.error('Error fetching deadlines:', error);
      }
    },
    showNearestDeadline() {
      if (!this.deadlines) {
        // 没有读取到日期数据
        this.nearestDeadline = null;
        return;
      }

      const {
        submissionEnd,
        reportDeadline,
        missionDeadline,
        midCheckDeadline,
        draftThesisDeadline,
        finalizeThesisDeadline,
        finalThesisDeadline
      } = this.deadlines;

      // 将日期字符串转换为 Date 对象
      const deadlines = [
        new Date(submissionEnd),
        new Date(reportDeadline),
        new Date(missionDeadline),
        new Date(midCheckDeadline),
        new Date(draftThesisDeadline),
        new Date(finalizeThesisDeadline),
        new Date(finalThesisDeadline)
      ];

      // 找出最近的截止日期
      const now = new Date();
      const nearest = deadlines.filter(date => date > now); // 过滤出未过期的日期
      if (nearest.length > 0) {
        // 如果找到未过期的最近截止日期
        nearest.sort((a, b) => a - b); // 按日期升序排序
        this.nearestDeadline = nearest[0].toLocaleString(); // 格式化日期字符串
      } else {
        // 所有截止日期都已过期
        this.nearestDeadline = null;
      }
    }
  },
  computed: {
    nearestDeadlineText() {
      return this.nearestDeadline ? this.nearestDeadline : '暂无日期设置';
    }
  },
};
</script>

<style>
/* 可以根据需要添加样式 */
</style>
