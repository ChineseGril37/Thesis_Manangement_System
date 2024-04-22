package org.lengs.springboot.mapper;
import org.apache.ibatis.annotations.Mapper;
import org.lengs.springboot.controller.request.GroupRequest;
import org.lengs.springboot.controller.request.LoginRequest;
import org.lengs.springboot.controller.request.UserRequest;
import org.lengs.springboot.entity.User;

import java.util.List;

@Mapper
public interface UserMapper {
//    @Select("select * from user")
    List<User> list();

    List<User> listByCondition(UserRequest userRequest);

    void addUer(User user);

    void deleteById(Integer userId);

    User login(LoginRequest loginRequest);

    void updateUser(User user);


    List<User> listGroup(GroupRequest groupRequest);

    Integer count(User user);
}
