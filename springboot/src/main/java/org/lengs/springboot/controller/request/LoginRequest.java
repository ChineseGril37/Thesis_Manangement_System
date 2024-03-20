package org.lengs.springboot.controller.request;

import lombok.Data;

@Data
public class LoginRequest {
    String userName;
    String password;
}
