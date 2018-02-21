package com.elikv.recommendsystem;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.elikv.recommendsystem.dao")
public class RecommendSystemApplication  {


	public static void main(String[] args) {
		SpringApplication.run(RecommendSystemApplication.class, args);
	}
}
