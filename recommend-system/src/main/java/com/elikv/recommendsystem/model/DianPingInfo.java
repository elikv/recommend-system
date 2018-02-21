package com.elikv.recommendsystem.model;



import lombok.Data;
import org.springframework.stereotype.Component;

@Data
@Component
public  class  DianPingInfo{
	private String shopName;
	
	private String comment;
	
	private String average;
	
	private String comment_score;

	private String address;
	private String tag;
	private String img;
	
	private String url;
	
	private String taste;
	private String env;
	private String service;
	private String cookStyle;
	private String shopId;
	private String threadNo;
	
	private String id;
	
	//好评数
	private String good;
	
	//中评数
	private String common;
	//差评数
	private String bad;


}
