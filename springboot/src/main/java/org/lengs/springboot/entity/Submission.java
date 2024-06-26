package org.lengs.springboot.entity;

import lombok.Data;

@Data
public class Submission {
    private Integer submissionID;
    private Integer processID;
    private Integer groupID;
    private String submissionBase;
    private String submissionType;
    private String submissionBrief;
    private String submissionDirection;
    private String submissionLanguage;
    private Integer submissionTeacherReview;
    private Integer submissionExpertReview;
}
