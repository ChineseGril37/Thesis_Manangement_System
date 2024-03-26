package org.lengs.springboot.controller;
import org.lengs.springboot.common.Result;
import org.lengs.springboot.controller.request.ProcessCreateRequest;
import org.lengs.springboot.controller.request.ProcessRequest;
import org.lengs.springboot.controller.request.SubmissionRequest;
import org.lengs.springboot.entity.Submission;
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
    //listBy负责查询process进程
    @GetMapping("/listBy")
    public Result listByProcess(ProcessRequest processrequest){
        //System.out.println("processrequest="+processrequest);
        List<Process> processes = processService.listByProcess(processrequest);
        if(processes.isEmpty()){
            return Result.error("查询结果为空");
        }else {
            return Result.success(processes);
        }
    }
    //createProcess创建流程
    @PostMapping("/createProcess")
    public Result createProcess(@RequestBody ProcessCreateRequest processCreateRequest){
        processService.createProcess(processCreateRequest);
        return Result.success();
    }
    //createSubmission在流程创建时生成课题申报
    @PostMapping("/createSubmission")
    public Result createSubmission(@RequestBody SubmissionRequest submissionRequest){
        processService.createSubmission(submissionRequest);
        return Result.success(submissionRequest.getSubmissionID());
    }
    //listSubmission负责查询课题申报进程
    @GetMapping("/listSubmission")
    public Result listBySubmission(SubmissionRequest submissionRequest){
        List<Submission> submissions = processService.listBySubmission(submissionRequest);
        return Result.success(submissions);
    }
}