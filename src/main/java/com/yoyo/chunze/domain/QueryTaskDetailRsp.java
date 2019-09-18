package com.yoyo.chunze.domain;

import java.util.ArrayList;
import java.util.List;

import com.yoyo.chunze.utils.BaseDomain;

public class QueryTaskDetailRsp extends BaseDomain {
	private List<TaskDetail> taskDetailList=new ArrayList();
	private List<TaskTotal> total=new ArrayList();
	public List<TaskDetail> getTaskDetailList() {
		return taskDetailList;
	}
	public void setTaskDetailList(List<TaskDetail> taskDetailList) {
		this.taskDetailList = taskDetailList;
	}
	public List<TaskTotal> getTotal() {
		return total;
	}
	public void setTotal(List<TaskTotal> total) {
		this.total = total;
	}
	
}
