package com.springmvc.controller;

import com.springmvc.entity.Client;
import com.springmvc.entity.Flight;
import com.springmvc.service.inter.ClientService;
import com.springmvc.service.inter.FlightService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;

@Controller
public class UserController {

    @Autowired
    private ClientService clientService;

    @Autowired
    private FlightService flightService;

    @RequestMapping(value = "/index/admin", method = RequestMethod.GET)
    public String goAdmin() {
        return "admin";
    }

    @RequestMapping(value = "/index/login", method = RequestMethod.GET)
    public String goLogin(){ return "login"; }

    @RequestMapping(value = "/login/register", method = RequestMethod.GET)
    public String goRegister() {
        return "register";
    }

    @RequestMapping(value = "/back/login", method = RequestMethod.GET)
    public String backLogin(){ return "login"; }

    @RequestMapping(value = "/back/index", method = RequestMethod.GET)
    public ModelAndView goIndex(){
        ModelAndView modelAndView = new ModelAndView("redirect:/index.jsp");
        return modelAndView;
    }

    @RequestMapping(value = "/user/login", method = RequestMethod.GET)
    public String userLogin() {
        return "login";
    }

    @RequestMapping(value = "/user/login", method = RequestMethod.POST)
    public String userValidate(@RequestParam("username") String username,
                               @RequestParam("userpassword") String userpassword, Model model,
                               HttpSession httpSession, @ModelAttribute Client client){
        ArrayList<Client> list;
        Client record = new Client();
        client.setUsername(username);
        client.setPassword(userpassword);
        record.setUsername(client.getUsername());
        record.setPassword(client.getPassword());
        list = clientService.selectByUsername(record);
        if (list.size() == 0){
            model.addAttribute("status", 1);
        }
        else {
            list = clientService.selectSelective(record);
            if (list.size() == 0){
                model.addAttribute("status", 2);
            }
            else {
                record = list.get(0);
                httpSession.setAttribute("userhome", record);
                model.addAttribute("status", 0);
            }

        }
        return "login";
    }

    @RequestMapping(value = "/user/register", method = RequestMethod.GET)
    public String userRegister(){
        return "register";
    }

    @RequestMapping(value = "/user/register", method = RequestMethod.POST)
    public String registerValidate(@RequestParam("uname") String uname, @RequestParam("upassword") String upassword,
                                   @RequestParam("realname") String realname, @RequestParam("passport") String passport,
                                   @RequestParam("email") String email, @RequestParam("phone") String phone,
                                   @RequestParam("preference") String preference, Model model,
                                   HttpSession session, @ModelAttribute Client client){
        ArrayList<Client> list;
        Client record = new Client();
        client.setUsername(uname);
        client.setPassword(upassword);
        client.setRealname(realname);
        client.setPassport(passport);
        client.setEmail(email);
        client.setPhone(phone);
        client.setPreference(preference);
        record.setUsername(client.getUsername());
        record.setPassword(client.getPassword());
        record.setRealname(client.getRealname());
        record.setPassport(client.getPassport());
        record.setEmail(client.getEmail());
        record.setPhone(client.getPhone());
        record.setPreference(client.getPreference());
        list = clientService.selectByUsername(record);
        if (list.size() != 0){
            model.addAttribute("status", 1);
        }
        else {
            if (clientService.insert(record) == 1){
                session.setAttribute("register", record);
                model.addAttribute("status", 0);
            }
            else {
                model.addAttribute("status", 2);
            }
        }
        return "register";
    }

    @RequestMapping(value = "/user/home", method = RequestMethod.GET)
    public String userHome(HttpSession session, Model model){
        Client client = (Client) session.getAttribute("userhome");
        if (client != null){
            model.addAttribute("user", client);
        }
        return "userhome";
    }

    @RequestMapping(value = "/register_ok/login", method = RequestMethod.GET)
    public String registerSuccess(){
        return "login";
    }

    @RequestMapping(value = "/user/logout", method = RequestMethod.GET)
    public String userLogout(HttpSession session){
        session.invalidate();
        return "login";
    }

    @RequestMapping(value = "/search/flight", method = RequestMethod.GET)
    public String searchFlight(){
        return "userhome";
    }

    @RequestMapping(value = "/search/flight", method = RequestMethod.POST)
    public String getFlight(@RequestParam("flight_no") String flight_no, Model model, HttpSession session) {
        ArrayList<Flight> flight;
        flight = flightService.selectFlight(flight_no);
        if (flight.size() == 0){
            model.addAttribute("status", 1);
        }
        else {
            session.setAttribute("flight", flight.get(0));
            model.addAttribute("status", 0);
            model.addAttribute("searchResult", flight.get(0));
        }
        return "userhome";
    }

    @RequestMapping(value = "/back/userhome", method = RequestMethod.GET)
    public String backUser(){
        return "userhome";
    }
}
