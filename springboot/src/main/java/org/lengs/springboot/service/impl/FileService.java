package org.lengs.springboot.service.impl;

import org.lengs.springboot.entity.FileInfo;
import org.lengs.springboot.mapper.FileMapper;
import org.lengs.springboot.service.IFileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
public class FileService implements IFileService {

    @Autowired
    FileMapper fileMapper;

    @Override
    public List<FileInfo> listFile() { return fileMapper.fileList(); }

    @Override
    public void getUpload(MultipartFile mf, MultipartFile[] mfs) {

    }

    @Override
    public List<FileInfo> listByFile(FileInfo fileInfo) {
        return fileMapper.listByFile(fileInfo);
    }
}
