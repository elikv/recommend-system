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
@Table(name = "label")
public class Label {
    @Id
    @Column(name = "labelId")
    private String labelId;
    @Column(name = "labelName")
    private String labelName;


    @Column(name = "createTime")
    private Date createTime;

}
