package org.lengs.springboot.service;

import java.util.List;

public interface IProcessService {
    List<Process> listProcess();
    List<Process> listByProcess(Process process);
}
