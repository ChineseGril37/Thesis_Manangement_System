package org.lengs.springboot.entity;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;

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
