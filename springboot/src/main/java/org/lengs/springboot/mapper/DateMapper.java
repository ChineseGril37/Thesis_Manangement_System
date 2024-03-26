package org.lengs.springboot.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.lengs.springboot.entity.Date;

@Mapper
public interface DateMapper {
    Object listDate();

    void update(Date date);
}
