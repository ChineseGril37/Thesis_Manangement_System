/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80031 (8.0.31)
 Source Host           : localhost:3306
 Source Schema         : thesis_management

 Target Server Type    : MySQL
 Target Server Version : 80031 (8.0.31)
 File Encoding         : 65001

 Date: 27/03/2024 20:01:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for deadline
-- ----------------------------
DROP TABLE IF EXISTS `deadline`;
CREATE TABLE `deadline`  (
  `dateID` int NOT NULL COMMENT '日期ID',
  `submissionBegin` datetime NULL DEFAULT NULL COMMENT '申报开始日期',
  `submissionEnd` datetime NULL DEFAULT NULL COMMENT '申报结束日期',
  `reportDeadline` datetime NULL DEFAULT NULL COMMENT '开题报告截止日期',
  `missionDeadline` datetime NULL DEFAULT NULL COMMENT '报告书截止日期',
  `midCheckDeadline` datetime NULL DEFAULT NULL COMMENT '中期检查截止日期',
  `draftThesisDeadline` datetime NULL DEFAULT NULL COMMENT '论文初稿截止日期',
  `finalizeThesisDeadline` datetime NULL DEFAULT NULL COMMENT '论文定稿截止日期',
  `finalThesisDeadline` datetime NULL DEFAULT NULL COMMENT '论文终稿截止日期',
  PRIMARY KEY (`dateID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of deadline
-- ----------------------------
INSERT INTO `deadline` VALUES (1, '2024-03-25 00:00:00', '2024-03-28 23:59:59', '2024-04-01 00:00:00', '2024-04-06 00:00:00', '2024-04-18 00:00:00', '2024-04-21 00:00:00', '2024-04-23 00:00:00', '2024-04-30 00:00:00');

-- ----------------------------
-- Table structure for file
-- ----------------------------
DROP TABLE IF EXISTS `file`;
CREATE TABLE `file`  (
  `fileID` int NOT NULL COMMENT '文件ID',
  `fileAddress` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件地址',
  `fileType` int NULL DEFAULT NULL COMMENT '文件类型',
  `fileSize` bigint NULL DEFAULT NULL COMMENT '文件大小',
  `fileName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件名',
  `studentID` int NULL DEFAULT NULL COMMENT '所属学生ID',
  `teacherID` int NULL DEFAULT NULL COMMENT '所属导师ID',
  `fileCreateTime` datetime NULL DEFAULT NULL COMMENT '文件创建日期',
  `fileChangeTime` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '文件修改日期',
  PRIMARY KEY (`fileID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of file
-- ----------------------------

-- ----------------------------
-- Table structure for midcheck
-- ----------------------------
DROP TABLE IF EXISTS `midcheck`;
CREATE TABLE `midcheck`  (
  `midcheckID` int NOT NULL COMMENT '中期检查ID',
  `midcheckSummary` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '阶段性总结',
  `midcheckProblem` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '存在的问题',
  `midcheckTeacherReview` tinyint NULL DEFAULT NULL COMMENT '中期检查教师审核',
  `midcheckExpertReview` tinyint NULL DEFAULT NULL COMMENT '中期检查专家审核',
  PRIMARY KEY (`midcheckID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of midcheck
-- ----------------------------

-- ----------------------------
-- Table structure for mission
-- ----------------------------
DROP TABLE IF EXISTS `mission`;
CREATE TABLE `mission`  (
  `missionID` int NOT NULL COMMENT '任务书ID',
  `missionGoal` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '课题目标',
  `missionContent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '课题任务内容',
  `missionPlan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '课题进度安排',
  `missionReferences` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '参考文献',
  `missionTeacherReview` tinyint NULL DEFAULT NULL COMMENT '任务书教师审核',
  `missionExpertReview` tinyint NULL DEFAULT NULL COMMENT '任务书专家审核',
  PRIMARY KEY (`missionID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mission
-- ----------------------------

-- ----------------------------
-- Table structure for oraldefense
-- ----------------------------
DROP TABLE IF EXISTS `oraldefense`;
CREATE TABLE `oraldefense`  (
  `oralDefenseID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '答辩ID',
  `oralDefenseStudent` int NULL DEFAULT NULL COMMENT '答辩学生ID',
  `oralDefenseGroup` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '答辩组名称',
  `oralDefensePosition` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '答辩组地点',
  `oralDefenseDate` datetime NULL DEFAULT NULL COMMENT '答辩日期',
  `oralDefenseHolder` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '答辩组组长',
  `oralDefenseRecorder` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '答辩录入员',
  `oralDefenseGrades` double NULL DEFAULT NULL COMMENT '答辩成绩',
  PRIMARY KEY (`oralDefenseID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oraldefense
-- ----------------------------

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post`  (
  `postID` int NOT NULL COMMENT '公告ID',
  `postTitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '公告标题',
  `postCreator` int NULL DEFAULT NULL COMMENT '公告创建人ID',
  `postType` int NULL DEFAULT NULL COMMENT '公告类型(全局、教师、教务、学生)',
  `postContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '公告内容',
  `postCreateTime` datetime NULL DEFAULT NULL COMMENT '公告创建日期',
  `postChangeTime` datetime NULL DEFAULT NULL COMMENT '公告修改日期',
  PRIMARY KEY (`postID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of post
-- ----------------------------

-- ----------------------------
-- Table structure for process
-- ----------------------------
DROP TABLE IF EXISTS `process`;
CREATE TABLE `process`  (
  `processID` int NOT NULL AUTO_INCREMENT COMMENT '流程ID',
  `processName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '课题名称',
  `processCreateBy` int NULL DEFAULT NULL COMMENT '流程创建者',
  `groupID` int NULL DEFAULT NULL COMMENT '流程所属小组',
  `processChangeTime` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '流程更新日期',
  `processCreateTime` datetime NULL DEFAULT NULL COMMENT '流程创建日期',
  `processDeadTime` datetime NULL DEFAULT NULL COMMENT '流程当前截止日期',
  `processCondition` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '流程状态',
  `processSubmission` int NULL DEFAULT NULL COMMENT '课题申报ID',
  `processReport` int NULL DEFAULT NULL COMMENT '开题报告ID',
  `processMission` int NULL DEFAULT NULL COMMENT '任务书ID',
  `processMidcheck` int NULL DEFAULT NULL COMMENT '中期检查ID',
  `processOral` int NULL DEFAULT NULL COMMENT '答辩ID',
  PRIMARY KEY (`processID` DESC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of process
-- ----------------------------
INSERT INTO `process` VALUES (1, '基于Java的前后端分离毕业设计管理系统的设计与实现', 1000000001, 2, '2024-03-27 15:48:27', '2024-03-27 15:48:27', '2024-03-27 23:59:59', '课题申报等待审核', 1, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for report
-- ----------------------------
DROP TABLE IF EXISTS `report`;
CREATE TABLE `report`  (
  `reportID` int NOT NULL COMMENT '开题报告ID',
  `reportMeaning` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '研究目的',
  `reportSituation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '研究现状',
  `reportAim` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '研究目标',
  `reportWay` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '研究方案',
  `reportTeacherReview` tinyint NULL DEFAULT NULL COMMENT '开题报告教师审核',
  `reportExpertReview` tinyint NULL DEFAULT NULL COMMENT '开题报告专家审核',
  PRIMARY KEY (`reportID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of report
-- ----------------------------

-- ----------------------------
-- Table structure for submission
-- ----------------------------
DROP TABLE IF EXISTS `submission`;
CREATE TABLE `submission`  (
  `submissionID` int NOT NULL AUTO_INCREMENT COMMENT '课题申报ID',
  `processID` int NULL DEFAULT NULL COMMENT '所属流程ID',
  `submissionBase` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '是否以实验、实习、工程实践和社会调查为基础',
  `submissionType` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '课题类别',
  `submissionBrief` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '选题依据及课题简介',
  `submissionDirection` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '论文研究方向',
  `submissionLanguage` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '撰写语种',
  `submissionTeacherReview` tinyint NULL DEFAULT NULL COMMENT '课题申报教师审核',
  `submissionExpertReview` tinyint NULL DEFAULT NULL COMMENT '课题申报专家审核',
  PRIMARY KEY (`submissionID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of submission
-- ----------------------------
INSERT INTO `submission` VALUES (1, 1, '1', '毕业设计', '选题背景： 随着科技的迅速发展，数字化校园建设已经成为高校管理的必然趋势。在这一背景下，学生毕业设计管理系统作为一种前后端分离的应用，针对毕业设计的全过程进行管理和优化，具有重要的实际意义。目前，许多高校的毕业设计管理仍然采用传统的纸质登记方式，存在着信息不便捷、管理效率低下的问题。如何通过现代化的信息技术手段来提升毕业设计管理的效率和质量，成为一个亟待解决的问题。\n\n课题简介： 随着互联网技术的飞速发展，高校毕业设计管理亟需现代化、智能化的解决方案。本系统的设计旨在通过前后端分离的方式，充分利用现代化的开发工具和框架，为高校提供一套高效、便捷、智能的毕业设计管理系统。系统的核心功能包括学生模块、教师模块和管理员模块。学生模块包括选题申请、进度查看、资料上传等功能；教师模块包括审核选题、评定成绩、指导学生等功能；管理员模块包括用户管理、数据统计、系统配置等功能。系统的技术实现采用Java语言，并以前后端分离的架构设计为基础，通过MySQL数据库进行数据存储。前端页面采用JavaScript进行设计，后端则使用SSM框架实现系统的业务逻辑。整个系统在IDEA开发工具下进行开发，并通过Tomcat作为项目服务器进行部署。\n\n通过该系统的实施，高校毕业设计管理流程将更加智能、透明，实现了对整个流程的全程监控和高效管理。系统的应用将大大提高毕业设计管理的效率，降低了管理成本，为高校提供了一种先进的、可持续发展的管理模式。同时，该系统也为未来高校数字化校园建设提供了有益的借鉴和经验。', '计算机应用技术;计算机软件与理论', '中文', NULL, NULL);

-- ----------------------------
-- Table structure for thesis
-- ----------------------------
DROP TABLE IF EXISTS `thesis`;
CREATE TABLE `thesis`  (
  `studentID` int NOT NULL COMMENT '论文学生ID',
  `thesisDraftTeacherReview` tinyint NULL DEFAULT NULL COMMENT '初稿教师审核',
  `thesisDraftExpertReview` tinyint NULL DEFAULT NULL COMMENT '初稿专家审核',
  `thesisDraftEditReview` tinyint NULL DEFAULT NULL COMMENT '初稿修改审核',
  `ThesisFinalizeTeacherView` tinyint NULL DEFAULT NULL COMMENT '定稿教师审核',
  `ThesisFinalizeExpertReview` tinyint NULL DEFAULT NULL COMMENT '定稿专家审核',
  `ThesisFinalTeacherReview` tinyint NULL DEFAULT NULL COMMENT '终稿教师审核',
  `ThesisFinalExpertReview` tinyint NULL DEFAULT NULL COMMENT '终稿专家审核',
  PRIMARY KEY (`studentID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of thesis
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `userId` int NOT NULL COMMENT '用户ID(学生学号教师教务号)',
  `userType` int NULL DEFAULT NULL COMMENT '用户类型(管理0教务1教师2学生3)',
  `userRealName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户真实姓名',
  `userName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `sexual` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `accountCreateTime` datetime NULL DEFAULT NULL COMMENT '账号创建时间',
  `phoneNum` bigint NULL DEFAULT NULL COMMENT '电话号码',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱地址',
  `ancestralPlace` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '籍贯',
  `politicalStatus` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '政治面貌',
  `groupID` int NULL DEFAULT NULL COMMENT '分组号',
  `userAge` int NULL DEFAULT NULL COMMENT '年龄',
  `accountChangeTime` datetime NULL DEFAULT NULL COMMENT '账号最近一次修改时间',
  `userAcademy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户所属学院(学生教师)',
  `userMajor` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户所属专业(学生教师)',
  `userClass` int NULL DEFAULT NULL COMMENT '用户所属班级(学生)',
  PRIMARY KEY (`userId`) USING BTREE,
  UNIQUE INDEX `userId`(`userId` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1000000000, 0, 'Admin', 'admin', 'admin', '', '2024-03-21 12:24:55', NULL, '', '', '', 1, NULL, '2024-03-21 13:13:58', '管理员', '计算机科学与技术', NULL);
INSERT INTO `user` VALUES (1000000001, 3, '李冉', 'student1', 'student1', '0', '2024-03-19 19:18:52', 11111111111, '2824574830@qq.com', '山东省青岛市', '群众', 2, 21, '2024-03-19 19:18:53', '计算机科学与技术学院', '计算机科学与技术', 2011);
INSERT INTO `user` VALUES (1000000002, 3, '张三', 'student2', 'student2', '1', '2024-03-19 15:41:51', 22222222222, '111@qq.com', '江苏省南京市', '共青团员', 3, 22, '2024-03-19 13:46:17', '计算机科学与技术学院', '大数据', 2001);
INSERT INTO `user` VALUES (1000000003, 0, '李四', 'student3', ' student3', '1', '2024-03-19 15:41:55', 33333333333, '222@qq.com', '浙江省杭州市', '党员', 4, 20, '2024-03-21 13:12:17', '计算机科学与技术学院', '软件开发', 2003);
INSERT INTO `user` VALUES (1000000004, 2, '张益达', 'teacher1', 'teacher1', '0', '2024-03-19 15:43:16', 44444444444, '333@qq.com', '北京市海淀区', '党员', 1, 35, '2024-03-15 01:00:00', '化学与化工学院', '', NULL);
INSERT INTO `user` VALUES (1000000005, 2, '李四', 'student4', 'student4', '1', '2024-03-19 15:59:41', 33333333333, '222@qq.com', '浙江省杭州市', '党员', 6, 20, '2024-03-19 15:59:41', '生命科学院', '网络工程', NULL);
INSERT INTO `user` VALUES (1000000007, 2, '王大炮', 'teacher12', 'teacher12', '0', '2024-03-19 15:43:34', 89899898889, '88@qq.com', '上海市', '预备党员', 2, 32, '2024-03-21 13:02:40', '计算机科学与技术学院', '大数据', 2001);
INSERT INTO `user` VALUES (1000000008, 3, '赵四', 'student8', 'student1', '0', '2024-03-21 12:54:44', 88888888888, '88@qq.com', '上海市', '群众', 3, 22, '2024-03-21 13:01:34', '生命科学院', '计算机科学与技术', 2001);
INSERT INTO `user` VALUES (1000000009, 3, '章三', 'students9', 'students9', '0', '2024-03-21 13:06:41', 9999999999, '999@qq.com', '新疆', '共青团员', 6, 24, '2024-03-21 13:06:41', '化学院', '我也不知道', 1001);
INSERT INTO `user` VALUES (1111111111, 1, '教务1', 'teacher3', 'teacher3', '1', '2024-03-21 13:07:35', 12312312313, '1', '1231231', '党员', NULL, 42, '2024-03-21 14:59:06', '教务', '教务', NULL);

SET FOREIGN_KEY_CHECKS = 1;
