package vn.iotstar.util;

import java.util.Properties;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtil {

    // Cấu hình Gmail SMTP - Thay thế bằng tài khoản Gmail và Mật khẩu ứng dụng 16 ký tự của bạn
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String EMAIL_USER = "your_email@gmail.com";
    private static final String EMAIL_PASS = "your_app_password"; // Mật khẩu ứng dụng 16 ký tự của Google

    private static final ExecutorService executor = Executors.newCachedThreadPool();

    /**
     * Gửi email mã OTP bất đồng bộ (không làm chậm luồng xử lý web)
     *
     * @param toEmail Email người nhận
     * @param otp     Mã OTP 6 số
     * @param type    Mục đích ("KÍCH HOẠT TÀI KHOẢN" hoặc "ĐẶT LẠI MẬT KHẨU")
     */
    public static void sendOtpEmail(String toEmail, String otp, String type) {
        executor.submit(() -> {
            try {
                Properties props = new Properties();
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true");
                props.put("mail.smtp.host", SMTP_HOST);
                props.put("mail.smtp.port", SMTP_PORT);
                props.put("mail.smtp.ssl.protocols", "TLSv1.2");

                Session session = Session.getInstance(props, new Authenticator() {
                    @Override
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(EMAIL_USER, EMAIL_PASS);
                    }
                });

                Message message = new MimeMessage(session);
                message.setFrom(new InternetAddress(EMAIL_USER, "Hệ Thống Web IOTSTAR"));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));

                String subject = "Xác nhận OTP - " + type;
                message.setSubject(subject);

                String htmlContent = "<div style=\"font-family: Arial, sans-serif; max-width: 600px; margin: auto; padding: 25px; border: 1px solid #e0e0e0; border-radius: 10px; background-color: #ffffff;\">"
                        + "<div style=\"text-align: center; border-bottom: 2px solid #007bff; padding-bottom: 15px;\">"
                        + "<h2 style=\"color: #007bff; margin: 0;\">HỆ THỐNG XÁC THỰC BẢO MẬT</h2>"
                        + "<p style=\"color: #666; margin: 5px 0 0 0;\">Yêu cầu xác nhận cho mục đích: <b>" + type + "</b></p>"
                        + "</div>"
                        + "<div style=\"padding: 25px 0; text-align: center;\">"
                        + "<p style=\"font-size: 16px; color: #333;\">Chào bạn,</p>"
                        + "<p style=\"font-size: 15px; color: #555;\">Dưới đây là mã OTP bảo mật dùng để hoàn tất yêu cầu của bạn. Mã có hiệu lực trong vòng <b>5 phút</b>:</p>"
                        + "<div style=\"display: inline-block; background-color: #f1f7ff; border: 2px dashed #007bff; border-radius: 8px; padding: 12px 30px; margin: 15px 0;\">"
                        + "<span style=\"font-size: 32px; font-weight: bold; letter-spacing: 6px; color: #007bff;\">" + otp + "</span>"
                        + "</div>"
                        + "<p style=\"font-size: 14px; color: #e74c3c; margin-top: 15px;\"><i>Lưu ý: Tuyệt đối không chia sẻ mã này cho bất kỳ ai để bảo vệ tài khoản của bạn.</i></p>"
                        + "</div>"
                        + "<div style=\"border-top: 1px solid #eeeeee; padding-top: 15px; font-size: 12px; color: #999; text-align: center;\">"
                        + "<p style=\"margin: 0;\">Email này được gửi tự động từ hệ thống. Vui lòng không trả lời thư này.</p>"
                        + "</div>"
                        + "</div>";

                message.setContent(htmlContent, "text/html; charset=UTF-8");
                Transport.send(message);
                System.out.println("[Email Service] Da gui thanh cong OTP toi email: " + toEmail);
            } catch (Exception e) {
                System.err.println("[Email Service] Loi khi gui email den: " + toEmail + " -> " + e.getMessage());
            }
        });
    }
}
