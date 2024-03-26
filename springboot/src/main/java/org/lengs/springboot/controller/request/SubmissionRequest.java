package org.lengs.springboot.controller.request;

import lombok.Data;

@Data
public class SubmissionRequest extends ProcessRequest{
    private Integer submissionID;
    private String submissionBase;
    private String submissionType;
    private String submissionBrief;
    private String submissionDirection;
    private String submissionLanguage;
    private Integer submissionTeacherReview;
    private Integer submissionExpertReview;
}
