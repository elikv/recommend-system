package com.elikv.recommendsystem.dao;


import com.elikv.recommendsystem.model.RankShopInfo;
import com.elikv.recommendsystem.model.ShopIdRankTimeScoreEntity;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;



/**
 * @author elikv
 *         Date: 17-6-23
 *         Time: 下午4:27
 */
@Repository
public interface RankShopDao {

    //添加大众点评网的数据到数据库
    public int addList(List<RankShopInfo> dianPingInfo);
    
    public List<RankShopInfo>findByShopId(int shopId);
    
    public List<RankShopInfo>findByShopIdAndRankTime(Map<String, Object> map);
    
    public List<RankShopInfo>findByShopIdAndRankType(Map<String, Object> map);
    /**
     * 显示所有id
     */
    public List<String>findShopIdAll();
    
    public void deletefromId(String id);
    /**
     * 从t_rank_shop中寻找shopId-RankTime-Score关系
     * @return
     */
    public List<ShopIdRankTimeScoreEntity> findShopIdRankTimeScore();
    
    /**
     * 显示数据 牛顿冷却定律排序
     */
    public List<RankShopInfo>findNewtonCooling(Map<String, Object> map);

    /**
     * 根据指定id 拿到数据
     * @param map
     * @return
     */
    public List<RankShopInfo>findLabelShop(Map<String, Object> map);
   
}
