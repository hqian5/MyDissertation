package com.springmvc.controller;

import com.springmvc.entity.Admin;
import com.springmvc.service.inter.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;

@Controller
public class AdminController {

    @Autowired
    private AdminService adminService;

    @RequestMapping(value = "/admin/login", method = RequestMethod.GET)
    public String adminLogin(){
        return "admin";
    }

    @RequestMapping(value = "/admin/login", method = RequestMethod.POST)
    public String adminValidate(@RequestParam("adname") String adname,
                                @RequestParam("adpassword") String adpassword, Model model,
                                HttpSession session, @ModelAttribute Admin admin) {
        ArrayList<Admin> list;
        Admin record = new Admin();
        admin.setAdminname(adname);
        admin.setPassword(adpassword);
        record.setAdminname(admin.getAdminname());
        record.setPassword(admin.getPassword());
        list = adminService.selectByUsername(record);
        if (list.size() == 0){
            model.addAttribute("status", 1);
        }
        else {
            list = adminService.selectSelective(record);
            if (list.size() == 0){
                model.addAttribute("status", 2);
            }
            else {
                record = list.get(0);
                session.setAttribute("adminhome", record);
                model.addAttribute("status", 0);
            }
        }
        return "admin";
    }

    @RequestMapping(value = "/admin/home", method = RequestMethod.GET)
    public String adminHome(Model model, HttpSession session){
        Admin admin = (Admin) session.getAttribute("adminhome");
        if (admin != null){
            model.addAttribute("admin", admin);
        }
        return "adminhome";
    }

    @RequestMapping(value = "/admin/logout", method = RequestMethod.GET)
    public String adminLogout(HttpSession session){
        session.invalidate();
        return "admin";
    }
}
