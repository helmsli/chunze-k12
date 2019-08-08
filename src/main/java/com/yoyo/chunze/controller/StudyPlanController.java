package com.yoyo.chunze.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.company.cooChatWx.domain.ChatMsg;
import com.xinwei.nnl.common.domain.ProcessResult;
import com.yoyo.chunze.domain.ConfigTaskRequest;
import com.yoyo.chunze.utils.ControllerUtils;

@RestController
@RequestMapping("/studyPlan")
public class StudyPlanController {
	@PostMapping(value = "/configStudyPlan")
	public  ProcessResult configStudyPlan(@RequestBody ConfigTaskRequest configTaskRequest) {
		
		try {
			return null;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ControllerUtils.getFromResponse(e, -1, null);
		}
		
	}

}
