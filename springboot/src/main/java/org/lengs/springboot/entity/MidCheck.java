package org.lengs.springboot.entity;

import lombok.Data;

@Data
public class MidCheck {
    private Integer midcheckID;
    private Integer groupID;
    private String midcheckSummary;
    private String midcheckProblem;
    private Boolean midcheckTeacherReview;
    private Boolean midcheckExpertReview;
}
