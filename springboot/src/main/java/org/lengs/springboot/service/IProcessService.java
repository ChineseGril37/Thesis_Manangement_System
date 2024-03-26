package org.lengs.springboot.service;

import org.lengs.springboot.controller.request.ProcessCreateRequest;
import org.lengs.springboot.controller.request.ProcessRequest;
import org.lengs.springboot.controller.request.SubmissionRequest;
import org.lengs.springboot.entity.Submission;

import java.util.List;

public interface IProcessService {
    List<Process> listByProcess(ProcessRequest processrequest);

    void createProcess(ProcessCreateRequest processCreateRequest);

    Integer createSubmission(SubmissionRequest submissionRequest);

    List<Submission> listBySubmission(SubmissionRequest submissionRequest);
}
