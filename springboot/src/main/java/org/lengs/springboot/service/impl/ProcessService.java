package org.lengs.springboot.service.impl;

import org.lengs.springboot.controller.request.ProcessCreateRequest;
import org.lengs.springboot.controller.request.ProcessRequest;
import org.lengs.springboot.controller.request.SubmissionRequest;
import org.lengs.springboot.entity.Submission;
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
    public List<Process> listByProcess(ProcessRequest processrequest) {
        return processMapper.listByProcess(processrequest);
    }

    @Override
    public void createProcess(ProcessCreateRequest processCreateRequest) {
        processMapper.createProcess(processCreateRequest);
    }

    @Override
    public Integer createSubmission(SubmissionRequest submissionRequest) {
        return processMapper.createSubmission(submissionRequest);
    }

    @Override
    public List<Submission> listBySubmission(SubmissionRequest submissionRequest) {
        return processMapper.listBySubmission(submissionRequest);
    }
}
