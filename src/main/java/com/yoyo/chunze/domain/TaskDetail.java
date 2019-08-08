package com.yoyo.chunze.domain;

import java.util.Date;

import com.yoyo.chunze.utils.BaseDomain;
/**
 * 每一周形成一个初始的周任务汇总(maintask)，时间为一周的开始时间，
 * 每一个具体的任务形成taskDetail
 * @author helmsli
 *
 */
public class TaskDetail extends MainTask {
	
	//使用系统时间
	private long subTaskId;
	private String evaluationId;
	private String content;
	private Date startTime;
	private int parentLevel;//父母表现评级
	private String parentRemark;//父母表现备注
	private int childLevel;
	private String childRemark;
	private int taskState;
	private int taskStatus;
	private int completeProgress;
	
	
	public long getSubTaskId() {
		return subTaskId;
	}
	public void setSubTaskId(long subTaskId) {
		this.subTaskId = subTaskId;
	}
	public String getEvaluationId() {
		return evaluationId;
	}
	public void setEvaluationId(String evaluationId) {
		this.evaluationId = evaluationId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public int getParentLevel() {
		return parentLevel;
	}
	public void setParentLevel(int parentLevel) {
		this.parentLevel = parentLevel;
	}
	public String getParentRemark() {
		return parentRemark;
	}
	public void setParentRemark(String parentRemark) {
		this.parentRemark = parentRemark;
	}
	public int getChildLevel() {
		return childLevel;
	}
	public void setChildLevel(int childLevel) {
		this.childLevel = childLevel;
	}
	public String getChildRemark() {
		return childRemark;
	}
	public void setChildRemark(String childRemark) {
		this.childRemark = childRemark;
	}
	public int getTaskState() {
		return taskState;
	}
	public void setTaskState(int taskState) {
		this.taskState = taskState;
	}
	public int getTaskStatus() {
		return taskStatus;
	}
	public void setTaskStatus(int taskStatus) {
		this.taskStatus = taskStatus;
	}
	public int getCompleteProgress() {
		return completeProgress;
	}
	public void setCompleteProgress(int completeProgress) {
		this.completeProgress = completeProgress;
	}
	
	
	
}
