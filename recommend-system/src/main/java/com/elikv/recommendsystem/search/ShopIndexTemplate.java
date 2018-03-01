package com.elikv.recommendsystem.search;

import com.elikv.recommendsystem.model.BaiduMapLocation;
import lombok.Data;

import java.util.List;

/**
 *
 * 索引结构模板
 * Created by elikv.
 */
@Data
public class ShopIndexTemplate {
   private  int shopId;
    private  int avrPrice;
   private  String address;
   private  String shopName;
   //菜系
   private  String category;


    //标签
    private List<String> tags;
    //自动补全 提示
    private List<HouseSuggest> suggest;
    //经纬度
    private BaiduMapLocation location;

    public BaiduMapLocation getLocation() {
        return location;
    }


}
