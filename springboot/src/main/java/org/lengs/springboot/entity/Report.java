package org.lengs.springboot.entity;

import lombok.Data;

@Data
public class Report {
    private Integer reportID;
    private Integer groupID;
    private String reportMeaning;
    private String reportSituation;
    private String reportAim;
    private String reportWay;
    private Integer reportTeacherReview;
    private Integer reportExpertReview;
}
