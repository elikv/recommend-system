package com.elikv.recommendsystem.dao;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.elikv.recommendsystem.model.AppraiseEntity;
import com.elikv.recommendsystem.model.DianPingInfo;
import com.elikv.recommendsystem.model.RankShopInfo;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;


/**
 * @author elikv
 *         Date: 17-6-23
 *         Time: 下午4:27
 */
@Component
@Repository
public interface DianPingDAO {

    //添加大众点评网的数据到数据库
    public int add(DianPingInfo dianPingInfo);
    //返回存在的url
    public ArrayList<String> findExist();
    
    public ArrayList<DianPingInfo> findAll();
    
    public void update(DianPingInfo dianPingInfo);



    /**
     *  
     * @return t_shop_star所有shopId
     */
    public List<String>findShopIdByStar();
    

    
    public int findMaxPage(String shopId);
    //通过排行榜数据 查找上榜次数最多的 shopId
    public List<String> findStarShopId();
    
    
    //-----------------------AppraiseEntity----------------------------------
    public void addAppraise(AppraiseEntity appraiseEntity);
    /**
     *  通过shopId找AppraiseEntity
     * @param shopId
     * @return
     */
    public AppraiseEntity findByShopId(String shopId);
    
    public void updateAppraiseEntity(AppraiseEntity appraiseEntity);
    
    
    
    //------------------------RankShopInfo-------------------------------------
    
    public List<RankShopInfo>findRecommend(Map<String, Object> map);
    
}
