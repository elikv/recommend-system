package com.elikv.recommendsystem.controller;

import com.elikv.recommendsystem.model.ApiResponse;
import com.elikv.recommendsystem.model.User;
import com.elikv.recommendsystem.service.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author : elikv
 * @Date : 2018/2/18 15:35
 */
@Controller
public class IndexController {
    @Autowired
    private UserServiceImpl userService;

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
        request.getRequestDispatcher("/newCooling").forward(request,response);
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

}
