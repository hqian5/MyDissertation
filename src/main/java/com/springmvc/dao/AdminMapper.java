package com.springmvc.dao;

import com.springmvc.entity.Admin;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public interface AdminMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Admin record);

    int insertSelective(Admin record);

    Admin selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Admin record);

    int updateByPrimaryKey(Admin record);

    ArrayList<Admin> selectSelective(Admin record);

    ArrayList<Admin> selectByUsername(Admin record);
}