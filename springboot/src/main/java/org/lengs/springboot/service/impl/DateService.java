package org.lengs.springboot.service.impl;

import org.lengs.springboot.entity.Date;
import org.lengs.springboot.mapper.DateMapper;
import org.lengs.springboot.service.IDateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DateService implements IDateService {
    @Autowired
    DateMapper dateMapper;

    @Override
    public Object listDate(){
        return dateMapper.listDate();
    }

    @Override
    public void update(Date date) {
        dateMapper.update(date);
    }
}
