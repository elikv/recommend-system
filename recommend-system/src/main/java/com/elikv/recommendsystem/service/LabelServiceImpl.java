package com.elikv.recommendsystem.service;

import com.alibaba.druid.util.StringUtils;
import com.elikv.recommendsystem.model.Label;
import com.elikv.recommendsystem.model.User;
import com.elikv.recommendsystem.model.UserLabel;
import com.elikv.recommendsystem.model.UserLabelShop;
import com.elikv.recommendsystem.repository.LabelRepository;
import com.elikv.recommendsystem.repository.UserLabelRepository;
import com.elikv.recommendsystem.repository.UserLabelShopRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * @author : elikv
 * @Date : 2018/3/4 3:07
 */
@Service
public class LabelServiceImpl {
    @Autowired
    private UserServiceImpl userService;
    @Autowired
    private UserLabelRepository userLabelRepository;
    @Autowired
    private UserLabelShopRepository userLabelShopRepository;
    @Autowired
    private LabelRepository labelRepository;

    public List<String> findAllLabels(){
        User byName = userService.currentUser();
        List<String> list = new ArrayList<>();
        Long userId = byName.getId();
        List<UserLabel> byUserId = userLabelRepository.findByUserId(userId);
        for (UserLabel userLabel : byUserId) {
            list.add(labelRepository.findOne(userLabel.getLabelId()).getLabelName());
        }
        return list;
    }

    /**
     * 添加label关系，user-label关系
     * @param labelName
     */

    public void saveUserLabel(String labelName){
        User user = userService.currentUser();
        Label byLabelName = labelRepository.findByLabelName(labelName);
        UserLabel userLabel = new UserLabel();
        if(byLabelName==null){
            Label label = new Label();
            label.setLabelId(UUID.randomUUID().toString());
            label.setLabelName(labelName);
            label.setCreateTime(new Date());
            labelRepository.save(label);

            userLabel.setLabelId(label.getLabelId());
        }else{
            userLabel.setLabelId(byLabelName.getLabelId());
        }
        userLabel.setUserId(user.getId());
        userLabel.setId(UUID.randomUUID().toString());
        userLabel.setCreateTime(new Date());
        userLabelRepository.save(userLabel);
    }


    /**
     * 删除label关系，user-label关系
     * @param labelName
     */
    @Transactional(rollbackFor = Throwable.class)
    public void deleteUserLabel(String labelName){
        User user = userService.currentUser();
        Long userId = user.getId();
        Label byLabelName = labelRepository.findByLabelName(labelName);
        String labelId="";
        if(byLabelName!=null){
            labelId = byLabelName.getLabelId();
        }
        UserLabel byUserIdAndLabelId = userLabelRepository.findByUserIdAndLabelId(userId, labelId);
        if(byUserIdAndLabelId!=null){
            userLabelShopRepository.deleteByUserLabelId(byUserIdAndLabelId.getId());
        }
        userLabelRepository.deleteByUserIdAndLabelId(userId,labelId);
        labelRepository.delete(labelId);
    }

    /**
     * 根据shopId删除user_labe_shop关系
     * @param activeShopId 可多选 以','分割
     */
    @Transactional(rollbackFor = Throwable.class)
    public void deleteShopUserLabelByActiveShopId(int activeShopId){
        User user = userService.currentUser();
        Long userId = user.getId();
        List<String> userLabelIdList = new ArrayList<>();
        String userLabelIds = userService.getUserLabelId(activeShopId, userId);
        if(!StringUtils.isEmpty(userLabelIds)){
            String[] split = userLabelIds.split(",");
            userLabelIdList = Arrays.asList(split);
        }
        for (String userLabelId : userLabelIdList) {
            userLabelShopRepository.deleteByUserLabelIdAndShopId(userLabelId,activeShopId);
        }
    }

    /**
     * 根据labelName查找当前用户的UserLabel
     * @param activelabel
     * @return
     */
    @Transactional(rollbackFor = Throwable.class)
    public UserLabel findUserLabelByLabelName(String activelabel){
        User user = userService.currentUser();
        Long userId = user.getId();
        Label byLabelName = labelRepository.findByLabelName(activelabel);
        String activeLabelId = byLabelName.getLabelId();
        UserLabel byUserIdAndLabelId = userLabelRepository.findByUserIdAndLabelId(userId, activeLabelId);
        return byUserIdAndLabelId;
    }

    /**
     * 根据标签名称（多选） 保存UserLabelShop
     * @param activeLabels
     */
    @Transactional(rollbackFor = Throwable.class)
    public void saveUserLabelShop(String activeLabels,int activeShopId){
        List<String>activeLabelList =  new ArrayList<String>();
        String[] activelabels = activeLabels.split(",");
        activeLabelList = Arrays.asList(activelabels);
        for (String activelabel : activeLabelList) {
            UserLabel byUserIdAndLabelId = findUserLabelByLabelName(activelabel);
            UserLabelShop userLabelShop = new UserLabelShop();
            userLabelShop.setCreateTime(new Date());
            userLabelShop.setId(UUID.randomUUID().toString());
            userLabelShop.setShopId(activeShopId);
            userLabelShop.setUserLabelId(byUserIdAndLabelId.getId());
            userLabelShopRepository.save(userLabelShop);
        }
    }

}
