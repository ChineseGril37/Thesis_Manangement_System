package org.lengs.springboot.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.lengs.springboot.controller.request.ProcessRequest;
import org.lengs.springboot.entity.*;
import org.lengs.springboot.entity.Process;
import org.lengs.springboot.mapper.ProcessMapper;
import org.lengs.springboot.service.IProcessService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProcessService implements IProcessService {
    @Autowired
    ProcessMapper processMapper;

    @Override
    public List<Process> listProcess(Process process) {
        return processMapper.listProcess(process);
    }

    @Override
    public void createProcess(Process process) {
        processMapper.createProcess(process);
    }

    @Override
    public PageInfo<Process> listByProcess(ProcessRequest processRequest) {
        PageHelper.startPage(processRequest.getPageNum(), processRequest.getPageSize());
        List<Process> processes = processMapper.listByProcess(processRequest);
        return new PageInfo<>(processes);
    }

    @Override
    public void updateProcess(Process process) {processMapper.updateProcess(process);}

    @Override
    public List<Mission> listMission(Mission mission) {
        return processMapper.listMission(mission);
    }

    @Override
    public void createMission(Mission mission) {
        processMapper.createMission(mission);
    }

    @Override
    public void updateMission(Mission mission) {
        processMapper.updateMission(mission);
    }

    @Override
    public List<MidCheck> listMidCheck(MidCheck midCheck) {
        return processMapper.listMidCheck(midCheck);
    }

    @Override
    public void createMidCheck(MidCheck midCheck) {
        processMapper.createMidCheck(midCheck);
    }

    @Override
    public void updateReport(Report report) { processMapper.updateReport(report); }

    @Override
    public void updateMidCheck(MidCheck midCheck) { processMapper.updateMidCheck(midCheck); }

    @Override
    public void createSubmission(Submission submissionRequest) {
        processMapper.createSubmission(submissionRequest);
    }

    @Override
    public List<Submission> listBySubmission(Submission submissionRequest) {
        return processMapper.listBySubmission(submissionRequest);
    }

    @Override
    public void updateSubmission(Submission submissionRequest) {
        processMapper.updateSubmission(submissionRequest);
    }

    @Override
    public List<Report> listReport(Report reportRequest) {
        return processMapper.listReport(reportRequest);
    }

    @Override
    public void createReport(Report reportRequest) {
        processMapper.createReport(reportRequest);
    }

}
