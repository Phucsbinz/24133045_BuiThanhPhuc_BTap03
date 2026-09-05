package vn.iotstar.util;

import java.security.SecureRandom;

public class OtpUtil {

    private static final SecureRandom random = new SecureRandom();

    /**
     * Sinh mã OTP ngẫu nhiên gồm 6 chữ số (100000 - 999999)
     */
    public static String generateOtp() {
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }
}
