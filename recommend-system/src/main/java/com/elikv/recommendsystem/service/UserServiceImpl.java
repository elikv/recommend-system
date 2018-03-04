package com.elikv.recommendsystem.service;

import com.alibaba.druid.util.StringUtils;
import com.elikv.recommendsystem.dto.UserDTO;
import com.elikv.recommendsystem.model.*;
import com.elikv.recommendsystem.repository.*;
import com.elikv.recommendsystem.utils.LoginUserUtil;
import com.google.common.collect.Lists;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;



/**
 * Created by 瓦力.
 */
@Service
public class UserServiceImpl  {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private UserLabelRepository userLabelRepository;
    @Autowired
    private UserLabelShopRepository userLabelShopRepository;

    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private LabelRepository labelRepository;


    @Autowired
    protected AuthenticationManager authenticationManager;

    private final Md5PasswordEncoder passwordEncoder = new Md5PasswordEncoder();

    public User findUserByName(String userName) {
        User user = userRepository.findByName(userName);

        if (user == null) {
            return null;
        }

        List<Role> roles = roleRepository.findRolesByUserId(user.getId());
        if (roles == null || roles.isEmpty()) {
            throw new DisabledException("权限非法");
        }

        List<GrantedAuthority> authorities = new ArrayList<>();
        roles.forEach(role -> authorities.add(new SimpleGrantedAuthority("ROLE_" + role.getName())));
        user.setAuthorityList(authorities);
        return user;
    }

    public ServiceResult<UserDTO> findById(Long userId) {
        User user = userRepository.findOne(userId);
        if (user == null) {
            return ServiceResult.notFound();
        }
        UserDTO userDTO = new UserDTO();
        BeanUtils.copyProperties(user, userDTO);
        return ServiceResult.of(userDTO);
    }

    public User findUserByTelephone(String telephone) {
        User user = userRepository.findUserByPhoneNumber(telephone);
        if (user == null) {
            return null;
        }
        List<Role> roles = roleRepository.findRolesByUserId(user.getId());
        if (roles == null || roles.isEmpty()) {
            throw new DisabledException("权限非法");
        }

        List<GrantedAuthority> authorities = new ArrayList<>();
        roles.forEach(role -> authorities.add(new SimpleGrantedAuthority("ROLE_" + role.getName())));
        user.setAuthorityList(authorities);
        return user;
    }

    @Transactional
    public User addUserByPhone(String telephone) {
        User user = new User();
        user.setPhoneNumber(telephone);
        user.setName(telephone.substring(0, 3) + "****" + telephone.substring(7, telephone.length()));
        Date now = new Date();
        user.setCreateTime(now);
        user.setLastLoginTime(now);
        user.setLastUpdateTime(now);
        user = userRepository.save(user);

        Role role = new Role();
        role.setName("USER");
        role.setUserId(user.getId());
        roleRepository.save(role);
        user.setAuthorityList(Lists.newArrayList(new SimpleGrantedAuthority("ROLE_USER")));
        return user;
    }


    /**
     * 注册完自动登录
     * @return
     */
    @Transactional
    public void loginAuto(String username , String password , HttpServletRequest request){
        UsernamePasswordAuthenticationToken token=new UsernamePasswordAuthenticationToken(username,password);
        token.setDetails(new WebAuthenticationDetails(request));
        Authentication authenticatedUser=authenticationManager.authenticate(token);
        SecurityContextHolder.getContext().setAuthentication(authenticatedUser);

        request.getSession().setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, SecurityContextHolder.getContext());
    }




    @Transactional
    public User addUser(String username,String password) throws ApiResponse {
        User userByName = findUserByName(username);
        if(userByName!=null) {
            throw new ApiResponse(10000,"用户名已被注册",null);
        }

        User user = new User();
        user.setName(username);
        String encodePassword = this.passwordEncoder.encodePassword(password, "elikv");
        user.setPassword(encodePassword);
        Date now = new Date();
        user.setCreateTime(now);
        user.setLastLoginTime(now);
        user.setLastUpdateTime(now);
        user = userRepository.save(user);

        Role role = new Role();
        role.setName("USER");
        role.setUserId(user.getId());
        roleRepository.save(role);
        user.setAuthorityList(Lists.newArrayList(new SimpleGrantedAuthority("ROLE_USER")));
        return user;
    }

    @Transactional
    public ServiceResult modifyUserProfile(String profile, String value) {
        Long userId = LoginUserUtil.getLoginUserId();
        if (profile == null || profile.isEmpty()) {
            return new ServiceResult(false, "属性不可以为空");
        }
        switch (profile) {
            case "name":
                userRepository.updateUsername(userId, value);
                break;
            case "email":
                userRepository.updateEmail(userId, value);
                break;
            case "password":
                userRepository.updatePassword(userId, this.passwordEncoder.encodePassword(value, userId));
                break;
            default:
                return new ServiceResult(false, "不支持的属性");
        }
        return ServiceResult.success();
    }

    /**
     * @return ArrayList<String>shopId
     * 通过用户找他标签下的所有餐厅
     */
    public List<String> findShopIdByCurrentUser (){

        List<String> shopIds = new ArrayList<String>();
        User byName =  currentUser();
        if(byName!=null){
            List<UserLabel> byUserId = userLabelRepository.findByUserId(byName.getId());
            for (UserLabel userLabel : byUserId) {
                String id = userLabel.getId();
                List<UserLabelShop> byUserLabelId = userLabelShopRepository.findByUserLabelId(id);
                for (UserLabelShop userLabelShop : byUserLabelId) {
                    shopIds.add(String.valueOf(userLabelShop.getShopId()));
                }
            }
        }
        return shopIds;
    }

    /**
     * 通过当前用户，标签名，获取所有餐厅
     * @return
     */
    public List<String> findShopIdByCurrentUserAndLabelName (String labelName) throws Exception {
        Label byLabelName = labelRepository.findByLabelName(labelName);
        if(byLabelName==null){
            throw new Exception(labelName+"无此标签");
        }
        List<String> shopIds = new ArrayList<String>();
        User byName =  currentUser();
        if(byName!=null){
            UserLabel byUserId = userLabelRepository.findByUserIdAndLabelId(byName.getId(),byLabelName.getLabelId());
                String id = byUserId.getId();
                List<UserLabelShop> byUserLabelId = userLabelShopRepository.findByUserLabelId(id);
                for (UserLabelShop userLabelShop : byUserLabelId) {
                    shopIds.add(String.valueOf(userLabelShop.getShopId()));
                }
        }
        return shopIds;
    }




    public User currentUser(){
        SecurityContext context = SecurityContextHolder.getContext();
        String username = context.getAuthentication().getName();
        User byName = userRepository.findByName(username);
        return byName;
    }

    /**
     * 通过userId和shopId找到userLabelId
     * 若有多个，以 , 分割
     */
    public String getUserLabelId(int shopId,Long userId){
        String matchKey = "";
        List<UserLabel> byUserId = userLabelRepository.findByUserId(userId);
        List<UserLabelShop> byShopId = userLabelShopRepository.findByShopId(shopId);
        for (UserLabelShop userLabelShop : byShopId) {
            String userLabelId = userLabelShop.getUserLabelId();

            for (UserLabel userLabel : byUserId) {
                if(StringUtils.equals(userLabelId,userLabel.getId())){
                    if(org.springframework.util.StringUtils.isEmpty(matchKey)){
                        matchKey = userLabelId;
                    }else{
                        matchKey =matchKey+ ","+userLabelId;
                    }
                }
            }
        }
        return  matchKey;
    }

    public static void main(String[] args) {
        String a ="";
        String[] split = a.split(",");
        System.out.println("123"+split);
    }

}



