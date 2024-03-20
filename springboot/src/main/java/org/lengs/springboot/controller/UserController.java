package org.lengs.springboot.controller;
import org.lengs.springboot.common.Result;
import org.lengs.springboot.controller.request.LoginRequest;
import org.lengs.springboot.controller.request.UserExistRequest;
import org.lengs.springboot.controller.request.UserPageRequest;
import org.lengs.springboot.entity.User;
import org.lengs.springboot.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    IUserService userService;
    @GetMapping("/login")
    public Result login(@RequestBody LoginRequest loginRequest){
        userService.login(loginRequest);
        return Result.success(loginRequest);
    }
    @GetMapping("/list")
    public Result list(){
        List<User> users = userService.list();
        return Result.success(users);
    }
    @GetMapping("/page")
    public Result page(UserPageRequest userPageRequest){
        return Result.success(userService.page(userPageRequest));
    }
    @PostMapping("/addUser")
    public Result addUer(@RequestBody User user){
        userService.addUer(user);
        return Result.success();
    }
    @DeleteMapping("/delete")
    public Result delete(@RequestParam Integer userId){
        userService.deleteById(userId);
        return Result.success();
    }
}
