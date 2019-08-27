package com.springmvc.controller;

import com.springmvc.entity.Admin;
import com.springmvc.entity.Client;
import com.springmvc.entity.Flight;
import com.springmvc.entity.Ticket;
import com.springmvc.service.inter.AdminService;
import com.springmvc.service.inter.ClientService;
import com.springmvc.service.inter.FlightService;
import com.springmvc.service.inter.TicketService;
import com.springmvc.util.EmailSender;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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

    @Autowired
    private TicketService ticketService;

    @Autowired
    private ClientService clientService;

    @Autowired
    private JavaMailSender mailSender;

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
                flight.setDuration(generateDuration(flight.getDepartureTime(), flight.getArrivalTime()));
                flight.setDirection(generateDirection(flight.getDepartureAirport(), flight.getArrivalAirport()));
                flight.setVelocity(generateVelocity(flight));
                flight.setLat(generateLat(flight.getDepartureAirport()));
                flight.setLng(generateLng(flight.getDepartureAirport()));
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

    public int generateDuration(String start, String end){
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        int duration = 0;
        try {
            long startTime = dateFormat.parse(start).getTime();
            long endTime = dateFormat.parse(end).getTime();
            duration = (int)((endTime - startTime)/(1000*60));

        } catch (ParseException e) {
            e.printStackTrace();
        }
        return duration;
    }

    public double generateDirection(String departure, String arrival){
        double lat_a = 0, lng_a = 0, lat_b = 0, lng_b = 0;
        switch (departure)
        {
            case "London":
                lat_a = 51.5074;
                lng_a = 0.1278;
                break;
            case "Paris":
                lat_a = 48.8566;
                lng_a = 2.3522;
                break;
            case "Berlin":
                lat_a = 52.5200;
                lng_a = 13.4050;
                break;
            case "Amsterdam":
                lat_a = 52.3667;
                lng_a = 4.8945;
                break;
            case "Helsinki":
                lat_a = 60.1699;
                lng_a = 24.9384;
                break;
            case "Frankfurt":
                lat_a = 50.1109;
                lng_a = 8.6821;
                break;
            case "Istanbul":
                lat_a = 41.0082;
                lng_a = 28.9784;
                break;
            case "Munich":
                lat_a = 48.1351;
                lng_a = 11.5820;
                break;
            case "Rome":
                lat_a = 41.9028;
                lng_a = 12.4964;
                break;
            case "Moscow":
                lat_a = 55.7558;
                lng_a = 37.6173;
                break;
            default:
                System.out.println("default");
        }

        switch (arrival)
        {
            case "London":
                lat_b = 51.5074;
                lng_b = 0.1278;
                break;
            case "Paris":
                lat_b = 48.8566;
                lng_b = 2.3522;
                break;
            case "Berlin":
                lat_b = 52.5200;
                lng_b = 13.4050;
                break;
            case "Amsterdam":
                lat_b = 52.3667;
                lng_b = 4.8945;
                break;
            case "Helsinki":
                lat_b = 60.1699;
                lng_b = 24.9384;
                break;
            case "Frankfurt":
                lat_b = 50.1109;
                lng_b = 8.6821;
                break;
            case "Istanbul":
                lat_b = 41.0082;
                lng_b = 28.9784;
                break;
            case "Munich":
                lat_b = 48.1351;
                lng_b = 11.5820;
                break;
            case "Rome":
                lat_b = 41.9028;
                lng_b = 12.4964;
                break;
            case "Moscow":
                lat_b = 55.7558;
                lng_b = 37.6173;
                break;
            default:
                System.out.println("default");
        }
        double angel = getAngle1(lat_a, lng_a, lat_b, lng_b);
        return angel;
    }

    public double generateVelocity(Flight flight){
        double lat_a = 0, lng_a = 0, lat_b = 0, lng_b = 0;
        switch (flight.getDepartureAirport())
        {
            case "London":
                lat_a = 51.5074;
                lng_a = 0.1278;
                break;
            case "Paris":
                lat_a = 48.8566;
                lng_a = 2.3522;
                break;
            case "Berlin":
                lat_a = 52.5200;
                lng_a = 13.4050;
                break;
            case "Amsterdam":
                lat_a = 52.3667;
                lng_a = 4.8945;
                break;
            case "Helsinki":
                lat_a = 60.1699;
                lng_a = 24.9384;
                break;
            case "Frankfurt":
                lat_a = 50.1109;
                lng_a = 8.6821;
                break;
            case "Istanbul":
                lat_a = 41.0082;
                lng_a = 28.9784;
                break;
            case "Munich":
                lat_a = 48.1351;
                lng_a = 11.5820;
                break;
            case "Rome":
                lat_a = 41.9028;
                lng_a = 12.4964;
                break;
            case "Moscow":
                lat_a = 55.7558;
                lng_a = 37.6173;
                break;
            default:
                System.out.println("default");
        }

        switch (flight.getArrivalAirport())
        {
            case "London":
                lat_b = 51.5074;
                lng_b = 0.1278;
                break;
            case "Paris":
                lat_b = 48.8566;
                lng_b = 2.3522;
                break;
            case "Berlin":
                lat_b = 52.5200;
                lng_b = 13.4050;
                break;
            case "Amsterdam":
                lat_b = 52.3667;
                lng_b = 4.8945;
                break;
            case "Helsinki":
                lat_b = 60.1699;
                lng_b = 24.9384;
                break;
            case "Frankfurt":
                lat_b = 50.1109;
                lng_b = 8.6821;
                break;
            case "Istanbul":
                lat_b = 41.0082;
                lng_b = 28.9784;
                break;
            case "Munich":
                lat_b = 48.1351;
                lng_b = 11.5820;
                break;
            case "Rome":
                lat_b = 41.9028;
                lng_b = 12.4964;
                break;
            case "Moscow":
                lat_b = 55.7558;
                lng_b = 37.6173;
                break;
            default:
                System.out.println("default");
        }
        double distance = getDistance(lat_a, lng_a, lat_b, lng_b);
        int duration = flight.getDuration();
        double velocity = distance/duration;
        return velocity;
    }

    public double generateLat(String departure){
        double lat_a = 0;
        switch (departure)
        {
            case "London":
                lat_a = 51.5074;
                break;
            case "Paris":
                lat_a = 48.8566;
                break;
            case "Berlin":
                lat_a = 52.5200;
                break;
            case "Amsterdam":
                lat_a = 52.3667;
                break;
            case "Helsinki":
                lat_a = 60.1699;
                break;
            case "Frankfurt":
                lat_a = 50.1109;
                break;
            case "Istanbul":
                lat_a = 41.0082;
                break;
            case "Munich":
                lat_a = 48.1351;
                break;
            case "Rome":
                lat_a = 41.9028;
                break;
            case "Moscow":
                lat_a = 55.7558;
                break;
            default:
                System.out.println("default");
        }
        return lat_a;
    }

    public double generateLng(String departure){
        double lng_a = 0;
        switch (departure)
        {
            case "London":
                lng_a = 0.1278;
                break;
            case "Paris":
                lng_a = 2.3522;
                break;
            case "Berlin":
                lng_a = 13.4050;
                break;
            case "Amsterdam":
                lng_a = 4.8945;
                break;
            case "Helsinki":
                lng_a = 24.9384;
                break;
            case "Frankfurt":
                lng_a = 8.6821;
                break;
            case "Istanbul":
                lng_a = 28.9784;
                break;
            case "Munich":
                lng_a = 11.5820;
                break;
            case "Rome":
                lng_a = 12.4964;
                break;
            case "Moscow":
                lng_a = 37.6173;
                break;
            default:
                System.out.println("default");
        }
        return lng_a;
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

    private double getAngle1(double lat1, double lon1, double lat2, double lon2) {
        double result = 0.0;

        int ilat1 = (int) (0.50 + lat1 * 360000.0);
        int ilat2 = (int) (0.50 + lat2 * 360000.0);
        int ilon1 = (int) (0.50 + lon1 * 360000.0);
        int ilon2 = (int) (0.50 + lon2 * 360000.0);

        lat1 = Math.toRadians(lat1);
        lon1 = Math.toRadians(lon1);
        lat2 = Math.toRadians(lat2);
        lon2 = Math.toRadians(lon2);

        if ((ilat1 == ilat2) && (ilon1 == ilon2)) {
            return result;
        } else if (ilon1 == ilon2) {
            if (ilat1 > ilat2)
                result = 180.0;
        } else {
            double c = Math
                    .acos(Math.sin(lat2) * Math.sin(lat1) + Math.cos(lat2)
                            * Math.cos(lat1) * Math.cos((lon2 - lon1)));
            double A = Math.asin(Math.cos(lat2) * Math.sin((lon2 - lon1))
                    / Math.sin(c));
            result = Math.toDegrees(A);
            if ((ilat2 > ilat1) && (ilon2 > ilon1)) {
            } else if ((ilat2 < ilat1) && (ilon2 < ilon1)) {
                result = 180.0 - result;
            } else if ((ilat2 < ilat1) && (ilon2 > ilon1)) {
                result = 180.0 - result;
            } else if ((ilat2 > ilat1) && (ilon2 < ilon1)) {
                result += 360.0;
            }
        }
        return result;
    }

    private static double EARTH_RADIUS = 6378.137;

    private static double rad(double d) {
        return d * Math.PI / 180.0;
    }

    private double deg(double x) {
        return x * 180 / Math.PI;
    }

    private double a = 6378137;

    private double b = 6356752.3142;

    private double f = 1 / 298.2572236;

    private double getDistance(double lat1, double lng1, double lat2, double lng2) {

        double radLat1 = rad(lat1);
        double radLat2 = rad(lat2);
        double a = radLat1 - radLat2;
        double b = rad(lng1) - rad(lng2);
        double s = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(a / 2), 2)
                + Math.cos(radLat1) * Math.cos(radLat2)
                * Math.pow(Math.sin(b / 2), 2)));
        s = s * EARTH_RADIUS;
        s = Math.round(s * 10000d) / 10000d;
        s = s*1000;
        return s;
    }

    private String computeLatLng(double lon, double lat, double brng, double dist) {

        double alpha1 = rad(brng);
        double sinAlpha1 = Math.sin(alpha1);
        double cosAlpha1 = Math.cos(alpha1);

        double tanU1 = (1 - f) * Math.tan(rad(lat));
        double cosU1 = 1 / Math.sqrt((1 + tanU1 * tanU1));
        double sinU1 = tanU1 * cosU1;
        double sigma1 = Math.atan2(tanU1, cosAlpha1);
        double sinAlpha = cosU1 * sinAlpha1;
        double cosSqAlpha = 1 - sinAlpha * sinAlpha;
        double uSq = cosSqAlpha * (a * a - b * b) / (b * b);
        double A = 1 + uSq / 16384 * (4096 + uSq * (-768 + uSq * (320 - 175 * uSq)));
        double B = uSq / 1024 * (256 + uSq * (-128 + uSq * (74 - 47 * uSq)));

        double cos2SigmaM=0;
        double sinSigma=0;
        double cosSigma=0;
        double sigma = dist / (b * A), sigmaP = 2 * Math.PI;
        while (Math.abs(sigma - sigmaP) > 1e-12) {
            cos2SigmaM = Math.cos(2 * sigma1 + sigma);
            sinSigma = Math.sin(sigma);
            cosSigma = Math.cos(sigma);
            double deltaSigma = B * sinSigma * (cos2SigmaM + B / 4 * (cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM)
                    - B / 6 * cos2SigmaM * (-3 + 4 * sinSigma * sinSigma) * (-3 + 4 * cos2SigmaM * cos2SigmaM)));
            sigmaP = sigma;
            sigma = dist / (b * A) + deltaSigma;
        }

        double tmp = sinU1 * sinSigma - cosU1 * cosSigma * cosAlpha1;
        double lat2 = Math.atan2(sinU1 * cosSigma + cosU1 * sinSigma * cosAlpha1,
                (1 - f) * Math.sqrt(sinAlpha * sinAlpha + tmp * tmp));
        double lambda = Math.atan2(sinSigma * sinAlpha1, cosU1 * cosSigma - sinU1 * sinSigma * cosAlpha1);
        double C = f / 16 * cosSqAlpha * (4 + f * (4 - 3 * cosSqAlpha));
        double L = lambda - (1 - C) * f * sinAlpha
                * (sigma + C * sinSigma * (cos2SigmaM + C * cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM)));

        double revAz = Math.atan2(sinAlpha, -tmp); // final bearing

        return lon+deg(L)+","+deg(lat2);
    }

    private String computeNewPosition(Flight flight, Date current){
        double velocity;
        double direction = 0;
        double period;
        double distance = 0;
        double lat = 0;
        double lng = 0;
        Date departure;
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        if (flight.getNewDepartureTime().equals("")){
            String from1 = flight.getDepartureTime();
            try {
                departure = format.parse(from1);
                period = (current.getTime() - departure.getTime())/(1000*60);
                velocity = flight.getVelocity();
                distance = velocity * period;
//                System.out.println(period + ", " + velocity + ", " + distance);
                lat = flight.getLat();
                lng = flight.getLng();
//                System.out.println("lat: " + lat + ", lng: " + lng);
                direction = flight.getDirection();
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        else {
            String from2 = flight.getNewDepartureTime();
            try {
                departure = format.parse(from2);
                period = (current.getTime() - departure.getTime())/(1000*60);
                velocity = flight.getVelocity();
                distance = velocity * period;
//                System.out.println(period + ", " + velocity + ", " + distance);
                lat = flight.getLat();
                lng = flight.getLng();
//                System.out.println("lat: " + lat + ", lng: " + lng);
                direction = flight.getDirection();
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        String position = computeLatLng(lng, lat, direction, distance);
//        System.out.println(position);
        return position;
    }

    private String computeNewPositionFlying(Flight flight, Date current, Date previous){
        double period = (current.getTime() - previous.getTime())/(1000*60);
        double velocity = flight.getVelocity();
        double distance = velocity * period;
//        System.out.println(period + ", " + velocity + ", " + distance);
        double lat = flight.getLat();
        double lng = flight.getLng();
//                System.out.println("lat: " + lat + ", lng: " + lng);
        double direction = flight.getDirection();
        String position = computeLatLng(lng, lat, direction, distance);
//        System.out.println(position);
        return position;
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
        ArrayList<Flight> check = new ArrayList<Flight>();
        Map<String, ArrayList<Flight>> map = new HashMap<String, ArrayList<Flight>>();
        if (list.size() == 0){
            model.addAttribute("status", 0);
        }
        else {
            for (Flight f : list){
                setOffset(f);
                flightService.updateByPrimaryKeySelective(f);
                check.add(f);
            }
            for (Flight f : check){
                if (f.getFlightStatus().equals("On time")){
                    continue;
                }
                else {
                    ArrayList<Ticket> send = ticketService.selectByFlightId(f.getFlightid());
                    String flightNumber = f.getFlightNumber();
                    String departureTime = f.getDepartureAirport();
                    String arrivalTime = f.getArrivalAirport();
                    String flightStatus = f.getFlightStatus();
                    for (Ticket t : send){
                        Client client = clientService.selectByPrimaryKey(t.getUserid());
                        String address = client.getEmail();
                        String username = client.getUsername();
                        EmailSender emailSender = new EmailSender(address, username, flightNumber, departureTime, arrivalTime, flightStatus, mailSender);
                        emailSender.sendEmail();
                    }
                }
            }
            String date = check.get(0).getDepartureTime().substring(0, 11);
            session.setAttribute("simulation", list);
            model.addAttribute("status", 1);
            model.addAttribute("time", date + "00:00");
            model.addAttribute("airport", list.get(0).getDepartureAirport());
            map.put("simulationFlights", list);
            model.addAllAttributes(map);
        }
        return "simulation";
    }

    public void setOffset(Flight flight){
        try {
            DateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date departureNew = new Date();
            Random random = new Random();

            int offset = (random.nextInt(340)+20) *60 * 1000;
            Date departure = format.parse(flight.getDepartureTime());
            departureNew.setTime(departure.getTime() + offset);

            if (departureNew.getTime() - departure.getTime() <= 7200000){
                flight.setFlightStatus("On time");
                flight.setNewDepartureTime(format.format(departure));
                flight.setNewArrivalTime("");
            }
            else if (departureNew.getTime() - departure.getTime() > 7200000
            && departureNew.getTime() - departure.getTime() <= 18000000){

                long duration = flight.getDuration();
                Date arrivalNew = new Date();
                arrivalNew.setTime(departureNew.getTime() + duration*60*1000);
                flight.setFlightStatus("Delayed to " + format.format(departureNew));
                flight.setNewDepartureTime(format.format(departureNew));
                flight.setNewArrivalTime(format.format(arrivalNew));

            }
            else {
                Date cancel = new Date();
                cancel.setTime(departureNew.getTime() + 2880*1000*60);
                flight.setFlightStatus("Cancelled");
                flight.setNewDepartureTime(format.format(cancel));
                flight.setNewArrivalTime("");
            }

        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/simulating/flights", method = RequestMethod.POST)
    public String test(Model model, HttpSession session, @RequestParam("simulationTime") String time,
                       @RequestParam("simulationAirport") String airport) throws ParseException {

        ArrayList<Flight> check = flightService.selectByDepartureAirport(airport);
        Map<String, ArrayList<Flight>> map = new HashMap<String, ArrayList<Flight>>();
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        Date timeNow = format1.parse(time);
        Date timeNext = new Date();
        timeNext.setTime(timeNow.getTime() + 30*60*1000);
        String date = check.get(0).getDepartureTime().substring(0,10);
        Date date1 = format.parse(date);
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date1);
        calendar.add(calendar.DATE, 1);
        date1 = calendar.getTime();
        String end = format.format(date1) + "T12:00";
        model.addAttribute("airport", airport);
        model.addAttribute("time", format1.format(timeNext));

        if (format1.format(timeNext).equals(end)){
            showSimulatedFlights(model, airport);
            model.addAttribute("status", 9);
            return "manage";
        }
        else {

            if (check.size() != 0){
                for (Flight f : check){
                    if (f.getFlightStatus().equals("On time")){
                        Date departure = format1.parse(f.getDepartureTime());
                        if (departure.getTime() - timeNext.getTime() <= 0){
                            f.setFlightStatus("flying");
                            String position = computeNewPosition(f, timeNext);
                            String[] positions = position.split(",");
                            double lat = Double.parseDouble(positions[1]);
                            double lng = Double.parseDouble(positions[0]);
                            f.setLat(lat);
                            f.setLng(lng);
//                            System.out.println(f.getFlightNumber() + ", " + lat + ", " + lng);
                        }
                    }
                    else if (f.getFlightStatus().equals("Cancelled")){
                        f.setFlightStatus(f.getFlightStatus());
                    }
                    else if (f.getFlightStatus().equals("flying")){
                        if (f.getNewArrivalTime().equals("")){
                            Date arrival = format1.parse(f.getArrivalTime());
                            if (arrival.getTime() - timeNext.getTime() <= 0){
                                f.setFlightStatus("Arrived");
                                double lat = generateLat(f.getArrivalAirport());
                                double lng = generateLng(f.getArrivalAirport());
                                f.setLat(lat);
                                f.setLng(lng);
                            }
                            else {
                                String position = computeNewPositionFlying(f, timeNext, timeNow);
                                String[] positions = position.split(",");
                                double lat = Double.parseDouble(positions[1]);
                                double lng = Double.parseDouble(positions[0]);
                                f.setLat(lat);
                                f.setLng(lng);
//                                System.out.println(f.getFlightNumber() + ", " + lat + ", " + lng);
                            }
                        } else {
                            Date arrival = format1.parse(f.getNewArrivalTime());
                            if (arrival.getTime() - timeNext.getTime() <= 0){
                                f.setFlightStatus("Arrived");
                                double lat = generateLat(f.getArrivalAirport());
                                double lng = generateLng(f.getArrivalAirport());
                                f.setLat(lat);
                                f.setLng(lng);
                            }
                            else {
                                String position = computeNewPositionFlying(f, timeNext, timeNow);
                                String[] positions = position.split(",");
                                double lat = Double.parseDouble(positions[1]);
                                double lng = Double.parseDouble(positions[0]);
                                f.setLat(lat);
                                f.setLng(lng);
//                                System.out.println(f.getFlightNumber() + ", " + lat + ", " + lng);
                            }
                        }
                    }
                    else if (f.getFlightStatus().equals("Arrived")){
                        continue;
                    }
                    else {
                        Date departure = format1.parse(f.getNewDepartureTime());
                        if (departure.getTime() - timeNext.getTime() <= 0){
                            f.setFlightStatus("flying");
                            String position = computeNewPosition(f, timeNext);
                            String[] positions = position.split(",");
                            double lat = Double.parseDouble(positions[1]);
                            double lng = Double.parseDouble(positions[0]);
                            f.setLat(lat);
                            f.setLng(lng);
//                            System.out.println(f.getFlightNumber() + ", " + lat + ", " + lng);
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
        ArrayList<Flight> list = (ArrayList<Flight>) session.getAttribute("simulationOk");
        Map<String, ArrayList<Flight>> map = new HashMap<String, ArrayList<Flight>>();
        map.put("flights", list);
        model.addAllAttributes(map);
        model.addAttribute("status", 10);
        return "manage";
    }

}
