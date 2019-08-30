package com.springmvc.entity;

public class Flight {
    private Integer flightid;

    private String flightNumber;

    private String departureTime;

    private String arrivalTime;

    private String departureAirport;

    private String arrivalAirport;

    private Integer seatNumber;

    private Integer seatFree;

    private Integer price;

    private String flightStatus;

    private Integer duration;

    private Double direction;

    private Double velocity;

    private String newDepartureTime;

    private String newArrivalTime;

    private Double lat;

    private Double lng;

    public Integer getFlightid() {
        return flightid;
    }

    public void setFlightid(Integer flightid) {
        this.flightid = flightid;
    }

    public String getFlightNumber() {
        return flightNumber;
    }

    public void setFlightNumber(String flightNumber) {
        this.flightNumber = flightNumber;
    }

    public String getDepartureTime() {
        return departureTime;
    }

    public void setDepartureTime(String departureTime) {
        this.departureTime = departureTime;
    }

    public String getArrivalTime() {
        return arrivalTime;
    }

    public void setArrivalTime(String arrivalTime) {
        this.arrivalTime = arrivalTime;
    }

    public String getDepartureAirport() {
        return departureAirport;
    }

    public void setDepartureAirport(String departureAirport) {
        this.departureAirport = departureAirport;
    }

    public String getArrivalAirport() {
        return arrivalAirport;
    }

    public void setArrivalAirport(String arrivalAirport) {
        this.arrivalAirport = arrivalAirport;
    }

    public Integer getSeatNumber() {
        return seatNumber;
    }

    public void setSeatNumber(Integer seatNumber) {
        this.seatNumber = seatNumber;
    }

    public Integer getSeatFree() {
        return seatFree;
    }

    public void setSeatFree(Integer seatFree) {
        this.seatFree = seatFree;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public String getFlightStatus() {
        return flightStatus;
    }

    public void setFlightStatus(String flightStatus) {
        this.flightStatus = flightStatus;
    }

    public Integer getDuration() {
        return duration;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    public Double getDirection() {
        return direction;
    }

    public void setDirection(Double direction) {
        this.direction = direction;
    }

    public Double getVelocity() {
        return velocity;
    }

    public void setVelocity(Double velocity) {
        this.velocity = velocity;
    }

    public String getNewDepartureTime() {
        return newDepartureTime;
    }

    public void setNewDepartureTime(String newDepartureTime) {
        this.newDepartureTime = newDepartureTime;
    }

    public String getNewArrivalTime() {
        return newArrivalTime;
    }

    public void setNewArrivalTime(String newArrivalTime) {
        this.newArrivalTime = newArrivalTime;
    }

    public Double getLat() {
        return lat;
    }

    public void setLat(Double lat) {
        this.lat = lat;
    }

    public Double getLng() {
        return lng;
    }

    public void setLng(Double lng) {
        this.lng = lng;
    }
}