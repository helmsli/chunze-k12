package com.yoyo.chunze.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.xinwei.nnl.common.domain.ProcessResult;
import com.xinwei.nnl.common.util.JsonUtil;
import com.xinwei.userOrder.domain.QueryUserOrderRequest;
import com.xinwei.userOrder.domain.UserOrder;
import com.yoyo.chunze.domain.ConfigTaskRequest;
import com.yoyo.chunze.domain.MainTask;
import com.yoyo.chunze.domain.PeriodTypeEnum;
import com.yoyo.chunze.domain.QueryTaskRequest;
import com.yoyo.chunze.domain.QueryTaskResponse;
import com.yoyo.chunze.domain.TaskDetail;
import com.yoyo.chunze.domain.TaskStateEnum;
import com.yoyo.chunze.domain.WeekTaskDetail;
import com.yoyo.chunze.orderService.OrderClientService;
import com.yoyo.chunze.orderService.UserOrderQueryResult;
import com.yoyo.chunze.security.utils.DateWeekUtils;
import com.yoyo.chunze.utils.ControllerUtils;

public class BabyTaskService {
	private final Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private OrderClientService orderClientService;

	private static final String category_baby_taskMain = "babyTask";

	private static final String category_baby_taskRunning = "babyTRunning";

	protected String getMainTaskOrderId(String babyId, int courseType, int taskType) {
		return "#b" + babyId + "#c" + courseType + "#t" + String.valueOf(taskType) + "#";
	}

	protected String getTaskRunningOrderId() {
		return "";
	}

	public ProcessResult configureTask(ConfigTaskRequest configTaskRequest) {
		for (MainTask mainTask : configTaskRequest.getTaskList()) {

			UserOrder userOrder = new UserOrder();
			userOrder.setCategory(category_baby_taskMain);
			userOrder.setConstCreateTime();
			userOrder.setUserId(configTaskRequest.getUserId());
			userOrder.setOrderId(getMainTaskOrderId(configTaskRequest.getBabyId(), mainTask.getCourseType(),
					mainTask.getTaskType()));

			userOrder.setStatus(TaskStateEnum.Running.ordinal());
			if (mainTask.isValid()) {
				userOrder.setStatus(TaskStateEnum.NoValid.ordinal());
			}
			mainTask.setUserId(configTaskRequest.getUserId());
			mainTask.setBabyId(configTaskRequest.getBabyId());
			userOrder.setOrderData(JsonUtil.toJson(mainTask));
			ProcessResult ret = this.orderClientService.saveUserOrder(null, userOrder);
			if (ret.getRetCode() != 0) {
				return ret;
			}
		}
		return ControllerUtils.getSuccessResponse(null);
	}

	public ProcessResult queryBabyTask(QueryTaskRequest queryTaskRequest) {

		// 如果是周任務
		Date firstWeekDate = DateWeekUtils.getWeekStartTime();
		QueryUserOrderRequest queryUserOrderRequest = new QueryUserOrderRequest();
		queryUserOrderRequest.setStartCreateTime(firstWeekDate);
		queryUserOrderRequest.setEndCreateTime(firstWeekDate);
		queryUserOrderRequest.setCategory(category_baby_taskRunning);
		// 0 查詢所有
		queryUserOrderRequest.setStatus(queryTaskRequest.getTaskState());
		queryUserOrderRequest.setUserId(queryTaskRequest.getUserId());
		queryUserOrderRequest.setPageNum(0);
		queryUserOrderRequest.setPageSize(10000);
		ProcessResult ret = orderClientService.queryUserOrderByPage(null, queryUserOrderRequest);
		if (ret.getRetCode() != 0) {
			return ret;
		}
		List<TaskDetail> newlist = new ArrayList<>();
		String jsonStr = JsonUtil.toJson(ret.getResponseInfo());
		UserOrderQueryResult userOrderPageInfo = JsonUtil.fromJson(jsonStr, UserOrderQueryResult.class);
		if (!userOrderPageInfo.getList().isEmpty()) {
			List<UserOrder> list = userOrderPageInfo.getList();
			for (UserOrder userOrder : list) {
				//
				if (userOrder.getOrderDataType()
						.compareToIgnoreCase(String.valueOf(PeriodTypeEnum.Week.ordinal())) == 0) {
					WeekTaskDetail weekTaskDetail = JsonUtil.fromJson(userOrder.getOrderData(), WeekTaskDetail.class);
					newlist.add(weekTaskDetail);
				}
			}
		}
		QueryTaskResponse queryTaskResponse = new QueryTaskResponse();
		queryTaskResponse.setTaskDetailList(newlist);
		ret = ControllerUtils.getSuccessResponse(null);
		ret.setResponseInfo(queryTaskResponse);
		return ret;
	}
}
