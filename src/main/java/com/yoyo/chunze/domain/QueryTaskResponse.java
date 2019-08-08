package com.yoyo.chunze.domain;

import java.util.List;

import com.yoyo.chunze.utils.BaseDomain;

public class QueryTaskResponse extends BaseDomain{
	private List<TaskDetail> taskDetailList;

	public List<TaskDetail> getTaskDetailList() {
		return taskDetailList;
	}

	public void setTaskDetailList(List<TaskDetail> taskDetailList) {
		this.taskDetailList = taskDetailList;
	}
	
}
