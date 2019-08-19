package com.yoyo.chunze.domain;

import com.yoyo.chunze.utils.BaseDomain;

public class ConfigureTaskDetail extends BaseDomain {
	private String userId;
	private String babyId;
	private TaskDetail taskDetail;
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
	public TaskDetail getTaskDetail() {
		return taskDetail;
	}
	public void setTaskDetail(TaskDetail taskDetail) {
		this.taskDetail = taskDetail;
	}
	
}
