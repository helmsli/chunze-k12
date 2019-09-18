package com.yoyo.chunze.domain;

import com.yoyo.chunze.utils.BaseDomain;

public class TaskTotal extends BaseDomain {
	private int taskType=0;
	private int subTotal=0;
	private int completeProgress=0;
	public int getTaskType() {
		return taskType;
	}
	public void setTaskType(int taskType) {
		this.taskType = taskType;
	}
	public int getSubTotal() {
		return subTotal;
	}
	public synchronized void increaseSubTotal() {
		 subTotal++;
	}
	public void setSubTotal(int subTotal) {
		this.subTotal = subTotal;
	}
	public int getCompleteProgress() {
		return completeProgress;
	}
	public void setCompleteProgress(int completeProgress) {
		this.completeProgress = completeProgress;
	}
	public synchronized void addCompleteProgress(int completeProgress) {
		this.completeProgress += completeProgress;
	}
	
}
