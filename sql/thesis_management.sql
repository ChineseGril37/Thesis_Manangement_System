/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80036 (8.0.36)
 Source Host           : localhost:3306
 Source Schema         : thesis_management

 Target Server Type    : MySQL
 Target Server Version : 80036 (8.0.36)
 File Encoding         : 65001

 Date: 01/04/2024 15:15:20
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of deadline
-- ----------------------------
INSERT INTO `deadline` VALUES (1, '2024-03-20 00:00:00', '2024-03-22 23:59:59', '2024-04-04 00:00:00', '2024-04-06 00:00:00', '2024-04-09 00:00:00', '2024-04-17 00:00:00', '2024-04-23 00:00:00', '2024-04-30 00:00:00');

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of file
-- ----------------------------

-- ----------------------------
-- Table structure for midcheck
-- ----------------------------
DROP TABLE IF EXISTS `midcheck`;
CREATE TABLE `midcheck`  (
  `midcheckID` int NOT NULL AUTO_INCREMENT COMMENT '中期检查ID',
  `groupID` int NULL DEFAULT NULL COMMENT '所属小组ID',
  `midcheckSummary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '阶段性总结',
  `midcheckProblem` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '存在的问题',
  `midcheckTeacherReview` tinyint NULL DEFAULT NULL COMMENT '中期检查教师审核',
  `midcheckExpertReview` tinyint NULL DEFAULT NULL COMMENT '中期检查专家审核',
  PRIMARY KEY (`midcheckID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of midcheck
-- ----------------------------
INSERT INTO `midcheck` VALUES (1, 1, '321', '123', NULL, NULL);

-- ----------------------------
-- Table structure for mission
-- ----------------------------
DROP TABLE IF EXISTS `mission`;
CREATE TABLE `mission`  (
  `missionID` int NOT NULL AUTO_INCREMENT COMMENT '任务书ID',
  `groupID` int NULL DEFAULT NULL COMMENT '所属小组ID',
  `missionGoal` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '课题目标',
  `missionContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '课题任务内容',
  `missionPlan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '课题进度安排',
  `missionReferences` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '参考文献',
  `missionTeacherReview` tinyint NULL DEFAULT NULL COMMENT '任务书教师审核',
  `missionExpertReview` tinyint NULL DEFAULT NULL COMMENT '任务书专家审核',
  PRIMARY KEY (`missionID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mission
-- ----------------------------
INSERT INTO `mission` VALUES (1, 1, '选题背景： 随着科技的迅速发展，数字化校园建设已经成为高校管理的必然趋势。在这一背景下，学生毕业设计管理系统作为一种前后端分离的应用，针对毕业设计的全过程进行管理和优化，具有重要的实际意义。目前，许多高校的毕业设计管理仍然采用传统的纸质登记方式，存在着信息不便捷、管理效率低下的问题。如何通过现代化的信息技术手段来提升毕业设计管理的效率和质量，成为一个亟待解决的问题。\n\n课题简介： 随着互联网技术的飞速发展，高校毕业设计管理亟需现代化、智能化的解决方案。本系统的设计旨在通过前后端分离的方式，充分利用现代化的开发工具和框架，为高校提供一套高效、便捷、智能的毕业设计管理系统。系统的核心功能包括学生模块、教师模块和管理员模块。学生模块包括选题申请、进度查看、资料上传等功能；教师模块包括审核选题、评定成绩、指导学生等功能；管理员模块包括用户管理、数据统计、系统配置等功能。系统的技术实现采用Java语言，并以前后端分离的架构设计为基础，通过MySQL数据库进行数据存储。前端页面采用JavaScript进行设计，后端则使用SSM框架实现系统的业务逻辑。整个系统在IDEA开发工具下进行开发，并通过Tomcat作为项目服务器进行部署。\n\n本设计应实现毕业设计管理系统的功能，包括开题报告申报、修改、审核，任务书申报、修改、审核，中期检查申报、修改、审核，论文初稿、定稿、最终稿的提交和查重，答辩信息管理等：', '学生用户登录后可以完善自己的信息，查看公告和进行毕业设计流程的申报修改\n\n指导教师登录后可以进行管理指导小组，查看公告和进行所指导学生的毕业设计流程审核与修改\n\n管理员登录后可以查看与修改教师与学生个人信息，对毕业设计特殊情况流程进行直接修改与退回，修改用户账户与密码等', '第一阶段 撰写开题报告\n\n第二阶段 完成了需求分析\n\n第三阶段 完成了系统详细设计（数据库设计、界面设计）\n\n第四阶段 完成了详细编码阶段（代码以及功能的实现）设计\n\n第五阶段 完成了系统测试以及完善\n\n第六阶段 撰写论文以及修改', '[1]廖丽,杨小国.基于B/S模式的学生毕业设计管理系统的设计和应用[J].信息与电脑(理论版). 2018(22)\n\n[2]刘继华,路晓梦,张志宏,李佳仪.基于SSM框架的毕业设计管理系统设计与实现[J].吕梁学院学报. 2020,10(02)\n\n[3]孙超.“互联网+”背景下毕业设计管理系统的研究与设计[J].吉林工程技术师范学院学报. 2023,39(08)\n\n[4]黑马程序员.Java基础入门（第二版）[M].北京：清华大学出版社，2018：99-120.\n\n[5]Feng Xiaoping,Wei Fanqi, Zhang Yan.Design and Implementation of Graduation Thesis Management System[J].Advances in Computer Science Research (ACSR), volume 73\n\n[6]Yopi Nugraha Yopi.Web-Based Thesis Management Information System Design[j].Junrnal dan Penelitian Teknik Informatika, Volume 7, Number 4,Oktober 2022\n\n[7]彭灿华.基于云平台的高校毕业设计管理系统设计与实现[J].无线互联科技. 2021,18(07)\n\n[8]刘晓东,张静.高校毕业设计(论文)教学管理信息系统应用探讨[J].科技与创新. 2020(21)\n\n[9]赵洁.本科毕业设计(论文)教学管理信息系统的应用研究[J].广东工业大学学报(社会科学版). 2007(S1)\n\n[10]喻小光,陈霞,陈婧,张俊元.面向工程认证的毕业设计管理系统设计与实现[J].电子技术与软件工程. 2022(20)\n\n[11]Taizhi Lv;Jun Zhang.The Design and Implementation of Graduation Thesis Management System[J]. Academic Journal of Computing & Information Science. Volume 2 , Issue 1 . 2019\n\n[12]闫丹.基于JSP毕业设计选题管理系统设计与实现[J]重庆文理学院学报. 2013,32(03)', NULL, NULL);
INSERT INTO `mission` VALUES (2, 2, 'dwa', '达瓦', '达瓦', '哇哇', NULL, NULL);

-- ----------------------------
-- Table structure for oraldefense
-- ----------------------------
DROP TABLE IF EXISTS `oraldefense`;
CREATE TABLE `oraldefense`  (
  `oralDefenseID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '答辩ID',
  `studentID` int NULL DEFAULT NULL COMMENT '答辩学生ID',
  `groupID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '答辩小组ID',
  `oralDefensePosition` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '答辩组地点',
  `oralDefenseDate` datetime NULL DEFAULT NULL COMMENT '答辩日期',
  `oralDefenseHolder` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '答辩组组长',
  `oralDefenseRecorder` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '答辩录入员',
  `oralDefenseGrades` double NULL DEFAULT NULL COMMENT '答辩成绩',
  PRIMARY KEY (`oralDefenseID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
  `submissionID` int NULL DEFAULT NULL COMMENT '课题申报ID',
  `reportID` int NULL DEFAULT NULL COMMENT '开题报告ID',
  `missionID` int NULL DEFAULT NULL COMMENT '任务书ID',
  `midcheckID` int NULL DEFAULT NULL COMMENT '中期检查ID',
  `oralID` int NULL DEFAULT NULL COMMENT '答辩ID',
  PRIMARY KEY (`processID` DESC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of process
-- ----------------------------
INSERT INTO `process` VALUES (3, '课题', 1000000004, 2, '2024-03-30 09:03:05', '2024-03-30 08:53:25', '2024-04-18 00:00:00', '任务书审核通过', 3, 2, 2, NULL, NULL);
INSERT INTO `process` VALUES (1, '基于Java的前后端分离毕业设计管理系统的设计与实现', 1000000000, 1, '2024-03-30 07:37:57', '2024-03-29 13:06:09', '2024-04-21 00:00:00', '中期检查审核通过', 1, 1, 1, 1, NULL);

-- ----------------------------
-- Table structure for report
-- ----------------------------
DROP TABLE IF EXISTS `report`;
CREATE TABLE `report`  (
  `reportID` int NOT NULL AUTO_INCREMENT COMMENT '开题报告ID',
  `groupID` int NULL DEFAULT NULL COMMENT '所属小组ID',
  `reportMeaning` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '研究目的',
  `reportSituation` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '研究现状',
  `reportAim` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '研究目标',
  `reportWay` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '研究方案',
  `reportTeacherReview` tinyint NULL DEFAULT NULL COMMENT '开题报告教师审核',
  `reportExpertReview` tinyint NULL DEFAULT NULL COMMENT '开题报告专家审核',
  PRIMARY KEY (`reportID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of report
-- ----------------------------
INSERT INTO `report` VALUES (1, 1, '毕业设计是高校本科教育的重要组成部分，是检验学生综合素质和专业能力的重要手段。然而，随着高校规模的扩大和学生数量的增加，传统的毕业设计管理方式存在着许多问题，如信息不畅、流程不规范、效率不高、质量不易控制等，给教学管理带来了诸多困难。为了解决这些问题，提高毕业设计管理的水平，本文提出了一种基于互联网的毕业设计管理系统，旨在实现毕业设计管理的数字化、网络化、智能化和规范化。  本文的研究目的是设计并实现一个毕业设计管理系统，该系统能够满足以下要求：  - 能够实现毕业设计的各个环节的管理，包括选题、指导、评阅、答辩、成绩、优秀论文等；  - 能够提供方便的信息交流和查询功能，方便教师、学生、教务等各方的沟通和协作；  - 能够提供数据分析和统计功能，方便教学管理和质量监控；  - 能够提供安全和稳定的运行环境，保证数据的完整性和可靠性。  - 有利于提高毕业设计的教学质量，促进学生的创新能力和实践能力的培养；  - 有利于提高毕业设计的管理效率，减轻教师和教务的工作负担，节省人力和物力资源；  - 有利于提高毕业设计的管理水平，实现毕业设计管理的标准化和规范化，保证毕业设计的公平性和合理性；  - 有利于提高毕业设计的信息化水平，构建数字化校园，适应现代社会的发展趋势。  毕业设计管理系统具有广泛的应用前景，可以适用于不同规模和类型的高校，为高校的毕业设计教学和管理提供有效的支持。该系统还可以根据不同高校的实际需求，进行定制化的开发和改进，以满足不同高校的特殊要求。该系统还可以与其他教学管理系统进行集成，形成一个完整的教学管理信息系统，为高校的教学管理提供更全面的服务。', '学生宿舍管理系统对于高校来说是整个管理系统的一个重要组成部分。当今社会的飞速发展，原始的记录方式将逐渐被竞争所淘汰，计算机化管理是顺应时代发展的产物。我国在全国范围内推广计算机在管理系统中的应用，是在七十年代末开始的，与发达国家比起来起步较晚，应用水平有较大差距。\n\n在国外高校，他们一般具有较大规模的稳定的技术队伍来提供服务与技术支持。而国内高校信息化建设相对起步较晚。在数字校园理论逐步应用的过程中，各高校一方面不断投资构建各种硬件、系统软件和网络；另一方面也不断开发实施了各类教学、科研、办公管理等应用系统，形成了一定规模的信息化建设体系。国内高校，由于整体信息化程度相对落后，经费短缺，理论体系不健全等原因，国内高校宿舍管理系统在机构设置、服务范围、服务质量以及人员要求上与国外高校比都有一定差距。\n\n中国的高校历来是科学技术的源泉。但调查显示，现在国内大多数学校的学生宿舍还未实现信息化，主要还是停留在手工管理的形式。宿舍管理效率低下，需要大量的人力和物力，所以各个高校已经逐渐意识到了宿舍管理系统的价值和重要性，并且一部分学校已经开始公开招标来满足自己的需要。国内高校学生宿舍管理正由传统模式向高效、快捷的现代化管理过渡。\n\n纵观目前国内外研究现状，国内宿舍管理系统在安全性和信息更新化方面与发达国家还存在一定差距，各现有系统资料单独建立，共享性差；在以管理者为主体的方式中，信息取舍依赖于管理者对于信息的认知与喜好，较不容易掌握用户的真实需求，也就无法满足用户的需要。因此，传统的宿舍管理应朝数字化、无纸化、智能化、综合化的方向发展，并为进一步实现完善的计算机宿舍管理系统打下良好基础。', '本课题的研究目标是开发一个基于SSM技术的毕业论文管理系统，其开发主要包括数据库、后台管理以及前台页面的设计。本设计使用Java语言来实现，运用了IDEA开发工具，MySQL数据库，实现了毕业论文课题申报、开题报告提交、论文初稿提交、论文定稿提交、答辩信息查询等功能。主界面的设计需要简洁明了，方便操作，管理人员需要进行用户登录才可以进行各个模块的操作，保证管理的安全；其次，对毕业设计信息在完成每次操作以后，通过各个模块之间的联系，对各信息要做出相应的即时更新，实现各个功能模块的统一。\n\n高校毕业设计（论文）管理信息系统应用普及。该系统的设计以满足每个使用该系统的用户的方便性和实用性为原则。系统采用先进成熟的技术和框架，保证安全性、易扩展性、实用性，让用户有良好的使用体验。系统设计过程应遵循以下重要原则:\n\n(1）实用性原则：对于系统用户来说，实用性是至关重要的，是设计的出发点；\n\n(2）成熟性原则：系统采用成熟的软件技术，使毕业论文管理系统具有更长的使用寿命。\n\n(3）高性能运行原则：高校毕业设计论文管理系统需要同时支持众多用户，因此要求应用程序必须承受高强度使用的巨大压力。\n\n(4）开放性原则：毕业设计论文管理系统能够满足多角色使用，功能明确，这就要求系统具有良好的开放性，能够实现多种技术和开发平台的有机结合。\n\n(5）高安全性原则：毕业论文（项目）管理系统是一个开放的系统，任何人在任何地方都可以访问。因此，必须采取网络安全设计[5]。\n\n研究内容:\n\n在系统的设计中，主要使用MVC模式进行开发，使用SpringBoot框架实现系统功能，使用Vue前端框架进行系统的页面设计。\n\n毕业设计管理系统需要实现的基本功能主要包括：登录、注册、注销、记住密码、忘记密码、查看个人信息。\n\n系统主要功能如下：\n\n（一）学生模块\n\n1. 注册、登录：学生可以注册新用户；账号密码核对实现登录。\n\n2. 个人信息：学生可以查看学生本人的基本信息。\n\n3. 公告消息：在首页导航栏上我们会看到“公告消息”这一菜单，我们点击进入进去以后，会看到所有管理员在后台发布的公告信息；\n\n4. 课题申报：学生可以新建课题申报以及修改未审核课题，查询已提交课题审核状态。\n\n5. 开题报告提交：学生可以新建、修改、提交开题报告。\n\n6. 填写任务书：学生可以新建、修改、提交任务书。\n\n7. 中期检查：学生可以新建、修改、提交中期检查，提交之后等待教师审批。\n\n8. 论文初稿、定稿、最终稿：学生可以新建、修改、提交论文初稿及定稿、最终稿。\n\n9. 答辩信息查询：学生可查询所在答辩小组信息，线下答辩后的评阅答辩信息等。\n\n10. 教师评价：完成毕业设计后可对指导老师进行评价。\n\n11. 优秀论文摘要：查看评选出的优秀论文摘要\n\n12. 过程文件导出：将开题报告、任务书、中期检查、论文初稿、定稿、最终稿等过程文件导出下载。\n\n（二）教师模块\n\n1. 登录：账号密码核对实现登录。\n\n2. 学生信息：教师可以查看学生的基础信息。\n\n3. 学生管理：教师可以查看所指导学生信息，并执行相关操作。\n\n4. 课题管理：教师可以查看所指导学生提交课题，查看课题进度总体情况。\n\n5. 公告消息：在首页导航栏上我们会看到“公告消息”这一菜单，我们点击进入进去以后，会看到所有管理员在后台发布的公告信息；\n\n6. 课题审批：教师可以查看学生的课题提报记录，并对学生课题申请进行审批。\n\n7. 个人信息：教师可以查看、修改个人信息。\n\n（三）管理员模块\n\n1. 登录：账号密码核对实现登录，管理员账号在数据库中直接注册。\n\n2. 用户管理：管理员可以查看所有用户信息，并执行相关操作。\n\n3. 角色管理：管理员可以查看所有角色信息，并执行相关操作。\n\n4. 教师系统：管理员可以查看学生信息。\n\n5. 学生系统：管理员可以查看学生课题流程信息。\n\n6. 课题信息：管理员可以查看、修改课题信息。\n\n7. 模块管理：管理员可以课题申报与管理、论文管理、特殊情况处理、表格导出、个人信息管理等五个子菜单进行增删改查等操作。\n\n拟解决的主要问题:\n\n（1）一条课题流程在学生修改时老师进行审核的先后占用顺序问题\n\n（2）理清系统中部分功能之间的逻辑问题。\n\n创新点或特色:\n\n1）学生推进课题流程后，学生所关联的指导老师账号所绑定的邮箱将在未处理课题流程1小时后收到督办邮件，便于加快课题流程的推进。\n\n2）学生在论文初稿中可便捷使用系统内部接入的查重API进行快速查重\n\n3）课题提交申请通过后的特色情况：修改开题报告、修改论文定稿、评阅教师评阅退回等\n\n4）页面整洁，操作便捷。\n\n系统可维护性高，添加新功能或修改部分功能不会影响其他已实现功能。', '研究方案:\n\n1.首先查阅相关文献资料，了解毕业论文管理系统信息管理现状；\n\n2.其次对毕业论文管理系统做需求分析，从实际应用出发；\n\n3.理清思路设计数据库、设计功能模块；\n\n4.进行详细代码设计、用户界面设计，并进行一定的测试。\n\n研究方法:\n\n毕业论文管理系统信息是基于SSM框架，SSM框架是Spring、SpringMVC、Mybatis的有机整合，简化开发，采用MySQL数据库进行开发，运用了IDEA作为开发工具，使用Java作为开发语言，采用Tomcat服务器作为技术支持，利用SpringBoot技术进行页面设计以及数据的读取，前端使用Vue框架，系统采用了MVC模式进行开发，提高代码重用率，可以对系统功能进行有效地维护和拓展。\n\n研究进度安排:\n\n第一阶段：查阅相关文献资料，完成需求分析，撰写开题报告；\n\n第二阶段：完成数据库设计、框架搭建、页面设计；\n\n第三阶段：完成系统各模块功能；\n\n第四阶段：系统调试，撰写论文；\n\n        第五阶段：修改论文，论文定稿。', NULL, NULL);
INSERT INTO `report` VALUES (2, 2, '321', '312', '321', '312', NULL, NULL);

-- ----------------------------
-- Table structure for submission
-- ----------------------------
DROP TABLE IF EXISTS `submission`;
CREATE TABLE `submission`  (
  `submissionID` int NOT NULL AUTO_INCREMENT COMMENT '课题申报ID',
  `groupID` int NULL DEFAULT NULL COMMENT '所属小组ID',
  `submissionBase` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '是否以实验、实习、工程实践和社会调查为基础',
  `submissionType` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '课题类别',
  `submissionBrief` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '选题依据及课题简介',
  `submissionDirection` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '论文研究方向',
  `submissionLanguage` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '撰写语种',
  `submissionTeacherReview` tinyint NULL DEFAULT NULL COMMENT '课题申报教师审核',
  `submissionExpertReview` tinyint NULL DEFAULT NULL COMMENT '课题申报专家审核',
  PRIMARY KEY (`submissionID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of submission
-- ----------------------------
INSERT INTO `submission` VALUES (1, 1, '1', '毕业设计', '选题背景： 随着科技的迅速发展，数字化校园建设已经成为高校管理的必然趋势。在这一背景下，学生毕业设计管理系统作为一种前后端分离的应用，针对毕业设计的全过程进行管理和优化，具有重要的实际意义。目前，许多高校的毕业设计管理仍然采用传统的纸质登记方式，存在着信息不便捷、管理效率低下的问题。如何通过现代化的信息技术手段来提升毕业设计管理的效率和质量，成为一个亟待解决的问题。\n\n课题简介： 随着互联网技术的飞速发展，高校毕业设计管理亟需现代化、智能化的解决方案。本系统的设计旨在通过前后端分离的方式，充分利用现代化的开发工具和框架，为高校提供一套高效、便捷、智能的毕业设计管理系统。系统的核心功能包括学生模块、教师模块和管理员模块。学生模块包括选题申请、进度查看、资料上传等功能；教师模块包括审核选题、评定成绩、指导学生等功能；管理员模块包括用户管理、数据统计、系统配置等功能。系统的技术实现采用Java语言，并以前后端分离的架构设计为基础，通过MySQL数据库进行数据存储。前端页面采用JavaScript进行设计，后端则使用SSM框架实现系统的业务逻辑。整个系统在IDEA开发工具下进行开发，并通过Tomcat作为项目服务器进行部署。\n\n通过该系统的实施，高校毕业设计管理流程将更加智能、透明，实现了对整个流程的全程监控和高效管理。系统的应用将大大提高毕业设计管理的效率，降低了管理成本，为高校提供了一种先进的、可持续发展的管理模式。同时，该系统也为未来高校数字化校园建设提供了有益的借鉴和经验。', '计算机应用技术;计算机软件与理论', '中文', NULL, NULL);
INSERT INTO `submission` VALUES (3, 2, '1', '毕业设计', '简介', '方向', '中文', NULL, NULL);

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of thesis
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `userID` int NOT NULL COMMENT '用户ID(学生学号教师教务号)',
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
  PRIMARY KEY (`userID`) USING BTREE,
  UNIQUE INDEX `userId`(`userID` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1000000000, 0, 'Admin', 'admin', 'admin', '', '2024-03-21 12:24:55', NULL, '', '', '', 1, NULL, '2024-03-29 20:55:27', '管理员', '计算机科学与技术', NULL);
INSERT INTO `user` VALUES (1000000001, 3, '李冉', 'student1', 'student1', '0', '2024-03-19 19:18:52', 11111111111, '2824574830@qq.com', '山东省', '群众', 2, 21, '2024-03-19 19:18:53', '计算机科学与技术学院', '计算机科学与技术专业', 2011);
INSERT INTO `user` VALUES (1000000002, 3, '李峰', 'student2', 'student2', '1', '2024-02-23 08:44:33', 11111111111, 'lifeng@qq.com', '江苏省', '群众', 3, 23, '2024-03-29 20:53:33', '计算机科学与技术学院', '计算机科学与技术专业', 1001);
INSERT INTO `user` VALUES (1000000003, 2, '王磊', 'teacher1', 'teacher1', '0', '2024-03-22 09:13:47', 22222222222, 'wanglei@163.com', '云南省', '党员', 3, 43, '2024-03-29 20:55:08', '化学院', '化学专业', NULL);
INSERT INTO `user` VALUES (1000000004, 3, '崔明', 'student3', 'student3', '0', '2024-03-09 16:32:16', 33333333333, 'cuiming@gmail.com', '新疆省', '群众', 2, 19, '2024-03-29 22:48:38', '数学院', '应用数学专业', 3109);
INSERT INTO `user` VALUES (1000000005, 3, '薄浩瀚', 'student4', 'student4', '1', '2024-03-23 13:02:23', 44444444444, 'bominghan@qq.com', '江苏省', '共青团员', 3, 20, '2024-03-21 22:51:36', '商学院', '会计专业', 2019);
INSERT INTO `user` VALUES (1000000006, 2, '章北海', 'teacher2', 'teacher2', '0', '2024-01-18 03:03:18', 55555555555, 'zhangbeihai@outlook.com', '上海市', '党员', 2, 39, '2024-03-01 11:54:27', '计算机科学与技术学院', '软件工程专业', NULL);
INSERT INTO `user` VALUES (1000000007, 1, '善皓', 'order1', 'order1', '0', '2024-02-14 03:34:56', 66666666666, 'shanhao@qq.com', '北京市', '群众', NULL, 43, '2024-03-02 12:43:04', '教务处', '教务处', NULL);
INSERT INTO `user` VALUES (1000000008, 3, '潘虹', 'student7', 'student7', '0', '2024-03-29 23:08:15', 78777777777, 'panhong@163.com', '陕西省', '预备党员', 4, 18, '2024-03-29 23:08:15', '化学院', '材料学专业', 3010);
INSERT INTO `user` VALUES (1000000009, 3, '黄海路', 'student8', 'student8', '1', '2024-03-29 23:12:19', 99999999999, 'huanghailu@gmail.com', '山西省', '共青团员', 4, 23, '2024-03-29 23:12:19', '计算机科学与技术学院', '电子信息工程专业', 2007);
INSERT INTO `user` VALUES (1000000010, 2, '姜世贞', 'teacher3', 'teacher3', '0', '2024-03-29 23:14:16', 10000000011, 'jiangshizhen@qlys.com', '福建省', '民主党派人士', 4, 44, '2024-03-29 23:14:16', '数学院', '理论数学专业', NULL);

SET FOREIGN_KEY_CHECKS = 1;
