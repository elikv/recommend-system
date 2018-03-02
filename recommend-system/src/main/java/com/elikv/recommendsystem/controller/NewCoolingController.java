package com.elikv.recommendsystem.controller;


import com.elikv.recommendsystem.model.RankShopInfo;
import com.elikv.recommendsystem.repository.UserRepository;
import com.elikv.recommendsystem.service.RankServiceImpl;
import com.elikv.recommendsystem.service.UserServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;


@Controller
@RequestMapping("")
public class NewCoolingController {
	@Autowired
	private RankServiceImpl rankService;
	@Autowired
	private UserRepository userRepository;
	@Autowired
	private UserServiceImpl userService;

	
	
	@RequestMapping(value="/newCooling" ,method = RequestMethod.GET)
	public String index(Model model ,@RequestParam(required=true,defaultValue="1")int pageNum,
			@RequestParam(required=true,defaultValue="10")int pageSize,
			@RequestParam(required=false)String category,
			@RequestParam(required=false)String start,@RequestParam(required=false)String end){
		PageHelper.startPage(pageNum, pageSize);
		List<RankShopInfo> findRecommend = rankService.findNewtonCooling(category,start,end);
		PageInfo<RankShopInfo> page= new PageInfo<RankShopInfo>(findRecommend);
		model.addAttribute("pageInfo", page);
		model.addAttribute("data", findRecommend);
		//添加用户标签门店
		List<String> shopIdByCurrentUser = userService.findShopIdByCurrentUser();
		model.addAttribute("shopIds",shopIdByCurrentUser);
		return "newtonCooling/index";
	} 
	
	
	
	 
}
