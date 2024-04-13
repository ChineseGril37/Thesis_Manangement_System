package org.lengs.springboot.entity;
import lombok.Data;

@Data
public class FileInfo {
    private Integer fileID;
    private String fileAddress;
    private Integer fileType;
    private Long fileSize;
    private String fileName;
    private Integer studentID;
    private Integer teacherID;
    private String fileCreateTime;
    private String fileChangeTime;
}
