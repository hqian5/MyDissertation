package com.springmvc.dao;

import com.springmvc.entity.Admin;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.ArrayList;

import static org.junit.Assert.*;

public class AdminMapperTest {

    private ApplicationContext applicationContext;

    @Autowired
    private AdminMapper adminMapper;

    @Before
    public void setUp() throws Exception {
        applicationContext = new ClassPathXmlApplicationContext("classpath:spring/applicationContext.xml");
        adminMapper = applicationContext.getBean(AdminMapper.class);
    }

    @After
    public void tearDown() throws Exception {
    }

    @Test
    public void insert() {
        Admin admin = new Admin();
        admin.setAdminname("admin");
        admin.setPassword("abc");
        int result = adminMapper.insert(admin);
        System.out.println(result);
        assert (result == 1);
    }

    @Test
    public void selectByPrimaryKey() {
        Admin admin = new Admin();
        admin = adminMapper.selectByPrimaryKey(2);
        System.out.println(admin.getAdminname());
    }

    @Test
    public void selectSelective() {
        Admin admin = new Admin();
        admin.setAdminname("admin");
        admin.setPassword("ccc");
        ArrayList<Admin> admins = adminMapper.selectSelective(admin);
        for (Admin admin1 : admins){
            System.out.println(admin1.getAdminname() + admin1.getPassword());
        }

    }
}