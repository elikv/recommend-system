package com.elikv.recommendsystem.repository;

import com.elikv.recommendsystem.model.UserLabelShop;
import org.springframework.data.repository.CrudRepository;


/**
 * 用户标签餐厅数据DAO
 * Created by elikv.
 */
public interface UserLabelShopRepository extends CrudRepository<UserLabelShop, String> {

    public UserLabelShop findByUserLabelIdAndShopId(String userLabelId,int shopId);

    public  void deleteByUserLabelIdAndShopId(String userLabelId,int shopId);
}
