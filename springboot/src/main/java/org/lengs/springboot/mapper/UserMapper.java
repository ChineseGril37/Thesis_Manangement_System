package org.lengs.springboot.mapper;
import org.apache.ibatis.annotations.Mapper;
import org.lengs.springboot.controller.request.UserPageRequest;
import org.lengs.springboot.entity.User;

import java.util.List;

@Mapper
public interface UserMapper {
//    @Select("select * from user")
    List<User> list();

    List<User> listByCondition(UserPageRequest userPageRequest);

    void addUer(User user);

    void delete(User user);
}
