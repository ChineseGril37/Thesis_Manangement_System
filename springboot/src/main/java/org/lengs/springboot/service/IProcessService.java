package org.lengs.springboot.service;

import org.lengs.springboot.controller.request.ProcessRequest;

import java.util.List;

public interface IProcessService {
    List<Process> listByProcess(ProcessRequest processrequest);
}
