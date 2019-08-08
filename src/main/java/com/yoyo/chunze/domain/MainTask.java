package com.yoyo.chunze.domain;

import java.util.Date;
import java.util.List;

import com.yoyo.chunze.utils.BaseDomain;

/**
 * 宝贝任务
 * @author helmsli
 *
 */
public class MainTask extends BaseDomain{
	private String userId;
	private String babyId;
	//使用訂單ID，從訂單系統申請
	private long taskId;
	private int taskType;
	private String taskTitle;
	private int courseType;
	private int periodType;
	private List<String> period;
	private boolean isValid;//生否生效
	private String content;
	private boolean isComplete;
	private String description;
	private int completeProgress;
	private Date startTime;
	public long getTaskId() {
		return taskId;
	}
	public void setTaskId(long taskId) {
		this.taskId = taskId;
	}
	public int getTaskType() {
		return taskType;
	}
	public void setTaskType(int taskType) {
		this.taskType = taskType;
	}
	public String getTaskTitle() {
		return taskTitle;
	}
	public void setTaskTitle(String taskTitle) {
		this.taskTitle = taskTitle;
	}
	public int getCourseType() {
		return courseType;
	}
	public void setCourseType(int courseType) {
		this.courseType = courseType;
	}
	public int getPeriodType() {
		return periodType;
	}
	public void setPeriodType(int periodType) {
		this.periodType = periodType;
	}
	public List<String> getPeriod() {
		return period;
	}
	public void setPeriod(List<String> period) {
		this.period = period;
	}
	public boolean isValid() {
		return isValid;
	}
	public void setValid(boolean isValid) {
		this.isValid = isValid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public boolean isComplete() {
		return isComplete;
	}
	public void setComplete(boolean isComplete) {
		this.isComplete = isComplete;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getCompleteProgress() {
		return completeProgress;
	}
	public void setCompleteProgress(int completeProgress) {
		this.completeProgress = completeProgress;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getBabyId() {
		return babyId;
	}
	public void setBabyId(String babyId) {
		this.babyId = babyId;
	}
	
}
