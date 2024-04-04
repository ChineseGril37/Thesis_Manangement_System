package org.lengs.springboot.entity;

import lombok.Data;

@Data
public class MidCheck {
    private Integer midCheckID;
    private Integer groupID;
    private String midCheckSummary;
    private String midCheckProblem;
    private Integer midCheckTeacherReview;
    private Integer midCheckExpertReview;
}
