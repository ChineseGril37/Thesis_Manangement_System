package org.lengs.springboot.service;

import org.lengs.springboot.controller.request.LoginRequest;
import org.lengs.springboot.controller.request.UserPageRequest;
import org.lengs.springboot.entity.User;

import java.util.List;

public interface IUserService {
    List<User> list();

    Object page(UserPageRequest userPageRequest);

    void addUer(User user);

    void updateUser(User user);

    void deleteById(Integer userId);

    User login(LoginRequest loginRequest);
}
