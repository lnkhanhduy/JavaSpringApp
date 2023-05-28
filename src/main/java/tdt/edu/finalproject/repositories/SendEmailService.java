package tdt.edu.finalproject.repositories;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class SendEmailService {

  @Autowired
  private JavaMailSender emailSender;

  public void sendEmail(String toEmail,
      String subject,
      String body) {
    SimpleMailMessage message = new SimpleMailMessage();
    message.setFrom("khanhduyhbvl20011@gmail.com");
    message.setTo(toEmail);
    message.setText(body);
    message.setSubject(subject);

    emailSender.send(message);
  }

}
