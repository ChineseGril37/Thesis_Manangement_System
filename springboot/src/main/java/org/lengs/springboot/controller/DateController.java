package org.lengs.springboot.controller;

import org.lengs.springboot.common.Result;
import org.lengs.springboot.entity.Date;
import org.lengs.springboot.service.IDateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin
@RestController
@RequestMapping("/date")
public class DateController {
    @Autowired
    IDateService dateService;

    @GetMapping("/list")
    public Result listDate(){
        return Result.success(dateService.listDate());
    }
    @PostMapping("/update")
    public Result update(@RequestBody Date date){
        dateService.update(date);
        return Result.success();
    }
}
