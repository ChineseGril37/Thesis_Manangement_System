package org.lengs.springboot.entity;
import lombok.Data;

@Data
public class User {
    private Integer userId;
    private Integer changeId;
    private Integer userType;
    private String userRealName;
    private String userName;
    private String password;
    private String sexual;
    private String phoneNum;
    private String email;
    private String ancestralPlace;
    private String politicalStatus;
    private String groupID;
    private Integer userAge;
    private String accountChangeTime;
    private String accountCreateTime;
    private String userAcademy;
    private String userMajor;
    private String userClass;
}
