package org.lengs.springboot.controller.request;

import lombok.Data;

@Data
public class LoginRequest  extends BaseRequest{
    String userName;
    String password;
}
