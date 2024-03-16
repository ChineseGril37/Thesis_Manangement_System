package org.lengs.springboot.controller;
import org.lengs.springboot.common.Result;
import org.lengs.springboot.controller.request.UserPageRequest;
import org.lengs.springboot.entity.User;
import org.lengs.springboot.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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
    public Result page(UserPageRequest userPageRequest){
        return Result.success(userService.page(userPageRequest));
    }
    @PostMapping("/change")
    public Result change(@RequestBody User user){
        userService.change(user);
        return Result.success();
    }
}
