package com.yoyo.chunze.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.BeanUtils;

import com.yoyo.chunze.domain.MainTask;
import com.yoyo.chunze.domain.PeriodTypeEnum;
import com.yoyo.chunze.domain.TaskDetail;
import com.yoyo.chunze.domain.TaskStateEnum;
import com.yoyo.chunze.security.utils.DateWeekUtils;

public class TaskUtils {
	static SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault());

	public static List<TaskDetail> getTaskDetail(MainTask mainTask) {
		List<TaskDetail> taskDetailList = new ArrayList<TaskDetail>();
		Calendar now = Calendar.getInstance();
		//返回一周的時間
		
			for (String period : mainTask.getPeriod()) {

				TaskDetail taskDetail = new TaskDetail();
				BeanUtils.copyProperties(mainTask, taskDetail);
				long subTaskId = getSubTaskId(mainTask.getPeriodType(), mainTask.getTaskType(), period);
				if (subTaskId == 0) {
					return null;
				}
				taskDetail.setSubTaskId(subTaskId);
				taskDetail.setEvaluationId("");
				if (!mainTask.isValid()) {
					taskDetail.setTaskState(TaskStateEnum.NoValid.ordinal());
				} else {
					taskDetail.setTaskState(TaskStateEnum.Running.ordinal());
				}
				try {
					taskDetail.setStartTime(DateWeekUtils.getWeekTime(now.getTime(), period));
					taskDetail.setWeeksAmount(DateWeekUtils.getWeekAmount());
					taskDetail.setWeekBeginTime(DateWeekUtils.getWeekStartTime());
					taskDetail.setWeekEndTime(DateWeekUtils.getWeekEndTime());
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					continue;
				}
				taskDetailList.add(taskDetail);

			}
		
		return taskDetailList;
	}

	/**
	 * subid
	 * 
	 * @param periodType
	 * @param taskType
	 * @param period
	 * @return
	 */
	public static long getSubTaskId(int periodType, int taskType, String period) {
		Date now = Calendar.getInstance().getTime();
		if (periodType == PeriodTypeEnum.Week.ordinal()) {
			try {
				Date date = DateWeekUtils.getWeekTime(now, period);
				String dates = simpleDateFormat.format(date);
				long taskId = taskType % 100 + Long.parseLong(dates) * 100;
				return taskId;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return 0;
			}
		}
		return 0;
	}
}
