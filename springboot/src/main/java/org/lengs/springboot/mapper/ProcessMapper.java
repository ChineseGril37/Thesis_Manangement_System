package org.lengs.springboot.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.lengs.springboot.controller.request.ProcessRequest;

import java.util.List;

@Mapper
public interface ProcessMapper {
    List<Process> listByProcess(ProcessRequest processrequest);
}
