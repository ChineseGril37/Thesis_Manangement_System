package org.lengs.springboot.service;

import com.github.pagehelper.PageInfo;
import org.lengs.springboot.controller.request.ProcessRequest;
import org.lengs.springboot.entity.*;
import org.lengs.springboot.entity.Process;

import java.util.List;

public interface IProcessService {
    List<Process> listProcess(Process process);

    Object listByProcess(ProcessRequest processRequest);

    List<Submission> listBySubmission(Submission submissionRequest);

    List<Mission> listMission(Mission mission);

    List<Report> listReport(Report reportRequest);

    List<MidCheck> listMidCheck(MidCheck midCheck);

    void createProcess(Process process);

    void createSubmission(Submission submissionRequest);

    void createMidCheck(MidCheck midCheck);

    void updateSubmission(Submission submissionRequest);

    void createReport(Report reportRequest);

    void createMission(Mission mission);

    void updateProcess(Process process);

    void updateMission(Mission mission);

    void updateReport(Report report);

    void updateMidCheck(MidCheck midCheck);
}
