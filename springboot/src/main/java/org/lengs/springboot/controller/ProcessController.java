package org.lengs.springboot.controller;
import com.github.pagehelper.PageInfo;
import org.lengs.springboot.common.Result;
import org.lengs.springboot.controller.request.ProcessRequest;
import org.lengs.springboot.entity.*;
import org.lengs.springboot.entity.Process;
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
    @GetMapping("/listProcess")
    public Result listProcess(Process process){
        //System.out.println("processRequest="+processRequest);
        List<Process> processes = processService.listProcess(process);
        if(processes.isEmpty()){
            return Result.error("查询结果为空");
        }else {
            return Result.success(processes);
        }
    }
    @GetMapping("/listByProcess")
    public Result listByProcess(ProcessRequest processRequest){
        return Result.success(processService.listByProcess(processRequest));
    }
    //listSubmission负责查询课题申报进程
    @GetMapping("/listSubmission")
    public Result listBySubmission(Submission submissionRequest){
        List<Submission> submissions = processService.listBySubmission(submissionRequest);
        if(!submissions.isEmpty()){
            return Result.success(submissions);
        }else {
            return Result.error("查询失败");
        }
    }
    @GetMapping("/listReport")
    public Result listReport(Report reportRequest){
        List<Report> report = processService.listReport(reportRequest);
        if(!report.isEmpty()){
            return Result.success(report);
        }else {
            return  Result.error("未查询到");
        }
    }
    @GetMapping("/listMission")
    public Result listMission(Mission mission){
        List<Mission> missions =processService.listMission(mission);
        if(!missions.isEmpty()){
            return Result.success(missions);
        }else {
            return  Result.error("未查询到");
        }
    }
    @GetMapping("/listMidCheck")
    public Result listMidCheck(MidCheck midCheck){
        List<MidCheck> midChecks = processService.listMidCheck(midCheck);
        if(!midChecks.isEmpty()){
            return Result.success(midChecks);
        }else{
            return Result.error("未查询到");
        }
    }
    @GetMapping("/processQuickView")
    public Result processQuickView(ProcessRequest processRequest){
        Object userProcess = processService.listByProcess(processRequest);
        return Result.success();
    }
    //createProcess创建流程
    @PostMapping("/createProcess")
    public Result createProcess(@RequestBody Process process){
        processService.createProcess(process);
        return Result.success();
    }
    //createSubmission在流程创建时生成课题申报
    @PostMapping("/createSubmission")
    public Result createSubmission(@RequestBody Submission submissionRequest){
        processService.createSubmission(submissionRequest);
        return Result.success(submissionRequest.getSubmissionID());
    }
    @PostMapping("/createReport")
    public Result createReport(@RequestBody Report reportRequest){
        processService.createReport(reportRequest);
        if(reportRequest.getReportID() != 0){
            return Result.success(reportRequest.getReportID());
        }else {
            return Result.error("插入失败");
        }
    }
    @PostMapping("/createMission")
    public Result createMission(@RequestBody Mission mission){
        processService.createMission(mission);
        return Result.success(mission.getMissionID());
    }
    @PostMapping("/createMidCheck")
    public Result createMidCheck(@RequestBody MidCheck midCheck){
        processService.createMidCheck(midCheck);
        return Result.success(midCheck.getMidCheckID());
    }
    //更新Process流程信息
    @PostMapping("/updateProcess")
    public Result updateProcess(@RequestBody Process process){
        processService.updateProcess(process);
        return Result.success();
    }
    @PostMapping("/updateSubmission")
    public Result updateSubmission(@RequestBody Submission submissionRequest){
        System.out.println("submissionRequest=" + submissionRequest);
        processService.updateSubmission(submissionRequest);
        return Result.success();
    }
    @PostMapping("/updateReport")
    public Result updateReport(@RequestBody Report report){
        processService.updateReport(report);
        return Result.success();
    }
    @PostMapping("/updateMission")
    public Result updateMission(@RequestBody Mission mission){
        processService.updateMission(mission);
        return Result.success();
    }
    @PostMapping("/updateMidCheck")
    public Result updateMidCheck(@RequestBody MidCheck midCheck){
        processService.updateMidCheck(midCheck);
        return Result.success();
    }

}
