package org.lengs.springboot.entity;

import lombok.Data;

@Data
public class Mission {
    private Integer missionID;
    private Integer groupID;
    private String missionGoal;
    private String missionContent;
    private String missionPlan;
    private String missionReferences;
    private Boolean missionTeacherReview;
    private Boolean missionExpertReview;
}
