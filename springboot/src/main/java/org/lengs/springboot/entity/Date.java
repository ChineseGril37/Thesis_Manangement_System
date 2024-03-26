package org.lengs.springboot.entity;

import lombok.Data;

@Data
public class Date {
    private String submissionBegin;
    private String submissionEnd;
    private String reportDeadline;
    private String missionDeadline;
    private String midCheckDeadline;
    private String draftThesisDeadline;
    private String finalizeThesisDeadline;
    private String finalThesisDeadline;
    private Integer dateID;
}