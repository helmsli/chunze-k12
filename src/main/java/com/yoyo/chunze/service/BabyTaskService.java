package com.yoyo.chunze.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xinwei.nnl.common.domain.ProcessResult;
import com.xinwei.nnl.common.util.JsonUtil;
import com.xinwei.userOrder.domain.QueryUserOrderRequest;
import com.xinwei.userOrder.domain.UserOrder;
import com.yoyo.chunze.domain.ConfigTaskRequest;
import com.yoyo.chunze.domain.ConfigureTaskDetail;
import com.yoyo.chunze.domain.CourseTypeEnum;
import com.yoyo.chunze.domain.MainTask;
import com.yoyo.chunze.domain.PeriodTypeEnum;
import com.yoyo.chunze.domain.QueryTaskDetailRsp;
import com.yoyo.chunze.domain.QueryTaskRequest;
import com.yoyo.chunze.domain.QueryTaskResponse;
import com.yoyo.chunze.domain.TaskDetail;
import com.yoyo.chunze.domain.TaskStateEnum;
import com.yoyo.chunze.domain.TaskTotal;
import com.yoyo.chunze.domain.TaskTypeEnum;
import com.yoyo.chunze.domain.WeekTaskDetail;
import com.yoyo.chunze.orderService.OrderClientService;
import com.yoyo.chunze.orderService.UserOrderQueryResult;
import com.yoyo.chunze.security.utils.DateWeekUtils;
import com.yoyo.chunze.utils.ControllerUtils;
@Service("babyTaskService")
public class BabyTaskService {
	private final Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private OrderClientService orderClientService;

	private static final String category_baby_taskMain = "babyMainTask";

	private static final String category_baby_taskRunning = "babyTRunning";

	
	
	protected String getMainTaskOrderId(String babyId, int courseType, int taskType) {
		return "#b" + babyId + "#c" + courseType + "#t" + String.valueOf(taskType) + "#";
	}

	protected String getTaskDetailOrderId(String taskId,long subTaskId) {
		return "#d" + String.valueOf(taskId) + "#" + String.valueOf(subTaskId)+"#";
	}
	
	protected String getTaskRunningOrderId() {
		return "";
	}

	/**
	 * 配置用户任务
	 * @param configTaskRequest
	 * @return
	 */
	public ProcessResult configureMainTask(ConfigTaskRequest configTaskRequest) {
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
			//构造taskId
			String taskId = this.orderClientService.getOrderId(category_baby_taskMain, configTaskRequest.getUserId());
			if(StringUtils.isEmpty(taskId))
			{
				logger.error("configureMainTask get taskId,error");
				return ControllerUtils.getErrorResponse(-1, "get taskId error");
				
			}
			mainTask.setTaskId(Long.parseLong(taskId));
			userOrder.setOrderData(JsonUtil.toJson(mainTask));
			ProcessResult ret = this.orderClientService.saveUserOrder(null, userOrder);
			if (ret.getRetCode() != 0) {
				return ret;
			}
		}
		return ControllerUtils.getSuccessResponse(null);
	}
	
	/**
	 * 查询任务接口请求
	 * @param queryTaskRequest
	 * @return
	 */
	public ProcessResult queryMainTask(QueryTaskRequest queryTaskRequest) {
		// 如果是周任務
		UserOrder userOrderTemp = new UserOrder();
		QueryUserOrderRequest queryUserOrderRequest = new QueryUserOrderRequest();
		queryUserOrderRequest.setStartCreateTime(userOrderTemp.getConstCreateDate());
		queryUserOrderRequest.setEndCreateTime(userOrderTemp.getConstCreateDate());
		queryUserOrderRequest.setCategory(category_baby_taskMain);
		// 0 查詢所有
		queryUserOrderRequest.setStatus(TaskStateEnum.Null0.ordinal());
		queryUserOrderRequest.setUserId(queryTaskRequest.getUserId());
		queryUserOrderRequest.setPageNum(0);
		queryUserOrderRequest.setPageSize(10000);
		ProcessResult ret = orderClientService.queryUserOrderByPage(null, queryUserOrderRequest);
		if (ret.getRetCode() != 0) {
			return ret;
		}
		List<MainTask> newlist = new ArrayList<>();
		String jsonStr = JsonUtil.toJson(ret.getResponseInfo());
		UserOrderQueryResult userOrderPageInfo = JsonUtil.fromJson(jsonStr, UserOrderQueryResult.class);
		if (!userOrderPageInfo.getList().isEmpty()) {
			List<UserOrder> list = userOrderPageInfo.getList();
			for (UserOrder userOrder : list) {
				//
				newlist.add(JsonUtil.fromJson(userOrder.getOrderData(), MainTask.class));
			}
		}
		
		ret = ControllerUtils.getSuccessResponse(null);
		ret.setResponseInfo(newlist);
		return ret;
		
	
	}
	
	/**
	 * 将任务列表转化为任务明细列表
	 * @param mainTaskList
	 * @return
	 */
	protected List<TaskDetail> getTaskDetailFromMainTask(List<MainTask> mainTaskList)
	{
		List<TaskDetail> taskDetailList = new ArrayList<>();
		logger.error(JsonUtil.toJson(mainTaskList));
		for(MainTask mainTask:mainTaskList)
		{
			logger.error(mainTask.toString());
			taskDetailList.addAll(TaskUtils.getTaskDetail(mainTask));
		}
		return taskDetailList;
	}
	
	public ProcessResult queryBabyTask(QueryTaskRequest queryTaskRequest) {
	  	ProcessResult ret  = this.queryBabyTaskList(queryTaskRequest);
	  	if(ret.getRetCode()!=0)
	  	{
	  		return ret;
	  	}
	  	QueryTaskDetailRsp taskDetailRsp = new QueryTaskDetailRsp();
	  	taskDetailRsp.setTaskDetailList((List<TaskDetail>)ret.getResponseInfo());
	  	ret.setResponseInfo(taskDetailRsp);
	  	Map<Integer,TaskTotal> maps = new HashMap<Integer,TaskTotal>();
	  	for(TaskDetail taskDetail :taskDetailRsp.getTaskDetailList())
	  	{
	  		TaskTotal taskTotal = null;
	  		Integer iType = new Integer(taskDetail.getTaskType());
	  		if(maps.containsKey(iType))
	  		{
	  			taskTotal = maps.get(iType);
	  		}
	  		else
	  		{
	  			taskTotal = new TaskTotal();
	  			maps.put(iType, taskTotal);
	  			taskTotal.setTaskType(taskDetail.getTaskType());
	  			taskDetailRsp.getTotal().add(taskTotal);
	  		}
	  		taskTotal.increaseSubTotal();
	  		taskTotal.addCompleteProgress(taskDetail.getCompleteProgress());
	  		
	  	}
	  	return ret;
	}
	/**
	 * 查询孩子已经配置的任务
	 * @param queryTaskRequest
	 * @return List
	 */
	public ProcessResult queryBabyTaskList(QueryTaskRequest queryTaskRequest) {
		ProcessResult ret = this.queryBabyRunningTask(queryTaskRequest);
		if(ret.getRetCode()!=0)
		{
			return ret;
		}
		logger.debug(ret.toString());
		QueryTaskResponse queryTaskResponse = (QueryTaskResponse)ret.getResponseInfo();
		
		List<TaskDetail> newlist = queryTaskResponse.getTaskDetailList();
		if(newlist.size()>0)
		{
			return ret;
		}
		ret = this.queryMainTask(queryTaskRequest);
		if(ret.getRetCode()==0)
		{
			List<MainTask> mainTaskList= null;
			List<TaskDetail> retTaskDetailList=new ArrayList<>();
			
			if(ret.getResponseInfo()!=null)
			{
				mainTaskList = (List<MainTask>)ret.getResponseInfo();
			}
			//构造默认的对象
			if(mainTaskList==null||mainTaskList.size()==0)
			{
				mainTaskList = createDefaultMainTask();
			}
			List<TaskDetail> taskDetailList = this.getTaskDetailFromMainTask(mainTaskList);
			for(TaskDetail taskDetail:taskDetailList)
			{
				if(queryTaskRequest.getCourseType()!=CourseTypeEnum.Null.ordinal())
				{
					if(taskDetail.getCourseType()!=queryTaskRequest.getCourseType())
					{
						continue;
					}
				}
				//按照任务类型过滤
				if(queryTaskRequest.getTaskType()!=TaskTypeEnum.Null.ordinal())
				{
					if(taskDetail.getTaskType()!=queryTaskRequest.getTaskType())
					{
						continue;
					}
				}
				retTaskDetailList.add(taskDetail);
			}
			ret.setResponseInfo(retTaskDetailList);
		}
		return ret;
	}
	
	public ProcessResult configureBabyTask(ConfigureTaskDetail configureTaskDetail) {
	    UserOrder userOrder = new UserOrder();
	    userOrder.setCategory(category_baby_taskRunning);
	    userOrder.setCreateTime(configureTaskDetail.getTaskDetail().getStartTime());
	    userOrder.setUserId(configureTaskDetail.getUserId());
	    userOrder.setStatus(TaskStateEnum.Running.ordinal());
	    userOrder.setOrderData(JsonUtil.toJson(configureTaskDetail.getTaskDetail()));
	    return this.orderClientService.saveUserOrder(null, userOrder);
	}
	/**
	 * 查询用户正在执行的任务
	 * @param queryTaskRequest
	 * @return
	 */
	protected ProcessResult queryBabyRunningTask(QueryTaskRequest queryTaskRequest) {

		// 如果是周任務
		Date firstWeekDate = DateWeekUtils.getWeekStartTime();
		Date endWeekDate = DateWeekUtils.getWeekEndTime();
		
		QueryUserOrderRequest queryUserOrderRequest = new QueryUserOrderRequest();
		queryUserOrderRequest.setStartCreateTime(firstWeekDate);
		queryUserOrderRequest.setEndCreateTime(endWeekDate);
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
					//按照课程过滤
					if(queryTaskRequest.getCourseType()!=CourseTypeEnum.Null.ordinal())
					{
						if(weekTaskDetail.getCourseType()!=queryTaskRequest.getCourseType())
						{
							continue;
						}
					}
					//按照任务类型过滤
					if(queryTaskRequest.getTaskType()!=TaskTypeEnum.Null.ordinal())
					{
						if(weekTaskDetail.getTaskType()!=queryTaskRequest.getTaskType())
						{
							continue;
						}
					}
					
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
	/**
	 * 创建默认的任务列表
	 * @return
	 */
	protected List<MainTask> createDefaultMainTask()
	{
		List<MainTask> list= new ArrayList<>();
		MainTask mainTask= new MainTask();
		mainTask.setValid(false);
		mainTask.addOnePeriod("1");
		mainTask.setCourseType(CourseTypeEnum.Mathematics.ordinal());
		mainTask.setPeriodType(PeriodTypeEnum.Week.ordinal());
		mainTask.setTaskType(TaskTypeEnum.ClassRoomContent.ordinal());
		mainTask.addOnePeriod("1");
		list.add(mainTask);
		mainTask= new MainTask();
		mainTask.setValid(false);
		mainTask.setCourseType(CourseTypeEnum.Mathematics.ordinal());
		mainTask.setPeriodType(PeriodTypeEnum.Week.ordinal());
		mainTask.setTaskType(TaskTypeEnum.OralArithmetic.ordinal());
		mainTask.addOnePeriod("1");
		list.add(mainTask);
		mainTask= new MainTask();
		mainTask.addOnePeriod("1");
		mainTask.setValid(false);
		mainTask.setCourseType(CourseTypeEnum.Mathematics.ordinal());
		mainTask.setPeriodType(PeriodTypeEnum.Week.ordinal());
		mainTask.setTaskType(TaskTypeEnum.PracticeInClass.ordinal());
		list.add(mainTask);
		
		return list;
	}
}
