package com.elikv.recommendsystem.model;

import lombok.Data;

@Data
public class AppraiseEntity {
	protected String shopId;
	//好评数
	private String good;
	//中评数
	private String common;
	//差评数
	private String bad;
	//第一种打分
	private String score1;
	//第二种打分
	private String score2;
	
	public AppraiseEntity(String shopId,String bad ,String common,String good){
		this.shopId=shopId;
		this.good=good;
		this.common=common;
		this.bad=bad;
	}
	public AppraiseEntity(){
		
	}
}
