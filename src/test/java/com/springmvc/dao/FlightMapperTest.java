package com.springmvc.dao;

import com.springmvc.entity.Flight;
import com.springmvc.service.inter.FlightService;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

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

    @Autowired
    private FlightService service;

    @Before
    public void setUp() throws Exception {
        applicationContext = new ClassPathXmlApplicationContext("classpath:spring/applicationContext.xml");
        mapper = applicationContext.getBean(FlightMapper.class);
        service = applicationContext.getBean(FlightService.class);
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
        flight.setFlightStatus("1");
        int result = mapper.insert(flight);
        System.out.println(result);
        assert (result == 1);

    }

    @Test
    public void insertService(){
        Flight flight = new Flight();
        flight.setFlightNumber("a");
        flight.setDepartureTime("b");
        flight.setDepartureAirport("c");
        flight.setArrivalTime("d");
        flight.setArrivalAirport("e");
        flight.setSeatNumber(50);
        flight.setSeatFree(20);
        flight.setPrice(10);
        flight.setFlightStatus("1");
        int result = service.insert(flight);
        System.out.println(result);
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

    private double getAngle1(double lat_a, double lng_a, double lat_b, double lng_b) {

        double y = Math.sin(lng_b-lng_a) * Math.cos(lat_b);
        double x = Math.cos(lat_a)*Math.sin(lat_b) - Math.sin(lat_a)*Math.cos(lat_b)*Math.cos(lng_b-lng_a);
        double brng = Math.atan2(y, x);

        brng = Math.toDegrees(brng);
        if(brng < 0)
            brng = brng +360;
        return brng;

    }

    private double getAngel2(double lat1, double lon1, double lat2, double lon2){
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

    @Test
    public void testAngel(){
        double a = getAngle1( 52.3667, 4.8945, 51.5074, 0.1278);
        double b = getAngel2(52.3667, 4.8945, 51.5074, 0.1278);
        System.out.println(a + ", " + b);
    }

    private static double EARTH_RADIUS = 6378.137;
//
    private static double rad(double d) {
        return d * Math.PI / 180.0;
    }
//
    public double getDistance(double lat1, double lng1, double lat2,
                                     double lng2) {
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

    @Test
    public void testDis(){
        double a = getDistance(51.5074, 0.1278, 52.5200, 13.4050);
        System.out.println(a);
    }

//    @Test
//    public void direction(){
//        double a = getAngle1(51.5074, 0.1278, 48.8566, 2.3522);
//        System.out.println(a);
//    }
//
//    @Test
//    public void distance(){
//        double a = getDistance(51.5074, 0.1278, 48.8566, 2.3522);
//        System.out.println(a);
//    }

    @Test
    public void selectByPrimaryKey() {
        Flight flight = mapper.selectByPrimaryKey(1);
        Flight flight1 = mapper.selectByPrimaryKey(47);
        double angel1 = flight.getDirection();
        double angel2 = flight1.getDirection();
        System.out.println("1: " + angel1 + " 2: " + angel2);
    }

    private double a = 6378137;
    private double b = 6356752.3142;
    private double f = 1 / 298.2572236;

    public void computerThatLonLat(double lon, double lat, double brng, double dist) {

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

        System.out.println(revAz);
        System.out.println(lon+deg(L)+","+deg(lat2));
    }

//    private double rad(double d) {
//        return d * Math.PI / 180.0;
//    }

    /**
     * 弧度换成度
     *
     * @param x
     *            弧度
     * @return 度
     */
    private double deg(double x) {
        return x * 180 / Math.PI;
    }

    @Test
    public void test(){
        double lat=51.5074;
        double lon=0.1278;
        double brng=301.73111741345497;
        double dist=600000;

        computerThatLonLat(lat, lon, brng, dist);
        computerThatLonLat(lon, lat, brng, dist);

    }

}