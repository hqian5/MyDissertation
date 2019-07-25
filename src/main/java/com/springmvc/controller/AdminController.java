package com.springmvc.controller;

import com.springmvc.entity.Admin;
import com.springmvc.entity.Flight;
import com.springmvc.service.inter.AdminService;
import com.springmvc.service.inter.FlightService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

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
                                 @RequestParam("flight_status") String status, Model model, HttpSession session,
                                 @ModelAttribute Flight flight) throws ParseException {
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
        flight.setFlightStatus(status);

        record.setFlightNumber(flight.getFlightNumber());
        record.setDepartureTime(flight.getDepartureTime());
        record.setArrivalTime(flight.getArrivalTime());
        record.setDepartureAirport(flight.getDepartureAirport());
        record.setArrivalAirport(flight.getArrivalAirport());
        record.setSeatNumber(flight.getSeatNumber());
        record.setSeatFree(flight.getSeatFree());
        record.setPrice(flight.getPrice());
        record.setFlightStatus(flight.getFlightStatus());
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
            String status = flight.getFlightStatus();

            model.addAttribute("id", flightId);
            model.addAttribute("number", flightNumber);
            model.addAttribute("deTime", deTime);
            model.addAttribute("arTime", arTime);
            model.addAttribute("deAirport", deAirport);
            model.addAttribute("arAirport", arAirport);
            model.addAttribute("seat", seat);
            model.addAttribute("seatFree", seatFree);
            model.addAttribute("price", price);
            model.addAttribute("flightStatus", status);
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
                                @RequestParam("price_up") int price, @RequestParam("flightStatus") String status,
                                Model model, HttpSession session) throws ParseException {
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
        flight.setFlightStatus(status);

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

    @RequestMapping(value = "/generate/flights", method = RequestMethod.GET)
    public String generateFlights(){
        return "adminhome";
    }

    @RequestMapping(value = "/generate/flights", method = RequestMethod.POST)
    public String generateValidate(@RequestParam("generateDate") String geDate, @RequestParam("generateNumber") int geNumber,
                                   Model model, HttpSession session) throws ParseException {
        Date date = new Date();
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date start = dateFormat.parse(geDate);
        if (start.getTime() < date.getTime() || geNumber <= 0){
            model.addAttribute("status", 5);
        }
        else {
            Flight[] flights = new Flight[geNumber];
            ArrayList<Flight> check = new ArrayList<Flight>();
            for (int i = 0; i < geNumber; i++){
                Flight flight = new Flight();
                flight.setFlightNumber(generateLetter() + generateNumber());
                flight.setDepartureTime(generateStartTime(geDate));
                flight.setArrivalTime(generateEndTime(flight.getDepartureTime()));
                flight.setDepartureAirport(generateDeparture());
                flight.setArrivalAirport(generateArrival(flight.getDepartureAirport()));
                flight.setSeatNumber(generateSeat());
                flight.setSeatFree(generateSeatFree(flight.getSeatNumber()));
                flight.setPrice(generatePrice());
                flight.setFlightStatus("On time");
                flights[i] = flight;
            }

            for (int i = 0; i < flights.length; i++){
                check = flightService.selectByFlightNumber(flights[i]);
                if (check.size() != 0){
                    continue;
                }
                else {
                    flightService.insert(flights[i]);
                }
            }
            session.setAttribute("generate", flights);
            model.addAttribute("status", 4);
        }
        return "adminhome";
    }

    @RequestMapping(value = "/multiple/delete", method = RequestMethod.GET)
    public String multipleDelete(){
        return "manage";
    }

    @RequestMapping(value = "/multiple/delete", method = RequestMethod.POST)
    public String multipleValidate(@RequestParam("multipleId1") int idStart, @RequestParam("multipleId2") int idEnd,
                                   Model model, HttpSession session){
        if ((Integer)idStart == null || (Integer)idEnd == null){
            model.addAttribute("status", 8);
        }
        else {
            int length = (idEnd - idStart) + 1;
            int[] ids = new int[length];
            for (int i = 0; i < ids.length; i++){
                ids[i] = idStart++;
            }
            for (int i : ids){
                System.out.println(i);
            }
            for (int i : ids){
                Flight check = flightService.selectByPrimaryKey(i);
                if (check != null){
                    flightService.deleteByPrimaryKey(i);
                }
                else {
                    flightService.deleteByPrimaryKey(i+1);
                }
            }
            session.setAttribute("multipleDelete", ids);
            model.addAttribute("status", 7);
        }
        showAllFlights(model, session);
        return "manage";
    }

    public String generateLetter(){
        String letter = "";
        for (int i = 0; i < 2; i++){
            letter = letter + (char)(Math.random()*26 + 'A');
        }
        return letter;
    }

    public String generateNumber(){
        String result = "";
        Random random = new Random();
        for (int i = 0; i < 4; i++){
            result += random.nextInt(9)+1;
        }
        return result;
    }

    public String generateStartTime(String date){
        Random random = new Random();
        int hour = random.nextInt(24);
        int minute = random.nextInt(60);
        return date + 'T' + check(hour) + ':' + check(minute);
    }

    public String generateEndTime(String start){
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        Random random = new Random();
        int duration = random.nextInt(500) + 60;
        Calendar calendar = Calendar.getInstance();
        String end = new String();
        try {
            Date startDate = dateFormat.parse(start);
            calendar.setTime(startDate);
            calendar.add(Calendar.MINUTE, duration);
            Date endDate = calendar.getTime();
            end = dateFormat.format(endDate);

        } catch (ParseException e) {
            e.printStackTrace();
        }
        return end;
    }

    public String generateDeparture(){
        String[] airports = {"London", "Paris", "Berlin", "Amsterdam", "Helsinki", "Frankfurt", "Istanbul", "Munich", "Rome", "Moscow"};
        Random random = new Random();
        int i = random.nextInt(10);
        String departure = airports[i];
        return departure;
    }

    public String generateArrival(String departure){
        String[] airports = {"London", "Paris", "Berlin", "Amsterdam", "Helsinki", "Frankfurt", "Istanbul", "Munich", "Rome", "Moscow"};
        int index = deletePoint(airports, departure);
        String[] arrivalAirports = delete(index, airports);
        Random random = new Random();
        int i = random.nextInt(9);
        String arrival = arrivalAirports[i];
        return arrival;
    }

    public int generateSeat(){
        Random random = new Random();
        int seat = random.nextInt(240) + 100;
        return seat;
    }

    public int generateSeatFree(int seat){
        return seat;
    }

    public int generatePrice(){
        Random random = new Random();
        int price = random.nextInt(170) + 30;
        return price;
    }

    private String check(int num){
        String number = num + "";
        if (number.length() == 1){
            return "0" + num;
        }
        else {
            return number;
        }
    }

    private int deletePoint(String[] array, String value){
        for (int i = 0; i < array.length; i++){
            if (array[i].equals(value)){
                return i;
            }
        }
        return -1;
    }

    private String[] delete(int index, String array[]) {
        String[] arrNew = new String[array.length - 1];
        for (int i = index; i < array.length - 1; i++) {
            array[i] = array[i + 1];
        }
        System.arraycopy(array, 0, arrNew, 0, arrNew.length);
        return arrNew;
    }

    @RequestMapping(value = "/flights/simulation", method = RequestMethod.GET)
    public String goSimulation(){
        return "simulation";
    }

    @RequestMapping(value = "/select/airport", method = RequestMethod.GET)
    public String selectAirport(){
        return "simulation";
    }

    @RequestMapping(value = "/select/airport", method = RequestMethod.POST)
    public String selectValidate(@RequestParam("select_departure") String departure,
                                 Model model, HttpSession session){
        ArrayList<Flight> list = flightService.selectByDepartureAirport(departure);
        Map<String, ArrayList<Flight>> map = new HashMap<String, ArrayList<Flight>>();
        if (list.size() == 0){
            model.addAttribute("status", 0);
        }
        else {
            for (Flight f : list){
                setOffset(f);
                flightService.updateByPrimaryKeySelective(f);
            }
            session.setAttribute("simulation", list);
            model.addAttribute("status", 1);
            model.addAttribute("time", "00:00");
            model.addAttribute("airport", list.get(0).getDepartureAirport());
            map.put("simulationFlights", list);
            model.addAllAttributes(map);
        }
        return "simulation";
    }

    public void setOffset(Flight flight){
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        Date departureNew = new Date();
        Random random = new Random();

        String departTime = flight.getDepartureTime();
        int offset = (random.nextInt(340)+20) *60 * 1000;

        try {
            Date departure = format.parse(departTime);
            departureNew.setTime(departure.getTime() + offset);
            if (departureNew.getTime() - departure.getTime() <= 7200000){
                flight.setFlightStatus("On time");
            }
            else if (departureNew.getTime() - departure.getTime() > 7200000
            && departureNew.getTime() - departure.getTime() <= 18000000){
                flight.setFlightStatus("Delayed to " + format.format(departureNew));
            }
            else {
                flight.setFlightStatus("Cancelled");
            }

        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/simulating/flights", method = RequestMethod.POST)
    public String test(Model model, HttpSession session, @RequestParam("simulationTime") String time,
                       @RequestParam("simulationAirport") String airport) throws ParseException {

        DateFormat format = new SimpleDateFormat("HH:mm");
        DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        Date timeNow = format.parse(time);
        Date timeNext = new Date();
        timeNext.setTime(timeNow.getTime() + 30*60*1000);
        String end = "00:00";
        model.addAttribute("airport", airport);
        model.addAttribute("time", format.format(timeNext));

        if (format.format(timeNext).equals(end)){
            showSimulatedFlights(model, airport);
            model.addAttribute("status", 9);
            return "manage";
        }
        else {
            ArrayList<Flight> check = flightService.selectByDepartureAirport(airport);
            Map<String, ArrayList<Flight>> map = new HashMap<String, ArrayList<Flight>>();

            if (check.size() != 0){
                for (Flight f : check){
                    if (f.getFlightStatus().equals("On time")){
                        Date middle1 = format1.parse(f.getDepartureTime());
                        String middle2 = format.format(middle1);
                        Date departure = format.parse(middle2);
                        if (departure.getTime() - timeNext.getTime() <= 0){
                            f.setFlightStatus("Already taken off");
                        }
                    }
                    else if (f.getFlightStatus().equals("Cancelled")
                    || f.getFlightStatus().equals("Already taken off")){
                        f.setFlightStatus(f.getFlightStatus());
                    }
                    else {
                        String origin = f.getFlightStatus();
                        String altered = origin.substring(11);
                        Date middle1 = format1.parse(altered);
                        String middle2 = format.format(middle1);
                        Date departure = format.parse(middle2);
                        if (departure.getTime() - timeNext.getTime() <= 0){
                            f.setFlightStatus("Already taken off");
                        }
                    }
                    flightService.updateByPrimaryKeySelective(f);
                }
                map.put("simulationFlights", check);
                model.addAllAttributes(map);
                session.setAttribute("simulationOk", check);
            }
            else {
                model.addAttribute("status", 0);
            }
        }
        return "simulation";
    }

    public void showSimulatedFlights(Model model, String airport){
        ArrayList<Flight> list = flightService.selectByDepartureAirport(airport);
        Map<String, ArrayList<Flight>> map = new HashMap<String, ArrayList<Flight>>();
        map.put("flights", list);
        model.addAllAttributes(map);
    }

    @RequestMapping(value = "/stop/simulation", method = RequestMethod.GET)
    public String stopSimulation(Model model, HttpSession session){
        ArrayList<Flight> list = (ArrayList<Flight>) session.getAttribute("simulation");
        Map<String, ArrayList<Flight>> map = new HashMap<String, ArrayList<Flight>>();
        map.put("flights", list);
        model.addAllAttributes(map);
        model.addAttribute("status", 10);
        return "manage";
    }

}
