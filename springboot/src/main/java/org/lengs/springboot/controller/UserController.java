package org.lengs.springboot.controller;
import java.util.List;
import java.util.Objects;

import org.lengs.springboot.controller.request.*;
import org.lengs.springboot.entity.User;
import org.lengs.springboot.common.Result;
import org.lengs.springboot.service.IUserService;

import org.lengs.springboot.controller.request.UserRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


@CrossOrigin
@RestController
@RequestMapping("/user")
public class UserController {
    @Autowired
    IUserService userService;
    @GetMapping("/list")
    public Result list(){
        List<User> users = userService.list();
        return Result.success(users);
    }
    @GetMapping("/page")
    public Result page(UserRequest userRequest){
        return Result.success(userService.page(userRequest));
    }

    @GetMapping("/count")
    public Result count(User user){
        System.out.println("user.getUserAcademy()=");
        System.out.println(user.getUserAcademy());
        int counter = userService.count(user);
        if(counter != 0){
            return Result.success(counter);
        }else {
            return Result.error("未查询到数据！");
        }
    }
    @GetMapping("/login")
    public Result login(LoginRequest loginRequest){
        return Result.success(userService.login(loginRequest));
    }
    @PostMapping("/addUser")
    public Result addUser(@RequestBody User user){
        if(!Objects.equals(user.getAccountChangeTime(), user.getAccountCreateTime())){
            userService.updateUser(user);
        }else {
            userService.addUer(user);
        }
        return Result.success();
    }
    @DeleteMapping("/delete")
    public Result delete(@RequestParam Integer userId){
        userService.deleteById(userId);
        return Result.success();
    }
    @GetMapping("/listGroup")
    public Result listGroup(GroupRequest groupRequest){
        List<User> users = userService.listGroup(groupRequest);
        if(users.isEmpty()){
            return Result.error("未查询到用户");
        }else {
            return Result.success(users);
        }
    }
    @GetMapping("/listAcademy")
    public Result listAcademy(){
        List<String> listAcademy = userService.listAcademy();
        return Result.success(listAcademy);
    }
}
