package com.springmvc.dao;

import com.springmvc.util.EmailSender;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:/spring/applicationContext.xml"})
public class JavaMailSenderTest {
    @Autowired
    private JavaMailSender javaMailSender;

    @Test
    public void sendEmail(){
//        SimpleMailMessage mailMessage = new SimpleMailMessage();
//        mailMessage.setFrom("Birds_Tracker");
//        mailMessage.setTo("18202136170@163.com");
//        mailMessage.setSubject("Update of your flight");
//        mailMessage.setText("Your flight has been cancelled");
//        javaMailSender.send(mailMessage);
        EmailSender emailSender = new EmailSender("18202136170@163.com", "1", "1", "1", "1", "1", javaMailSender);
        emailSender.sendEmail();
    }
}
