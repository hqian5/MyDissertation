package com.springmvc.dao;

import com.springmvc.entity.Flight;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.security.sasl.SaslServer;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;

public class FlightMapperTest {

    private ApplicationContext applicationContext;

    @Autowired
    private FlightMapper mapper;

    @Before
    public void setUp() throws Exception {
        applicationContext = new ClassPathXmlApplicationContext("classpath:spring/applicationContext.xml");
        mapper = applicationContext.getBean(FlightMapper.class);
    }

    @After
    public void tearDown() throws Exception {
    }

    @Test
    public void insert() {
        Flight flight = new Flight();
        flight.setFlightNumber("a");
        flight.setDepartureTime("b");
        flight.setDepartureAirport("c");
        flight.setArrivalTime("d");
        flight.setArrivalAirport("e");
        flight.setSeatNumber(50);
        flight.setSeatFree(20);
        flight.setPrice(10);
        int result = mapper.insert(flight);
        System.out.println(result);
        assert (result == 1);

    }

    @Test
    public void selectByFlightNumber() {
        Flight flight = new Flight();
        flight.setFlightNumber("E222");
        ArrayList<Flight> list = mapper.selectByFlightNumber(flight);
        System.out.println(list.size());
        for (Flight f : list){
            System.out.println(f.getFlightNumber() + f.getDepartureTime());
        }
    }

    @Test
    public void selectAllFlights() {
        ArrayList<Flight> list = mapper.selectAllFlights();
        for (Flight f : list){
            System.out.println(f.getFlightNumber());
        }
    }

    @Test
    public void deleteByPrimaryKey() {
        int record = mapper.deleteByPrimaryKey(9);
        System.out.println(record);

    }

    @Test
    public void updateByPrimaryKeySelective() {
        Flight flight = new Flight();
        flight.setFlightid(8);
        flight.setFlightNumber("update");
        flight.setDepartureTime("b");
        flight.setDepartureAirport("c");
        flight.setArrivalTime("d");
        flight.setArrivalAirport("e");
        flight.setSeatNumber(50);
        flight.setSeatFree(20);
        flight.setPrice(10);
        int record = mapper.updateByPrimaryKeySelective(flight);
        System.out.println(record);
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

    public String generateTime(){
        String middle = "2019-07-15";
        Random random = new Random();
        int hour = random.nextInt(23);
        int minute = random.nextInt(60);
        int duration = random.nextInt(500) + 60;
        String start = middle + 'T' + check(hour) + ':' + check(minute);
        String end = new String();
        Date startDate = new Date();
        Date endDate = new Date();
        Calendar calendar = Calendar.getInstance();
        DateFormat format =  new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        try {
            startDate = format.parse(start);
            calendar.setTime(startDate);
            calendar.add(Calendar.MINUTE, duration);
            endDate = calendar.getTime();
            start = format.format(startDate);
            end = format.format(endDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return "start:" + start + ", end: " + end;
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


    public String generateAirport(){
        String[] airports = {"London", "Paris", "Berlin", "Amsterdam", "Helsinki", "Frankfurt", "Istanbul", "Munich", "Rome", "Moscow"};
        Random random = new Random();
        int i = random.nextInt(9);
        int j = random.nextInt(9);
        if (i == j){
            j = random.nextInt(9);
        }
        String departure = airports[i];
        String arrival = airports[j];
        return "from: " + departure + " to: " + arrival;
    }

    public String generateAirports(int choose){
        String[] airports = {"London", "Paris", "Berlin", "Amsterdam", "Helsinki", "Frankfurt", "Istanbul", "Munich", "Rome", "Moscow"};
        Random random = new Random();
        int i = random.nextInt(9);
        int j = random.nextInt(9);
        if (i == j){
            j = random.nextInt(9);
        }
        String departure = airports[i];
        String arrival = airports[j];
        if (choose == 0){
            return departure;
        }
        else {
            return arrival;
        }
    }

    @Test
    public void generateSeats(){
        Random random = new Random();
        int seat = random.nextInt(150) + 100;
        int seatFree = random.nextInt(seat);
        System.out.println(seat + ", " + seatFree);
    }

    @Test
    public void testValue(){

//        ArrayList<String> list = new ArrayList<String>();
//        for (int i = 0; i < 50; i++){
//            list.add(generateLetter() + generateNumber() + ", time: " + generateTime() + " " + "from: " +
//                    generateAirports(0) + " to: " + generateAirports(1));
//        }
//
//        for (String s : list){
//            System.out.println(s);
//        }

        String[] airports = {"London", "Paris", "Berlin", "Amsterdam", "Helsinki", "Frankfurt", "Istanbul", "Munich", "Rome", "Moscow"};
        String[] b = delete(1,airports);
        for (String i : b){
            System.out.println(i);
        }
    }

    private String[] delete(int index, String array[]) {
        String[] arrNew = new String[array.length - 1];
        for (int i = index; i < array.length - 1; i++) {
            array[i] = array[i + 1];
        }
        System.arraycopy(array, 0, arrNew, 0, arrNew.length);
        return arrNew;
    }

    @Test
    public void selectByDepartureAirport() {
        ArrayList<Flight> list = new ArrayList<Flight>();
        list = mapper.selectByDepartureAirport("London");
        for (Flight f : list){
            System.out.println(f.getFlightNumber() + ", " + f.getDepartureTime() + ", " + f.getDepartureAirport());
        }
    }

    @Test
    public void selectByDateAndAirports() {
        Flight flight = new Flight();
        flight.setDepartureTime("2019-07-25");
        flight.setDepartureAirport("London");
        flight.setArrivalAirport("Paris");
        ArrayList<Flight> list = mapper.selectByDateAndAirports(flight);
        for (Flight f : list){
            System.out.println(f.getFlightNumber() + ": " + f.getDepartureAirport() + ", "
                    + f.getArrivalAirport() + ", " + f.getDepartureTime());
        }
    }
}