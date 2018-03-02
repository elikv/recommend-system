package com.elikv.recommendsystem.repository;

import com.elikv.recommendsystem.model.UserLabelShop;
import org.springframework.data.repository.CrudRepository;

import java.util.List;


/**
 * 用户标签餐厅数据DAO
 * Created by elikv.
 */
public interface UserLabelShopRepository extends CrudRepository<UserLabelShop, String> {

    public UserLabelShop findByUserLabelIdAndShopId(String userLabelId,int shopId);

    public List<UserLabelShop> findByUserLabelId(String userLabelId);

    public List<UserLabelShop> findByShopId(int shopId);

    public  void deleteByUserLabelIdAndShopId(String userLabelId,int shopId);


}
