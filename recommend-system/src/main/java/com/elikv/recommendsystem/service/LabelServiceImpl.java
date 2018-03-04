package com.elikv.recommendsystem.service;

import com.elikv.recommendsystem.model.User;
import com.elikv.recommendsystem.model.UserLabel;
import com.elikv.recommendsystem.repository.LabelRepository;
import com.elikv.recommendsystem.repository.UserLabelRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

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

}
