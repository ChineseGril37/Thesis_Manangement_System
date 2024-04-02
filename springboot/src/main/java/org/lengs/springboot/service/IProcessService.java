package org.lengs.springboot.service;

import org.lengs.springboot.controller.request.ProcessRequest;
import org.lengs.springboot.entity.*;
import org.lengs.springboot.entity.Process;

import java.util.List;

public interface IProcessService {
    List<Process> listProcess(Process process);

    void createProcess(Process process);

    void createSubmission(Submission submissionRequest);

    List<Submission> listBySubmission(Submission submissionRequest);

    void updateSubmission(Submission submissionRequest);

    List<Report> listReport(Report reportRequest);

    void createReport(Report reportRequest);

    List<Process> listByProcess(ProcessRequest processRequest);

    void updateProcess(Process process);

    List<Mission> listMission(Mission mission);

    void createMission(Mission mission);

    void updateMission(Mission mission);

    List<MidCheck> listMidCheck(MidCheck midCheck);

    void createMidCheck(MidCheck midCheck);

    void updateReport(Report report);

    void updateMidCheck(MidCheck midCheck);
}
