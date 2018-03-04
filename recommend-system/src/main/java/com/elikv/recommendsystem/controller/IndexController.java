package com.elikv.recommendsystem.controller;

import com.alibaba.druid.util.StringUtils;
import com.elikv.recommendsystem.model.ApiResponse;
import com.elikv.recommendsystem.model.RankShopInfo;
import com.elikv.recommendsystem.model.User;
import com.elikv.recommendsystem.service.RankServiceImpl;
import com.elikv.recommendsystem.service.UserServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author : elikv
 * @Date : 2018/2/18 15:35
 */
@Controller
public class IndexController {
    @Autowired
    private UserServiceImpl userService;
    @Autowired
    private RankServiceImpl rankService;

    @RequestMapping("/")
    public void toHome(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/newCooling").forward(request,response);
    }



        @RequestMapping("/index")
        public void toIndex(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {
            request.getRequestDispatcher("/newCooling").forward(request,response);
    }

    @RequestMapping("/user/login")
    public String login(){
        return "login";
    }
    @RequestMapping("/signup2")
    public String signup2(){
        return "signup";
    }

    @RequestMapping("/logout/page")
    public void logout(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/newCooling").forward(request,response);
    }

    @RequestMapping(value = "/signup",method = RequestMethod.POST)
    public void signup(HttpServletRequest request, HttpServletResponse response) throws IOException, ApiResponse, ServletException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        userService.addUser(username,password);
        userService.loginAuto(username,password,request);
        response.sendRedirect("newCooling");
    }

    @RequestMapping("/validate")
    @ResponseBody
    public ApiResponse validateUsername(@RequestParam("username")String username){
        User user = userService.findUserByName(username);
        if(user==null){
            return ApiResponse.ofSuccess("");
        }
        return ApiResponse.ofStatus(ApiResponse.Status.DUPLICATE_USERNAME);
    }

    @Transactional(rollbackFor = Throwable.class)
    @RequestMapping(value="/user/collection" ,method = RequestMethod.GET)
    public String index(Model model , @RequestParam(required=true,defaultValue="1")int pageNum,
                        @RequestParam(required=true,defaultValue="10")int pageSize,
                        @RequestParam(required=false)String category, @RequestParam(required=false)String labelName,
                        @RequestParam(required=false)String start, @RequestParam(required=false)String end) throws Exception {
        PageHelper.startPage(pageNum, pageSize);
        List<String> shopIdByCurrentUserAndLabelName = new ArrayList<String>();
        if(!StringUtils.isEmpty(labelName)){
            shopIdByCurrentUserAndLabelName = userService.findShopIdByCurrentUserAndLabelName(labelName);
        }else {
            shopIdByCurrentUserAndLabelName = userService.findShopIdByCurrentUser();
        }
        if(CollectionUtils.isEmpty(shopIdByCurrentUserAndLabelName)){
            PageInfo<RankShopInfo> page= new PageInfo<RankShopInfo>(null);
            model.addAttribute("pageInfo", page);
            model.addAttribute("data", null);
        }else{
            List<RankShopInfo> findRecommend = rankService.findLabelShop(category,start,end,shopIdByCurrentUserAndLabelName);
            PageInfo<RankShopInfo> page= new PageInfo<RankShopInfo>(findRecommend);
            model.addAttribute("pageInfo", page);
            model.addAttribute("data", findRecommend);
        }

        return "collection/collection";
    }

}
