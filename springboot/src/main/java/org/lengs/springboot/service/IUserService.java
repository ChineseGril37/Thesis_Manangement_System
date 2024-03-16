package org.lengs.springboot.service;

import org.lengs.springboot.controller.request.UserPageRequest;
import org.lengs.springboot.entity.User;

import java.util.List;

public interface IUserService {
    List<User> list();

    Object page(UserPageRequest userPageRequest);

    void change(User user);
}
