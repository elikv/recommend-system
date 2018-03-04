package com.elikv.recommendsystem.repository;

import com.elikv.recommendsystem.model.UserLabel;
import org.springframework.data.repository.CrudRepository;

import java.util.List;


/**
 * 用户标签数据DAO
 * Created by elikv.
 */
public interface UserLabelRepository extends CrudRepository<UserLabel, String> {
    List<UserLabel> findByUserId(Long userId);

    UserLabel findByUserIdAndLabelId(Long userId,String LabelId);


    void deleteByUserId(Long UserId);

    void deleteByUserIdAndLabelId(Long UserId,String labelId);


}
