package org.lengs.springboot.service;

import org.lengs.springboot.controller.request.AcademyRequest;
import org.lengs.springboot.controller.request.GroupRequest;
import org.lengs.springboot.controller.request.LoginRequest;
import org.lengs.springboot.controller.request.UserRequest;
import org.lengs.springboot.entity.User;

import java.util.List;

public interface IUserService {
    List<User> list();

    Object page(UserRequest userRequest);

    void addUer(User user);

    void updateUser(User user);

    void deleteById(Integer userId);

    User login(LoginRequest loginRequest);

    List<User> listGroup(GroupRequest groupRequest);

    Integer count(User user);

    List<String> listAcademy();
}
