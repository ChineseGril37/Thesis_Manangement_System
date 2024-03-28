package org.lengs.springboot.controller;
import java.io.File;
import java.io.IOException;
import java.util.List;

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
    public Result listFile(){
        List<FileInfo> fileInfo = fileService.listFile();
        return Result.success(fileInfo);
    }
    @PostMapping("/upload")
    public Result saveVue(String title,@RequestParam("file") MultipartFile file) throws IOException {
        //拿到具体文件 file
        return Result.success();
    }
}
