package com.springmvc.service.inter;

import com.springmvc.entity.Admin;

import java.util.ArrayList;

public interface AdminService {
    int insert(Admin record);

    ArrayList<Admin> selectSelective(Admin record);

    ArrayList<Admin> selectByUsername(Admin record);
}
