package com.springmvc.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.test.context.ContextConfiguration;

@ContextConfiguration(locations = {"classpath:/spring/applicationContext.xml"})
public class EmailSender {

    @Autowired
    private JavaMailSender mailSender;

    private String address;
    private String username;
    private String flightNumber;
    private String departure;
    private String arrival;
    private String status;

    public EmailSender(String a, String b, String c, String d, String e, String f, JavaMailSender m){
        this.address = a;
        this.username = b;
        this.flightNumber = c;
        this.departure = d;
        this.arrival = e;
        this.status = f;
        this.mailSender = m;
    }

    public void sendEmail(){
        SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setFrom("Birds_Tracker@Official");
        mailMessage.setTo(address);
        mailMessage.setSubject("Update of your flight");
        mailMessage.setText(username + ", we are very sorry to inform you that your flight " + flightNumber + " from " +
                departure + " to " + arrival + " has been " + status + ". Please log into your manage page to view optional flights " +
                "that we offer for you.");
        mailSender.send(mailMessage);
    }

    public void sendCheckIn(){
        SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setFrom("Birds_Tracker@Official");
        mailMessage.setTo(address);
        mailMessage.setSubject("Check in");
        mailMessage.setText(username + ", please be aware that your flight " + flightNumber + " from " +
                departure + " to " + arrival + " is about to take off " + status + ". Please check in now.");
        mailSender.send(mailMessage);
    }
}
