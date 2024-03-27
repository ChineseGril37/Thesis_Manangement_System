package org.lengs.springboot.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.lengs.springboot.controller.request.ProcessCreateRequest;
import org.lengs.springboot.controller.request.ProcessRequest;
import org.lengs.springboot.controller.request.SubmissionRequest;
import org.lengs.springboot.entity.Submission;
import org.lengs.springboot.entity.Process;

import java.util.List;

@Mapper
public interface ProcessMapper {
    List<Process> listByProcess(ProcessRequest processrequest);

    void createProcess(Process process);

    Integer createSubmission(SubmissionRequest submissionRequest);

    List<Submission> listBySubmission(SubmissionRequest submissionRequest);
}
