package org.lengs.springboot.entity;
import lombok.Data;

@Data
public class Process {
    private Integer processID;
    private String processName;
    private String processMajor;
    private Integer processCreateBy;
    private Integer groupID;
    private String processChangeTime;
    private String processCreateTime;
    private String processDeadTime;
    private String processCondition;
    private Integer submissionID;
    private Integer reportID;
    private Integer missionID;
    private Integer midcheckID;
    private Integer oralID;
}
