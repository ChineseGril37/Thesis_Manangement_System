package org.lengs.springboot.controller;

import org.lengs.springboot.common.Result;
import org.lengs.springboot.service.IProcessService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/process")
public class ProcessController {
    @Autowired
    IProcessService processService;

    @GetMapping("/list")
    public Result listProcess(){
        List<Process> processes = processService.listProcess();
        return Result.success(processes);
    }

    @GetMapping("/listBy")
    public Result listByProcess(@RequestBody Process process){
        List<Process> processes = processService.listProcess(process);
        return Result.success();
    }
}
