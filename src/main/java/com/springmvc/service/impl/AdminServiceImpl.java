package com.springmvc.service.impl;

import com.springmvc.dao.AdminMapper;
import com.springmvc.entity.Admin;
import com.springmvc.service.inter.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper mapper;

    public int insert(Admin record){return mapper.insert(record); }

    public ArrayList<Admin> selectSelective(Admin record) {
        return mapper.selectSelective(record);
    }

    public ArrayList<Admin> selectByUsername(Admin record) {
        return mapper.selectByUsername(record);
    }


}
