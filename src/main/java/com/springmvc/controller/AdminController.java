package com.springmvc.controller;

import com.springmvc.entity.Admin;
import com.springmvc.entity.Flight;
import com.springmvc.service.inter.AdminService;
import com.springmvc.service.inter.FlightService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

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
                                 Model model, HttpSession session, @ModelAttribute Flight flight) throws ParseException {
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
        record.setFlightNumber(flight.getFlightNumber());
        record.setDepartureTime(flight.getDepartureTime());
        record.setArrivalTime(flight.getArrivalTime());
        record.setDepartureAirport(flight.getDepartureAirport());
        record.setArrivalAirport(flight.getArrivalAirport());
        record.setSeatNumber(flight.getSeatNumber());
        record.setSeatFree(flight.getSeatFree());
        record.setPrice(flight.getPrice());
        list = flightService.selectByFlightNumber(record);

        DateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        Date dForm = format.parse(dTime);
        Date aForm = format.parse(aTime);
        Date date = new Date();
        if (((dForm.getTime() - date.getTime() <= 0)||(aForm.getTime() - date.getTime()) <= 0)
                || ((aForm.getTime() - dForm.getTime()) <= 0) || (dAirport.equals(aAirport))
                || (seatFree - seatNo > 0) || (seatNo <= 0 || seatFree < 0 || price <= 0)){
            model.addAttribute("status",3);
        }
        else if (list.size() != 0){
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
        System.out.println("input: " + model);
        return "adminhome";
    }

    public void showAllFlights(Model model, HttpSession session){
        ArrayList<Flight> list;
        Map<String, ArrayList<Flight>> map = new HashMap<String, ArrayList<Flight>>();
        list = flightService.selectAllFlights();
        session.setAttribute("manageOK", list);
        model.addAttribute("manage", 0);
        map.put("flights", list);
        model.addAllAttributes(map);
    }

    @RequestMapping(value = "/manage/flights", method = RequestMethod.GET)
    public String manageFlight(Model model, HttpSession session){
        showAllFlights(model, session);
        return "manage";
    }

    @RequestMapping(value = "/delete/flight", method = RequestMethod.GET)
    public String deleteFlight(){
        return "manage";
    }

    @RequestMapping(value = "/delete/flight", method = RequestMethod.POST)
    public String deleteValidate(@RequestParam("flightId") int id, Model model, HttpSession session){
        int record = flightService.deleteByPrimaryKey(id);
        if (record == 1){
            session.setAttribute("delete", record);
            model.addAttribute("status", 0);
        }
        else {
            model.addAttribute("status", 1);
        }
        showAllFlights(model, session);
        return "manage";
    }

    @RequestMapping(value = "/update/confirm", method = RequestMethod.GET)
    public String updateFlight(){
        return "manage";
    }

    @RequestMapping(value = "/update/confirm", method = RequestMethod.POST)
    public String updateValidate(@RequestParam("flightId_up") int id, Model model, HttpSession session){
        if (id != 0){
            session.setAttribute("update", id);
            model.addAttribute("status", 2);
            Flight flight = flightService.selectByPrimaryKey(id);
            int flightId = flight.getFlightid();
            String flightNumber = flight.getFlightNumber();
            String deTime = flight.getDepartureTime();
            String arTime = flight.getArrivalTime();
            String deAirport = flight.getDepartureAirport();
            String arAirport = flight.getArrivalAirport();
            int seat = flight.getSeatNumber();
            int seatFree = flight.getSeatFree();
            int price = flight.getPrice();
            model.addAttribute("id", flightId);
            model.addAttribute("number", flightNumber);
            model.addAttribute("deTime", deTime);
            model.addAttribute("arTime", arTime);
            model.addAttribute("deAirport", deAirport);
            model.addAttribute("arAirport", arAirport);
            model.addAttribute("seat", seat);
            model.addAttribute("seatFree", seatFree);
            model.addAttribute("price", price);
        }
        else {
            model.addAttribute("status", 3);
        }
        showAllFlights(model, session);
        return "manage";
    }

    @RequestMapping(value = "/update/flight", method = RequestMethod.GET)
    public String update(){
        return "manage";
    }

    @RequestMapping(value = "/update/flight", method = RequestMethod.POST)
    public String updateConfirm(@RequestParam("update_id") int id, @RequestParam("flight_number") String flightNo,
                                @RequestParam("departure_time") String dTime, @RequestParam("arrival_time") String aTime,
                                @RequestParam("departure_airport") String dAirport, @RequestParam("arrival_airport") String aAirport,
                                @RequestParam("seat_number") int seatNo, @RequestParam("seat_free") int seatFree,
                                @RequestParam("price_up") int price, Model model, HttpSession session) throws ParseException {
        Flight flight = new Flight();
        flight.setFlightid(id);
        flight.setFlightNumber(flightNo);
        flight.setDepartureTime(dTime);
        flight.setArrivalTime(aTime);
        flight.setDepartureAirport(dAirport);
        flight.setArrivalAirport(aAirport);
        flight.setSeatNumber(seatNo);
        flight.setSeatFree(seatFree);
        flight.setPrice(price);

        DateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        Date dForm = format.parse(dTime);
        Date aForm = format.parse(aTime);
        Date date = new Date();

        if (((dForm.getTime() - date.getTime() <= 0)||(aForm.getTime() - date.getTime()) <= 0)
        || ((aForm.getTime() - dForm.getTime()) <= 0) || (dAirport.equals(aAirport))
        || (seatFree - seatNo > 0) || (seatNo <= 0 || seatFree < 0 || price <= 0)){
            model.addAttribute("status",6);
        }
        else {
            if (flightService.updateByPrimaryKeySelective(flight) == 1){
                session.setAttribute("updateOK", flight);
                model.addAttribute("status", 4);
            }
            else {
                model.addAttribute("status", 5);
            }
        }
        showAllFlights(model, session);
        return "manage";
    }

    @RequestMapping(value = "/back/adminhome", method = RequestMethod.GET)
    public String backAdminHome(){
        return "adminhome";
    }

}
