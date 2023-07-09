package com.java501.S20230401.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.thymeleaf.context.Context;
import org.thymeleaf.spring5.SpringTemplateEngine;

import com.java501.S20230401.util.EmailMessage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class EmailService {
	private final JavaMailSender mailSender;
	private final SpringTemplateEngine templateEngine;
	private final MemberService memberService;
	private final AuthenticationsService as;
	
	public String sendMail(EmailMessage msg, String type, String baseUrl) {
		String authNum;
		while (as.getAuthentication(authNum = createCode()) != null);
		MimeMessage mimeMessage = mailSender.createMimeMessage();
		
		//if (type.equals("password")) memberService.setTempPassword(~~~~~~);
		
		try {
			MimeMessageHelper mmh = new MimeMessageHelper(mimeMessage, false, "UTF-8");
			mmh.setTo(msg.getTo());
			mmh.setSubject(msg.getSubject());
			mmh.setText(setContext(authNum, type, baseUrl), true);
			mailSender.send(mimeMessage);
			log.info("Successfully sended message");
			return authNum;
		} catch(MessagingException e) {
			log.info("Fail sending message: " + e.getMessage());
		}
		return null;
	}
	
	public String createCode() {
		Random rand = new Random();
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < 50; i++) {
			int check = rand.nextInt(4);
			switch(check) {
				case 0: sb.append((char)(rand.nextInt(26) + (int)'A')); break;
				case 1: sb.append((char)(rand.nextInt(26) + (int)'a')); break;
				default: sb.append(rand.nextInt(10));
			}
		}
		return sb.toString();
	}
	
	public String setContext(String code, String type, String contextPath) {
		Context context = new Context();
		context.setVariable("contextPath", contextPath);
		context.setVariable("code", code);
		DateFormat dtf = new SimpleDateFormat("yyyy년 M월 d일 H시 m분");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, 1);
		context.setVariable("expire", dtf.format(cal.getTime()));
		return templateEngine.process(type, context);
	}
}
