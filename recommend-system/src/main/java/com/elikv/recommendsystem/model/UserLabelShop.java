package com.elikv.recommendsystem.model;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

/**
 * Created by elikv.
 */
@Data
@Entity
@Table(name = "t_user_label_shopId")
public class UserLabelShop {
    @Id
    private String id;
    @Column(name = "user_label_id")
    private String userLabelId;
    @Column(name = "shopId")
    private int shopId;


    @Column(name = "createTime")
    private Date createTime;

}
