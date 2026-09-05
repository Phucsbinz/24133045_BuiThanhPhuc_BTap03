package vn.iotstar.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    private static final int BCRYPT_ROUNDS = 12;

    /**
     * Bam mat khau bang thuat toan BCrypt voi salt ngau nhien (work factor = 12)
     *
     * @param plainPassword Mat khau goc chua bam
     * @return Chuoi hash BCrypt
     */
    public static String hashPassword(String plainPassword) {
        if (plainPassword == null || plainPassword.isEmpty()) {
            return plainPassword;
        }
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(BCRYPT_ROUNDS));
    }

    /**
     * Kiem tra tinh khop cua mat khau
     * Ho tro ca mat khau da bam BCrypt va mat khau cu de tuong thich nguoc
     *
     * @param plainPassword  Mat khau nguoi dung nhap vao
     * @param hashedPassword Mat khau luu trong CSDL
     * @return true neu dung, false neu sai
     */
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) {
            return false;
        }
        if (hashedPassword.startsWith("$2a$") || hashedPassword.startsWith("$2b$") || hashedPassword.startsWith("$2y$")) {
            try {
                return BCrypt.checkpw(plainPassword, hashedPassword);
            } catch (Exception e) {
                return false;
            }
        }
        return plainPassword.equals(hashedPassword);
    }
}
