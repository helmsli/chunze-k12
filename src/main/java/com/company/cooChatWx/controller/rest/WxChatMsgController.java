package com.company.cooChatWx.controller.rest;

import java.security.PrivateKey;
import java.security.PublicKey;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.company.cooChatWx.domain.ChatMsg;
import com.company.cooChatWx.domain.WxMessage;
import com.company.cooChatWx.message.service.WxMessageService;
import com.xinwei.nnl.common.domain.JsonRequest;
import com.xinwei.nnl.common.domain.ProcessResult;
import com.yoyo.chunze.security.utils.RSAUtils;
import com.yoyo.chunze.security.utils.SecurityKeyServiceImpl;
import com.yoyo.chunze.utils.ControllerUtils;

@RestController
@RequestMapping("/message")
public class WxChatMsgController {
	@Autowired
	protected WxMessageService wxMessageService;
	/**
	 * String allClientPassword = RSAUtils.decrypt(clientPassword, privateKey);
	 * @param wxMessage
	 * @return
	 */
	@PostMapping(value = "/receiveMsg")
	public  ProcessResult receiveMsg(@RequestBody ChatMsg chatMsg) {
		
		try {
			return wxMessageService.processReceiveMsg(chatMsg);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ControllerUtils.getFromResponse(e, -1, null);
		}
		
	}
	
}
