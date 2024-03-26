package org.lengs.springboot.service.impl;

import org.lengs.springboot.controller.request.ProcessRequest;
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
}
