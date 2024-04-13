package org.lengs.springboot.mapper;

import org.lengs.springboot.entity.FileInfo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface FileMapper {
    List<FileInfo> fileList();

    List<FileInfo> listByFile(FileInfo fileInfo);

    void getUpload();

}
