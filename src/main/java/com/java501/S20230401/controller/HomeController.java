package com.java501.S20230401.controller;

import java.util.AbstractMap;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.ArticleMember;
import com.java501.S20230401.model.Member;
import com.java501.S20230401.model.MemberDetails;
import com.java501.S20230401.service.ArticleService;
import com.java501.S20230401.util.SummaryType;

import lombok.RequiredArgsConstructor;

// 메인 페이지 계열 컨트롤러 : 유현규
@Controller
@RequiredArgsConstructor
public class HomeController {
	private final ArticleService as;
	
	@RequestMapping(value = "/")
	public String index(@AuthenticationPrincipal MemberDetails memberDetails, Model model) {
		model.addAttribute("now", new Date());
		if (memberDetails != null) {
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		}
		
		List<Map.Entry<Integer, String>> boards = Arrays.asList(
				new AbstractMap.SimpleEntry<Integer, String>(1000, "together"),
				new AbstractMap.SimpleEntry<Integer, String>(1100, "dutchpay"),
				new AbstractMap.SimpleEntry<Integer, String>(1200, "share"),
				new AbstractMap.SimpleEntry<Integer, String>(1300, "community"),
				new AbstractMap.SimpleEntry<Integer, String>(1400, "information"),
				new AbstractMap.SimpleEntry<Integer, String>(1500, "customer")
		);
		List<Map<String, List<ArticleMember>>> articles = new ArrayList<Map<String, List<ArticleMember>>>();
		for (Map.Entry<Integer, String> entry : boards) {
			Map<String, List<ArticleMember>> boardLists = new HashMap<String, List<ArticleMember>>();
			for (SummaryType type : new SummaryType[] { SummaryType.RECENT, SummaryType.POPULAR }) {
				List<ArticleMember> list = as.getArticleSummary(entry.getKey(), type);
				boardLists.put(type.toString(), list);
			}
			articles.add(boardLists);
		}
		model.addAttribute("boards", boards);
		model.addAttribute("articleTypes", new String[] { "RECENT", "POPULAR" });
		model.addAttribute("articles", articles);
		return "index";
	}
}
