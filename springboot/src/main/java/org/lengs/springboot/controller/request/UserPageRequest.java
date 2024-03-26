package org.lengs.springboot.controller.request;
import lombok.Data;
@Data
public class UserPageRequest extends BaseRequest{
    private String userId;
    private String userRealName;
    private Integer userType;
    private Integer groupID;
}
