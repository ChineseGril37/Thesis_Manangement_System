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
    public Result getUpload(@RequestPart("one") MultipartFile mf,
                            @RequestPart("any") MultipartFile[] mfs) throws IOException {
        fileService.getUpload(mf,mfs);
        System.out.println("单文件上传信息为:"+mf.getOriginalFilename());
        System.out.println("多文件个数:"+mfs.length);
        for (MultipartFile m:mfs){
            System.out.println("多文件信息:文件名称:"+m.getOriginalFilename()+",文件大小:"+m.getSize()/1000+"kb");
        }
        /*将文件上传到指定文件夹*/
        if (!mf.isEmpty()){
            String fileName=mf.getOriginalFilename();
            //文件上传
            mf.transferTo(new File("E:\\"+fileName));
        }
        if (mfs.length > 0){
            for (MultipartFile m: mfs) {
                m.transferTo(new File("E:\\"+m.getOriginalFilename()));
            }
        }
        return Result.success();
    }
}
