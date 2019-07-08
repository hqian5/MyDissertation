package com.springmvc.entity;

public class Transaction {
    private Integer transactionid;

    private Integer userid;

    private Integer flightid;

    private Integer ticketid;

    private String transCondition;

    public Integer getTransactionid() {
        return transactionid;
    }

    public void setTransactionid(Integer transactionid) {
        this.transactionid = transactionid;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public Integer getFlightid() {
        return flightid;
    }

    public void setFlightid(Integer flightid) {
        this.flightid = flightid;
    }

    public Integer getTicketid() {
        return ticketid;
    }

    public void setTicketid(Integer ticketid) {
        this.ticketid = ticketid;
    }

    public String getTransCondition() {
        return transCondition;
    }

    public void setTransCondition(String transCondition) {
        this.transCondition = transCondition;
    }
}