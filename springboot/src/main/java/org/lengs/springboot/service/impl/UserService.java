package org.lengs.springboot.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.lengs.springboot.controller.request.LoginRequest;
import org.lengs.springboot.controller.request.UserRequest;
import org.lengs.springboot.entity.User;
import org.lengs.springboot.mapper.UserMapper;
import org.lengs.springboot.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class UserService implements IUserService {

    @Autowired
    UserMapper userMapper;

    @Override
    public List<User> list(){
        return userMapper.list();
    }

    @Override
    public Object page(UserRequest userRequest) {
        PageHelper.startPage(userRequest.getPageNum(), userRequest.getPageSize());
        List<User> users = userMapper.listByCondition(userRequest);
        return new PageInfo<>(users);
    }

    @Override
    public void addUer(User user) {
        userMapper.addUer(user);
    }

    @Override
    public void updateUser(User user) { userMapper.updateUser(user); }

    @Override
    public void deleteById(Integer userId) {
        userMapper.deleteById(userId);
    }

    @Override
    public User login(LoginRequest loginRequest) {
        return userMapper.login(loginRequest);
    }

    @Override
    public User getGroup(Integer groupID) {
        return userMapper.getGroup(groupID);
    }
}
