package org.lengs.springboot.controller.request;
import lombok.Data;
@Data
public class UserExistRequest extends BaseRequest{
    private String userId;
}
