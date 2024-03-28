package org.lengs.springboot.service.impl;

import org.lengs.springboot.controller.request.ProcessRequest;
import org.lengs.springboot.entity.Report;
import org.lengs.springboot.entity.Submission;
import org.lengs.springboot.mapper.ProcessMapper;
import org.lengs.springboot.service.IProcessService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.lengs.springboot.entity.Process;

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
    public List<Process> listByProcess(ProcessRequest processRequest) {return processMapper.listByProcess(processRequest);}

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
