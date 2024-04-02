package org.lengs.springboot.controller.request;
import lombok.Data;
@Data
public class ProcessRequest extends BaseRequest{
    private Integer userID;
    private Integer groupID;
    private String userRealName;
}
