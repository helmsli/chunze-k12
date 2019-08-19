package com.yoyo.chunze.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


import com.xinwei.nnl.common.domain.ProcessResult;
import com.yoyo.chunze.domain.ConfigTaskRequest;
import com.yoyo.chunze.domain.ConfigureTaskDetail;
import com.yoyo.chunze.domain.QueryTaskRequest;
import com.yoyo.chunze.service.BabyTaskService;
import com.yoyo.chunze.utils.ControllerUtils;

@RestController
@RequestMapping("/studyPlan")
public class StudyPlanController {
	
	private final Logger logger = LoggerFactory.getLogger(getClass());

	
	@Autowired
	private BabyTaskService babyTaskService;
	
	@PostMapping(value = "/configStudyPlan")
	public  ProcessResult configStudyPlan(@RequestBody ConfigTaskRequest configTaskRequest) {
		
		try {
			return babyTaskService.configureMainTask(configTaskRequest);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			logger.error("", e);
			return ControllerUtils.getFromResponse(e, -1, null);
		}
		
	}

	@PostMapping(value = "/queryPlanDetail")
	public  ProcessResult queryPlanDetail(@RequestBody QueryTaskRequest queryTaskRequest) {
		
		try {
			return babyTaskService.queryBabyTask(queryTaskRequest);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			logger.error("", e);
			return ControllerUtils.getFromResponse(e, -1, null);
		}		
	}
	
	@PostMapping(value = "/configPlanDetail")
	public  ProcessResult configPlanDetail(@RequestBody ConfigureTaskDetail configureTaskDetail) {
		
		try {
			return babyTaskService.configureBabyTask(configureTaskDetail);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			logger.error("", e);
			return ControllerUtils.getFromResponse(e, -1, null);
		}
		
	}
}
