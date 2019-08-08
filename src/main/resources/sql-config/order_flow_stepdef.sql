-- 订单步骤配置表 order_flow_step_def
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('balTransfer', '__start', 'balTransfer_users', '{\"name\":\"jumpToNext\",\"category\":\"1\",\"url\":\"http://172.18.5.110:9003/account/autoTask\",\"restMethod\":\"checkTransferBalance\",\"runExpress\":\"0/3 * * * * ?\",\"retryExpress\":\"0/10 * * * * ?\",\"maxThreadNumber\":\"15\",\"initThreadNumber\":\"1\",\"keepAliveTime\":\"100\",\"queneSize\":\"20\"}', '0,-1,__start,0;', '0,0,__end,0;', '0,default,__start,0;', 'immediately', 'test', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('balTransfer', '__end', 'balTransfer_users', NULL, '0,0,__end,0;', '0,0,__end,0;', '0,default,__end,0;', 'immediately', 'test', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('balTransferSysToUnion', '__end', 'balTransferSysToUnion', NULL, '0,0,__end,0;', '0,0,__end,0;', '0,default,__end,0;', 'immediately', 'test', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('balTransferSysToUnion', '__start', 'balTransferSysToUnion', '{\"name\":\"jumpToNext\",\"category\":\"1\",\"url\":\"http://172.18.5.110:9003/account/autoTask\",\"restMethod\":\"checkTransferBalanceSysToUser\",\"runExpress\":\"0/3 * * * * ?\",\"retryExpress\":\"0/10 * * * * ?\",\"maxThreadNumber\":\"15\",\"initThreadNumber\":\"1\",\"keepAliveTime\":\"100\",\"queneSize\":\"20\"}', '0,-1,__start,0;', '0,0,__end,0;', '0,default,__start,0;', 'immediately', 'test', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('balTransferUnionToSys', '__start', 'balTransferUnionToSys', '{\"name\":\"jumpToNext\",\"category\":\"1\",\"url\":\"http://172.18.5.110:9003/account/autoTask\",\"restMethod\":\"checkTransferBalanceUserToSys\",\"runExpress\":\"0/3 * * * * ?\",\"retryExpress\":\"0/10 * * * * ?\",\"maxThreadNumber\":\"15\",\"initThreadNumber\":\"1\",\"keepAliveTime\":\"100\",\"queneSize\":\"20\"}', '0,-1,__start,0;', '0,0,__end,0;', '0,default,__start,0;', 'immediately', 'test', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('balTransferUnionToSys', '__end', 'balTransferUnionToSys', NULL, '0,0,__end,0;', '0,0,__end,0;', '0,default,__end,0;', 'immediately', 'test', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('bal_reduce_club_to_room', '__start', 'start', '{\"name\":\"checkPlaying\",\"category\":\"2\",\"url\":\"http://172.18.5.110:9003/game\",\"restMethod\":\"autoBet\",\"queneSize\":\"1000\",\"keepAliveTime\":\"100\",\"initThreadNumber\":\"20\",\"maxThreadNumber\":\"20\",\"runExpress\":\"0/3 * * * * ?\",\"retryExpress\":\"0/3 * * * * ?\"}', '2,-1,1001,__start,0;', '0,0,__end,0;', '0,default,checkflop,0;', 'immediately', '3', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('bal_reduce_game', '__start', 'start', '{\"name\":\"checkPlaying\",\"category\":\"2\",\"url\":\"http://172.18.5.110:9003/game\",\"restMethod\":\"autoBet\",\"queneSize\":\"1000\",\"keepAliveTime\":\"100\",\"initThreadNumber\":\"20\",\"maxThreadNumber\":\"20\",\"runExpress\":\"0/3 * * * * ?\",\"retryExpress\":\"0/3 * * * * ?\"}', '2,-1,1001,__start,0;', '0,0,__end,0;', '0,default,checkflop,0;', 'immediately', '3', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('bal_reduce_room_to_club', '__start', 'start', '{\"name\":\"checkPlaying\",\"category\":\"2\",\"url\":\"http://172.18.5.110:9003/game\",\"restMethod\":\"autoBet\",\"queneSize\":\"1000\",\"keepAliveTime\":\"100\",\"initThreadNumber\":\"20\",\"maxThreadNumber\":\"20\",\"runExpress\":\"0/3 * * * * ?\",\"retryExpress\":\"0/3 * * * * ?\"}', '2,-1,1001,__start,0;', '0,0,__end,0;', '0,default,checkflop,0;', 'immediately', '3', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('category_modifyClub', '__start', 'category_modifyClub_start', '{\"name\":\"category_modifyUser_start\",\"category\":\"1\",\"url\":\"http://172.18.5.110:9003/club/manage\",\"restMethod\":\"updateClubUserRelation\",\"runExpress\":\"0/3 * * * * ?\",\"retryExpress\":\"0/10 * * * * ?\",\"maxThreadNumber\":\"15\",\"initThreadNumber\":\"1\",\"keepAliveTime\":\"100\",\"queneSize\":\"20\"}', '0,-1,__start,0;', '0,0,__end,0;', '0,0,__start,0;', 'immediately', 'test', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('category_modifyClub', '__end', 'category_modifyClub_end', '', '0,0,__end,0;', '0,0,__end,0;', '0,0,__end,0;', 'immediately', 'test', '0');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('category_modifyUser', '__start', 'category_modifyUser_start', '{\"name\":\"category_modifyUser_start\",\"category\":\"1\",\"url\":\"http://172.18.5.110:9003/userInfo\",\"restMethod\":\"updateUserInfo\",\"runExpress\":\"0/3 * * * * ?\",\"retryExpress\":\"0/10 * * * * ?\",\"maxThreadNumber\":\"15\",\"initThreadNumber\":\"1\",\"keepAliveTime\":\"100\",\"queneSize\":\"20\"}', '0,-1,__start,0;', '0,0,__end,0;', '0,0,__start,0;', 'immediately', 'test', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('category_modifyUser', '__end', 'category_modifyUser_end', '', '0,0,__end,0;', '0,0,__end,0;', '0,0,__end,0;', 'immediately', 'test', '0');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('coojisu_playing', '__start', 'start', '{\"name\":\"checkPlaying\",\"category\":\"1\",\"url\":\"http://172.18.10.74:9003/game\",\"restMethod\":\"autoBet\",\"queneSize\":\"1000\",\"keepAliveTime\":\"100\",\"initThreadNumber\":\"20\",\"maxThreadNumber\":\"20\",\"runExpress\":\"0/4 * * * * ?\",\"retryExpress\":\"0/4 * * * * ?\"}', '0,2,checkflop,0;0,4,checkturn,0;0,9,nextGame,0;0,10030,__end,0;0,11,nextGame,0;', '0,0,nextGame,0;', '0,default,checkflop,0;', 'immediately', '8', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('coojisu_playing', 'checkflop', 'checkflop', '{\"name\":\"checkPlaying\",\"category\":\"1\",\"url\":\"http://172.18.10.74:9003/game\",\"restMethod\":\"autoBet\",\"queneSize\":\"1000\",\"keepAliveTime\":\"100\",\"initThreadNumber\":\"20\",\"maxThreadNumber\":\"20\",\"runExpress\":\"0/4 * * * * ?\",\"retryExpress\":\"0/4 * * * * ?\"}', '0,2,__start,0;0,4,checkturn,0;0,6,checkturn,0;0,8,checkturn,0;0,9,nextGame,0;0,10030,__end,0;0,11,nextGame,0;', '0,0,nextGame,0;', '0,default,__start,0;', 'immediately', '8', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('coojisu_playing', 'checkturn', 'checkturn', '{\"name\":\"checkPlaying\",\"category\":\"1\",\"url\":\"http://172.18.10.74:9003/game\",\"restMethod\":\"autoBet\",\"queneSize\":\"1000\",\"keepAliveTime\":\"100\",\"initThreadNumber\":\"20\",\"maxThreadNumber\":\"20\",\"runExpress\":\"0/4 * * * * ?\",\"retryExpress\":\"0/4 * * * * ?\"}', '0,4,checkflop,0;0,9,nextGame,0;0,10030,__end,0;0,11,nextGame,0;', '0,0,nextGame,0;', '0,default,checkflop,0;', 'immediately', '8', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('coojisu_playing', '__end', 'gameover', '', '0,0,__end,0;', '0,0,__end,0;', '0,0,__end,0;', 'immediately', '3', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('coojisu_playing', 'nextGame', 'nextGame', '{\"name\":\"checkPlaying\",\"category\":\"1\",\"url\":\"http://172.18.10.74:9003/game\",\"restMethod\":\"autoNextGame\",\"queneSize\":\"1000\",\"keepAliveTime\":\"100\",\"initThreadNumber\":\"20\",\"maxThreadNumber\":\"20\",\"runExpress\":\"0/16 * * * * ?\",\"retryExpress\":\"0/16 * * * * ?\"}', '0,0,sharing,0;0,10004,sharing,0;0,10002,sharing,0;0,11,sharing,0;', '0,0,sharing,0;', '0,default,nextGame,0;', 'immediately', '3', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('coojisu_playing', 'sharing', 'sharing', '{\"name\":\"checkPlaying\",\"category\":\"1\",\"url\":\"http://172.18.10.74:9003/bonusSharing\",\"restMethod\":\"settledGame\",\"queneSize\":\"1000\",\"keepAliveTime\":\"100\",\"initThreadNumber\":\"20\",\"maxThreadNumber\":\"20\",\"runExpress\":\"0/16 * * * * ?\",\"retryExpress\":\"0/16 * * * * ?\"}', '0,0,sharing,0;', '0,0,gameReshow,0;', '0,default,sharing,0;', 'immediately', '3', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('login', '__start', 'login_start', '{\"name\":\"category_modifyUser_start\",\"category\":\"1\",\"url\":\"http://172.18.5.110:9003/userInfo\",\"restMethod\":\"recharge\",\"runExpress\":\"0/3 * * * * ?\",\"retryExpress\":\"0/10 * * * * ?\",\"maxThreadNumber\":\"15\",\"initThreadNumber\":\"1\",\"keepAliveTime\":\"100\",\"queneSize\":\"20\"}', '0,-1,__start,0;', '0,0,__end,0;', '0,0,__start,0;', 'immediately', 'test', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('login', '__end', 'login_end', '', '0,0,__end,0;', '0,0,__end,0;', '0,0,__end,0;', 'immediately', 'test', '0');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('orderCreateClub', '__start', 'create_club_apply', '{\"name\":\"pushMsgToReviewer\",\"category\":\"1\",\"url\":\"http://172.18.10.73:9004/club/review\",\"restMethod\":\"pushMsgToReviewer\",\"runExpress\":\"0/3 * * * * ?\",\"retryExpress\":\"0/10 * * * * ?\",\"maxThreadNumber\":\"15\",\"initThreadNumber\":\"1\",\"keepAliveTime\":\"100\",\"queneSize\":\"20\"}', '2,-1,1001,__start,0;', '0,0,__review,0;', '0,0,__start,0;', 'immediately', 'test', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('orderCreateClub', '__review', 'create_club_review', NULL, '2,-1,1002,__review,0;', '0,500,__agree,0;0,501,__reject,0;', '0,0,__review,0;', 'unimmediately', 'test', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('orderCreateClub', '__agree', 'create_club_agree', '{\"name\":\"reviewAgree\",\"category\":\"1\",\"url\":\"http://172.18.10.73:9004/club/review\",\"restMethod\":\"reviewAgree\",\"runExpress\":\"0/3 * * * * ?\",\"retryExpress\":\"0/10 * * * * ?\",\"maxThreadNumber\":\"15\",\"initThreadNumber\":\"1\",\"keepAliveTime\":\"100\",\"queneSize\":\"20\"}', '2,-1,1003,__agree,0;', '0,0,__pushResult,0;', '0,0,__agree,0;', 'immediately', 'test', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('orderCreateClub', '__reject', 'create_club_reject', '{\"name\":\"reviewReject\",\"category\":\"1\",\"url\":\"http://172.18.10.73:9004/club/review\",\"restMethod\":\"reviewReject\",\"runExpress\":\"0/3 * * * * ?\",\"retryExpress\":\"0/10 * * * * ?\",\"maxThreadNumber\":\"15\",\"initThreadNumber\":\"1\",\"keepAliveTime\":\"100\",\"queneSize\":\"20\"}', '2,-1,1004,__reject,0;', '0,0,__pushResult,0;', '0,0,__reject,0;', 'immediately', 'test', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('orderCreateClub', '__end', 'create_club_end', NULL, '0,0,__end,0;', '0,0,__end,0;', '0,0,__end,0;', 'immediately', 'test', '0');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('orderCreateClub', '__pushResult', 'push_result', '{\"name\":\"push_result\",\"category\":\"1\",\"url\":\"http://172.18.10.73:9004/club/review\",\"restMethod\":\"pushResultToClient\",\"runExpress\":\"0/3 * * * * ?\",\"retryExpress\":\"0/3 * * * * ?\",\"maxThreadNumber\":\"15\",\"initThreadNumber\":\"1\",\"keepAliveTime\":\"100\",\"queneSize\":\"20\"}', '2,-1,1001,__pushResult,0;', '0,0,__end,0;', '0,0,__pushResult,0;', 'immediately', 'test', '0');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('orderCreateRoom', '__start', 'create_room_apply', '{\"name\":\"pushMsgToReviewer\",\"category\":\"1\",\"url\":\"http://172.18.10.73:9003/room/review\",\"restMethod\":\"pushMsgToReviewer\",\"runExpress\":\"0/1 * * * * ?\",\"retryExpress\":\"0/1 * * * * ?\",\"maxThreadNumber\":\"15\",\"initThreadNumber\":\"1\",\"keepAliveTime\":\"100\",\"queneSize\":\"20\"}', '2,-1,1001,__start,0;', '0,0,__review,0;', '0,0,__start,0;', 'immediately', 'test', '0');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('orderCreateRoom', '__reject', 'create_room_reject', '{\"name\":\"reviewReject\",\"category\":\"1\",\"url\":\"http://172.18.10.73:9003/room/review\",\"restMethod\":\"reviewReject\",\"runExpress\":\"0/3 * * * * ?\",\"retryExpress\":\"0/10 * * * * ?\",\"maxThreadNumber\":\"15\",\"initThreadNumber\":\"1\",\"keepAliveTime\":\"100\",\"queneSize\":\"20\"}', '2,-1,1004,__reject,0;', '0,0,__pushResult,0;', '0,0,__reject,0;', 'immediately', 'test', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('orderCreateRoom', '__agree', 'create_room_agree', '{\"name\":\"reviewAgree\",\"category\":\"1\",\"url\":\"http://172.18.10.73:9003/room/review\",\"restMethod\":\"reviewAgree\",\"runExpress\":\"0/3 * * * * ?\",\"retryExpress\":\"0/10 * * * * ?\",\"maxThreadNumber\":\"15\",\"initThreadNumber\":\"1\",\"keepAliveTime\":\"100\",\"queneSize\":\"20\"}', '2,-1,1003,__agree,0;', '0,0,__pushResult,0;', '0,0,__agree,0;', 'immediately', 'test', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('orderCreateRoom', '__review', 'create_room_review', '', '2,-1,1002,__review,0;', '0,500,__agree,0;0,501,__reject,0;0,502,__suspend,0;', '0,0,__review,0;', 'unimmediately', 'test', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('orderCreateRoom', '__end', 'create_room_end', '', '0,0,__end,0;', '0,0,__end,0;', '0,0,__end,0;', 'immediately', 'test', '0');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('orderCreateRoom', '__pushResult', 'push_result', '{\"name\":\"push_result\",\"category\":\"1\",\"url\":\"http://172.18.10.73:9003/room/review\",\"restMethod\":\"pushResultToClient\",\"runExpress\":\"0/3 * * * * ?\",\"retryExpress\":\"0/3 * * * * ?\",\"maxThreadNumber\":\"15\",\"initThreadNumber\":\"1\",\"keepAliveTime\":\"100\",\"queneSize\":\"20\"}', '2,-1,1001,__pushResult,0;', '0,0,__end,0;', '0,0,__pushResult,0;', 'immediately', 'test', '0');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('recharge_userDiamondAcc', '__start', 'recharge_userDiamondAcc', '{\"name\":\"jumpToNext\",\"category\":\"1\",\"url\":\"http://172.18.5.110:9003/account/autoTask\",\"restMethod\":\"checkTransferBalanceSysToUnion\",\"runExpress\":\"0/3 * * * * ?\",\"retryExpress\":\"0/10 * * * * ?\",\"maxThreadNumber\":\"15\",\"initThreadNumber\":\"1\",\"keepAliveTime\":\"100\",\"queneSize\":\"20\"}', '0,-1,__start,0;', '0,0,__end,0;', '0,default,__start,0;', 'immediately', 'test', '3');
INSERT INTO `user_dbcloud`.`order_flow_stepdef`(`catetory`, `step_id`, `step_name`, `task_in`, `task_out_error`, `task_out_succ`, `task_out_default`, `run_type`, `run_info`, `retry_times`) VALUES ('recharge_userDiamondAcc', '__end', 'recharge_userDiamondAcc', NULL, '0,0,__end,0;', '0,0,__end,0;', '0,default,__end,0;', 'immediately', 'test', '3');
