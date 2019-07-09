package com.springmvc.controller;

import com.springmvc.entity.Admin;
import com.springmvc.entity.Flight;
import com.springmvc.service.inter.AdminService;
import com.springmvc.service.inter.FlightService;
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

    @Autowired
    private FlightService flightService;

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

    @RequestMapping(value = "/input/flight", method = RequestMethod.GET)
    public String inputFlight(){
        return "adminhome";
    }

    @RequestMapping(value = "/input/flight", method = RequestMethod.POST)
    public String flightValidate(@RequestParam("flight_number") String flightNo, @RequestParam("departure_time") String dTime,
                                 @RequestParam("arrival_time") String aTime, @RequestParam("departure_airport") String dAirport,
                                 @RequestParam("arrival_airport") String aAirport, @RequestParam("seat_number") int seatNo,
                                 @RequestParam("seat_free") int seatFree, @RequestParam("price") int price,
                                 Model model, HttpSession session, Flight flight){
        ArrayList<Flight> list;
        Flight record = new Flight();
        flight.setFlightNumber(flightNo);
        flight.setDepartureTime(dTime);
        flight.setArrivalTime(aTime);
        flight.setDepartureAirport(dAirport);
        flight.setArrivalAirport(aAirport);
        flight.setSeatNumber(seatNo);
        flight.setSeatFree(seatFree);
        flight.setPrice(price);
        System.out.println("flight: " + flight.getFlightNumber());
        record.setFlightNumber(flight.getFlightNumber());
        record.setDepartureTime(flight.getDepartureTime());
        record.setArrivalTime(flight.getArrivalTime());
        record.setDepartureAirport(flight.getDepartureAirport());
        record.setArrivalAirport(flight.getArrivalAirport());
        record.setSeatNumber(flight.getSeatNumber());
        record.setSeatFree(flight.getSeatFree());
        record.setPrice(flight.getPrice());
        System.out.println("record:" + record.getFlightNumber());
        list = flightService.selectByFlightNumber(record);
        if (list.size() != 0){
            model.addAttribute("status", 1);
        }
        else {
            if (flightService.insert(record) == 1){
                session.setAttribute("input", record);
                model.addAttribute("status", 0);
            }
            else {
                model.addAttribute("status", 2);
            }
        }
        return "adminhome";
    }
}
