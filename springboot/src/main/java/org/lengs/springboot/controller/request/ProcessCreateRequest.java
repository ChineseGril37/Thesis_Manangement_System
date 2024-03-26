package org.lengs.springboot.controller.request;
import lombok.Data;

@Data
public class ProcessCreateRequest extends ProcessRequest{
    private String processName;
    private Integer processGroup;
    private String processChangeTime;
    private String processCreateTime;
    private String processDeadTime;
    private String processCondition;
    private Integer processSubmission;
}
