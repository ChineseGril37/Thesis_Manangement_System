package org.lengs.springboot.controller.request;
import lombok.Data;
@Data
public class ProcessRequest {
    private Integer userID;
    private String userRealName;
    private Integer groupID;
}
