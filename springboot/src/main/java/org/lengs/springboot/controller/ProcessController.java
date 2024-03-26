package org.lengs.springboot.controller;

import org.lengs.springboot.common.Result;
import org.lengs.springboot.controller.request.ProcessRequest;
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

    @GetMapping("/listBy")
    public Result listByProcess(ProcessRequest processrequest){
        System.out.println("processrequest="+processrequest);
        List<Process> processes = processService.listByProcess(processrequest);
        if(processes.isEmpty()){
            return Result.error("查询结果为空");
        }else {
            return Result.success(processes);
        }
    }
}
/*
    ProcessRequest:
    private Integer processID;
    private String processName;
    private Integer processCreateBy;
*/