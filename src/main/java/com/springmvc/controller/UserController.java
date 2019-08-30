package com.springmvc.controller;

import com.springmvc.entity.Client;
import com.springmvc.entity.Flight;
import com.springmvc.entity.Ticket;
import com.springmvc.service.inter.ClientService;
import com.springmvc.service.inter.FlightService;
import com.springmvc.service.inter.TicketService;
import com.springmvc.service.inter.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
public class UserController {

    @Autowired
    private ClientService clientService;

    @Autowired
    private FlightService flightService;

    @Autowired
    private TicketService ticketService;

    @Autowired
    private TransactionService transactionService;

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

    @RequestMapping(value = "/user/search", method = RequestMethod.GET)
    public String searchFlight(){
        return "userhome";
    }

    @RequestMapping(value = "/user/search", method = RequestMethod.POST)
    public String getFlight(@RequestParam("flight_no") String flight_no, Model model, HttpSession session) {
        ArrayList<Flight> flight;
        flight = flightService.selectFlight(flight_no);
        Client client = (Client) session.getAttribute("userhome");
        if (flight.size() == 0){
            model.addAttribute("status", 1);
            model.addAttribute("user", client);
        }
        else {
            session.setAttribute("flight", flight.get(0));
            model.addAttribute("status", 0);
            model.addAttribute("searchResult", flight.get(0));
            model.addAttribute("user", client);
        }
        return "userhome";
    }

    @RequestMapping(value = "/search/flight", method = RequestMethod.GET)
    public ModelAndView userSearch(){
        ModelAndView modelAndView = new ModelAndView("../../index");
        return modelAndView;
    }

    @RequestMapping(value = "/search/flight", method = RequestMethod.POST)
    public ModelAndView userSearchValidate(@RequestParam("flight_no") String flight_no, HttpSession session) {
        ArrayList<Flight> flight;
        flight = flightService.selectFlight(flight_no);
        Client client = (Client) session.getAttribute("userhome");
        ModelAndView modelAndView = new ModelAndView("../../index");
        if (flight.size() == 0){
            modelAndView.addObject("status", 1);
            modelAndView.addObject("user", client);
        }
        else {
            session.setAttribute("flight", flight.get(0));
            modelAndView.addObject("status", 0);
            modelAndView.addObject("searchResult", flight.get(0));
            modelAndView.addObject("user", client);
        }
        return modelAndView;
    }

//    @RequestMapping(value = "/back/userhome", method = RequestMethod.GET)
//    public String backUser(Model model, HttpSession session){
//        Client client = (Client) session.getAttribute("userhome");
//        if (client != null){
//            model.addAttribute("user", client);
//        }
//        return "userhome";
//    }

    @RequestMapping(value = "/buy/tickets", method = RequestMethod.GET)
    public String searchTickets(){
        return "userhome";
    }

    @RequestMapping(value = "/buy/tickets", method = RequestMethod.POST)
    public String searchValidate(@RequestParam("ticketDate") String date, @RequestParam("ticketFrom") String departure,
                              @RequestParam("ticketTo") String arrival, Model model, HttpSession session){
        Client client = (Client) session.getAttribute("userhome");
        Flight flight = new Flight();
        flight.setDepartureTime(date);
        flight.setDepartureAirport(departure);
        flight.setArrivalAirport(arrival);
        ArrayList<Flight> list = flightService.selectByDateAndAirports(flight);
        if (list.size() == 0){
            model.addAttribute("status", 2);
            model.addAttribute("user", client);
        }
        else {
            Map<String, ArrayList<Flight>> map = new HashMap<String, ArrayList<Flight>>();
            map.put("tickets", list);
            model.addAllAttributes(map);
            session.setAttribute("getTickets", list);
            model.addAttribute("status", 3);
            model.addAttribute("user", client);
        }
        return "userhome";
    }

    @RequestMapping(value = "/buy/confirm", method = RequestMethod.GET)
    public String buyConfirm(){
        return "userhome";
    }

    @RequestMapping(value = "/buy/confirm", method = RequestMethod.POST)
    public String buyValidate(@RequestParam("userId") int userId, @RequestParam("confirmId")int flightId,
                              Model model, HttpSession session){
        Client client = (Client) session.getAttribute("userhome");
        Ticket ticket = new Ticket();
        ticket.setFlightid(flightId);
        ticket.setUserid(userId);
        if (ticketService.insert(ticket) == 1){
            session.setAttribute("ticket", ticket);
            model.addAttribute("status", 4);
            model.addAttribute("user", client);
        }
        else {
            model.addAttribute("status", 5);
            model.addAttribute("user", client);
        }
        return "userhome";
    }

    @RequestMapping(value = "/user/manage", method = RequestMethod.GET)
    public String userManage(){
        return "usermanage";
    }

    @RequestMapping(value = "/user/manage", method = RequestMethod.POST)
    public String manageValidate(@RequestParam("manageId") int userId, Model model, HttpSession session){
        Client client = (Client) session.getAttribute("userhome");
        ArrayList<Ticket> list = ticketService.selectTicketsByUserId(userId);
        ArrayList<Flight> trips = new ArrayList<Flight>();
        for (Ticket t : list){
            Flight flight = flightService.selectByPrimaryKey(t.getFlightid());
            trips.add(flight);
        }
        if (trips.size() != 0){
            Map<String, ArrayList<Flight>> map = new HashMap<String, ArrayList<Flight>>();
            map.put("trips", trips);
            model.addAllAttributes(map);
            model.addAttribute("status", 0);
            session.setAttribute("travels", map);
            model.addAttribute("user", client);
        }
        else {
            model.addAttribute("status", 1);
            model.addAttribute("user", client);
        }
        return "usermanage";
    }

    @RequestMapping(value = "/optional/confirm", method = RequestMethod.POST)
    public String optionalConfirm(@RequestParam("date") String date, @RequestParam("departure") String departure,
                                  @RequestParam("arrival") String arrival, @RequestParam("flightId") int flightId,
                                  Model model, HttpSession session) throws ParseException {
        Client client = (Client) session.getAttribute("userhome");
        Map<String, ArrayList<Flight>> trips = (Map<String, ArrayList<Flight>>) session.getAttribute("travels");
        Flight flight = new Flight();
        flight.setDepartureTime(date.substring(0, 10));
        flight.setDepartureAirport(departure);
        flight.setArrivalAirport(arrival);
        ArrayList<Flight> list = flightService.selectByDateAndAirports(flight);
        ArrayList<Flight> check = new ArrayList<Flight>();
        if (list.size() != 0){
            for (Flight f : list){
                DateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                String cancel = date;
                String option = f.getDepartureTime();
                Date cancel1 = format.parse(cancel);
                Date option1 = format.parse(option);
                if (f.getFlightid() == flightId || f.getFlightStatus().equals("Cancelled")
                || cancel1.getTime() >= option1.getTime()){
                    continue;
                }
                else {
                    check.add(f);
                }
            }
            Map<String, ArrayList<Flight>> map = new HashMap<String, ArrayList<Flight>>();
            map.put("options", check);
            model.addAllAttributes(map);
            session.setAttribute("optionFlights", check);
            model.addAttribute("status", 2);
            model.addAttribute("user", client);
            model.addAllAttributes(trips);
        }
        else {
            model.addAttribute("status", 3);
            model.addAttribute("user", client);
            model.addAllAttributes(trips);
        }
        return "usermanage";
    }

    @RequestMapping(value = "/buy/options", method = RequestMethod.GET)
    public String buyOptions(){
        return "usermanage";
    }

    @RequestMapping(value = "/buy/options", method = RequestMethod.POST)
    public String optionValidate(@RequestParam("userId") int userId, @RequestParam("confirmId") int flightId,
                                 Model model, HttpSession session){
        Client client = (Client) session.getAttribute("userhome");
        Ticket ticket = new Ticket();
        ticket.setUserid(userId);
        ticket.setFlightid(flightId);
        ArrayList<Ticket> check = new ArrayList<Ticket>();
        ArrayList<Flight> list = new ArrayList<Flight>();
        Map<String, ArrayList<Flight>> trips = new HashMap<String, ArrayList<Flight>>();
        if (ticketService.insert(ticket) == 1){
            model.addAttribute("status", 4);
            session.setAttribute("buyOptions", ticket);
            model.addAttribute("user", client);
            check = ticketService.selectTicketsByUserId(userId);
            if (check.size() != 0){
                for (Ticket t : check){
                    Flight flight = flightService.selectByPrimaryKey(t.getFlightid());
                    list.add(flight);
                }
            }
            trips.put("trips", list);
            model.addAllAttributes(trips);
        }
        else {
            model.addAttribute("status", 5);
            model.addAttribute("user", client);
            check = ticketService.selectTicketsByUserId(userId);
            if (check.size() != 0){
                for (Ticket t : check){
                    Flight flight = flightService.selectByPrimaryKey(t.getFlightid());
                    list.add(flight);
                }
            }
            trips.put("trips", list);
            model.addAllAttributes(trips);
        }
        return "usermanage";
    }

}
