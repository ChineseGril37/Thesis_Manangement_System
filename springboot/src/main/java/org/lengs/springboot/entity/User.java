package org.lengs.springboot.entity;
import lombok.Data;

@Data
public class User {
    private Integer id;
    private String name;
    private String username;
    private Integer age;
    private String sexual;
    private String phone;
    private String address;
}
