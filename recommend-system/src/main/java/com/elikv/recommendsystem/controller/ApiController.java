package com.elikv.recommendsystem.controller;

import com.alibaba.druid.util.StringUtils;
import com.elikv.recommendsystem.model.*;
import com.elikv.recommendsystem.repository.LabelRepository;
import com.elikv.recommendsystem.repository.UserLabelRepository;
import com.elikv.recommendsystem.repository.UserLabelShopRepository;
import com.elikv.recommendsystem.repository.UserRepository;
import com.elikv.recommendsystem.service.LabelServiceImpl;
import com.elikv.recommendsystem.service.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * @author : elikv
 * @Date : 2018/2/28 17:21
 */
@RestController
@RequestMapping("/api")
public class ApiController
{
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private UserLabelRepository userLabelRepository;
    @Autowired
    private UserLabelShopRepository userLabelShopRepository;
    @Autowired
    private LabelRepository labelRepository;
    @Autowired
    private UserServiceImpl userService;
    @Autowired
    private LabelServiceImpl labelService;

    /**
     * @param allLabel 所有的标签名  以分号分隔
     * @param activeLabel 选中的标签
     * @param activeShopId 选中门店
     * @param modifyStatus 是否改变餐厅-标签关系
     */
    @Transactional(rollbackFor = Throwable.class)
    @RequestMapping(value = "addOrModifyLabel",method = RequestMethod.POST)
    public ApiResponse addLabel(HttpSession session,String allLabel,String activeLabel,int activeShopId,String modifyStatus){
        if(session.getAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY)==null){
            return ApiResponse.ofMessage(50000,"请先登录");
        }
        User byName = userService.currentUser();
        Long userId = byName.getId();
        List<String> allLabels = new ArrayList<String>();
        if(!StringUtils.isEmpty(allLabel)){
            String[] split = allLabel.split(",");
            allLabels = Arrays.asList(split);
        }
        //标签
        for (String label : allLabels) {
            UserLabel userLabel = new UserLabel();
            userLabel.setCreateTime(new Date());
            userLabel.setId(UUID.randomUUID().toString());
            userLabel.setUserId(userId);
            Label byLabelName = labelRepository.findByLabelName(label);
            if(byLabelName==null){
                Label label1 = new Label();
                label1.setCreateTime(new Date());
                label1.setLabelName(label);
                label1.setLabelId(UUID.randomUUID().toString());
                labelRepository.save(label1);
                userLabel.setLabelId(label1.getLabelId());
            }else{
                userLabel.setLabelId(byLabelName.getLabelId());
            }
            //用户-标签关系
            UserLabel byUserIdAndLabelId = userLabelRepository.findByUserIdAndLabelId(userId, userLabel.getLabelId());
            if(byUserIdAndLabelId==null) {
                userLabelRepository.save(userLabel);
            }

        }
        //用户-标签-门店
        //选中标签
        //先删除所选门店的user-label-shop关系
        labelService.deleteShopUserLabelByActiveShopId(activeShopId);

        //根据选中标签与选中门店  添加user-label-shop关系
        labelService.saveUserLabelShop(activeLabel,activeShopId);

        return ApiResponse.ofMessage(200,"收藏成功");
    }


    @RequestMapping(value="/findAllLabels",method = RequestMethod.POST)
    public ApiResponse findAllLabels(HttpSession session){
        User byName = userService.currentUser();
        if(byName==null){
            return ApiResponse.ofMessage(50000,"请先登录");
        }
        List<String> allLabels = labelService.findAllLabels();
        return ApiResponse.ofSuccess(allLabels);
    }
    @Transactional(rollbackFor = Throwable.class)
    @RequestMapping(value="/notCollection",method = RequestMethod.POST)
    public ApiResponse notCollection(int shopId){
        User byName = userService.currentUser();
        if(byName==null){
            return ApiResponse.ofMessage(50000,"请先登录");
        }
        Long userId = byName.getId();
        String userLabelId = userService.getUserLabelId(shopId, userId);
        String[] split = userLabelId.split(",");
        for (String s : split) {
            userLabelShopRepository.deleteByUserLabelIdAndShopId(s,shopId);
        }

        return ApiResponse.ofSuccess(null);

    }

    @RequestMapping(value="/addLabel",method = RequestMethod.POST)
    public ApiResponse addLabel(String labelName){
        User byName = userService.currentUser();
        if(byName==null){
            return ApiResponse.ofMessage(50000,"请先登录");
        }
        labelService.saveUserLabel(labelName);
        return ApiResponse.ofSuccess(null);
    }

    @RequestMapping(value="/deleteLabel",method = RequestMethod.POST)
    public ApiResponse deleteLabel(String labelName){
        User byName = userService.currentUser();
        if(byName==null){
            return ApiResponse.ofMessage(50000,"请先登录");
        }
        labelService.deleteUserLabel(labelName);
        return ApiResponse.ofSuccess(null);
    }




}
