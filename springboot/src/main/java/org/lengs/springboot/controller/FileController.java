package org.lengs.springboot.controller;
import java.io.File;
import java.util.List;
import java.io.IOException;

import org.lengs.springboot.entity.FileInfo;
import org.lengs.springboot.common.Result;
import org.lengs.springboot.service.IFileService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;


@CrossOrigin
@RestController
@RequestMapping("/file")
public class FileController {
    @Autowired
    IFileService fileService;

    @GetMapping("/list")
    public Result listFile() {
        List<FileInfo> fileInfo = fileService.listFile();
        if (fileInfo.isEmpty()) {
            return Result.error("未查询到数据");
        } else {
            return Result.success(fileInfo);
        }
    }

    @GetMapping("/listBy")
    public Result listByFile(FileInfo fileInfo) {
        List<FileInfo> fileInfos = fileService.listByFile(fileInfo);
        if (fileInfos.isEmpty()) {
            return Result.error("未查询到数据");
        } else {
            return Result.success(fileInfos);
        }
    }

    @PostMapping("/upload")
    public Result upload(MultipartFile[] fileList, FileInfo fileInfo) throws IOException {
        Result result = new Result();
        //拿到具体文件 file
        if (fileList != null) {
            for (MultipartFile multipartFile : fileList) {
                result = uploadFile(fileInfo, multipartFile);
            }
        } else {
            //如果获取到的文件为空
            result.setMsg("上传失败！请检查文件");
            result.setCode("-1");
        }
        return result;
    }

    private Result uploadFile(FileInfo fileInfo, MultipartFile multipartFile) throws IOException {
        String filename = multipartFile.getOriginalFilename();
        String pathname = "C:\\Users\\lengs\\IdeaProjects\\Thesis_Manangement_System\\File";
        File file_server = null;  //创建文件对象
        if (filename != null) {
            file_server = new File(pathname, String.valueOf(fileInfo.getUserID()));
        }
        if (!file_server.getAbsoluteFile().exists()) {
            //如果文件父目录不存在，就创建这样一个目录
            file_server.getAbsoluteFile().mkdir();
        }
        file_server = new File(file_server.getAbsoluteFile(), filename);
        multipartFile.transferTo(file_server);
        fileInfo.setFileSize(multipartFile.getSize());
        fileInfo.setFileName(filename);
        fileInfo.setFileAddress(file_server.getAbsolutePath());
        fileService.getUpload(fileInfo);
        return Result.success("上传成功！");
    }
}
