package com.elikv.recommendsystem.dao;


import com.elikv.recommendsystem.model.ShopIdRankTimeScoreEntity;
import org.springframework.stereotype.Component;



/**
 * @author elikv
 *         Date: 18-2-13
 *         Time: 下午3:42
 */
@Component
public interface IShopIdRankTimeScoreDao {

    public int add(ShopIdRankTimeScoreEntity shopIdRankTimeScore);
    
    public ShopIdRankTimeScoreEntity findByShopId(int shopId);
    
    public void update(ShopIdRankTimeScoreEntity shopIdRankTimeScore);
    
    
    
}
