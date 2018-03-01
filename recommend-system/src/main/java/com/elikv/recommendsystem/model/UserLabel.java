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
@Table(name = "t_user_label")
public class UserLabel {
    @Id
    private String id;
    @Column(name = "labelId")
    private String labelId;
    @Column(name = "userId")
    private Long userId;


    @Column(name = "createTime")
    private Date createTime;

}
