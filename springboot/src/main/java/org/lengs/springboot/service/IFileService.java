package org.lengs.springboot.service;

import org.lengs.springboot.entity.FileInfo;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface IFileService {
    List<FileInfo> listFile();

    void getUpload(MultipartFile mf, MultipartFile[] mfs);
}
