package org.lengs.springboot.entity;
import lombok.Data;

@Data
public class Process {
    private Integer processID;
    private String processName;
    private Integer processCreateBy;
    private Integer groupID;
    private String processChangeTime;
    private String processCreateTime;
    private String processDeadTime;
    private String processCondition;
    private Integer processSubmission;
    private Integer processReport;
    private Integer processMission;
    private Integer processMidcheck;
    private Integer processOral;
}
