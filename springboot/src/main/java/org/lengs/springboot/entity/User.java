package org.lengs.springboot.entity;
import lombok.Data;

@Data
public class User {
    private Integer userId;
    private Integer userType;
    private String userRealName;
    private String userName;
    private String password;
    private String sexual;
    private String accountCreateTime;
    private String phoneNum;
    private String email;
    private String ancestralPlace;
    private String politicalStatus;
    private String groupID;
    private Integer userAge;
    private String registerCode;
    private String accountChangeTime;
}
