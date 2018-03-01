package com.elikv.recommendsystem.repository;

import com.elikv.recommendsystem.model.Label;
import org.springframework.data.repository.CrudRepository;


/**
 * 标签数据DAO
 * Created by elikv.
 */
public interface LabelRepository extends CrudRepository<Label, String> {
    Label findByLabelName(String labelName);
}
