package com.yoyo.chunze.domain;

import java.util.ArrayList;
import java.util.List;

import com.yoyo.chunze.utils.BaseDomain;

public class ConfigTaskRequest extends BaseDomain {
	private String userId;
	private String babyId;
	private int courseType;
	private List<MainTask> taskList = new ArrayList<>();
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
	public List<MainTask> getTaskList() {
		return taskList;
	}
	public void setTaskList(List<MainTask> taskList) {
		this.taskList = taskList;
	}
	public int getCourseType() {
		return courseType;
	}
	public void setCourseType(int courseType) {
		this.courseType = courseType;
	}
	
}
