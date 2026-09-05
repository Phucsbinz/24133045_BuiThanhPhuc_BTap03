package vn.iotstar.service.impl;

import java.sql.Date;
import java.sql.Timestamp;

import vn.iotstar.dao.UserDao;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;
import vn.iotstar.util.EmailUtil;
import vn.iotstar.util.OtpUtil;
import vn.iotstar.util.PasswordUtil;

public class UserServiceImpl implements UserService {

    private final UserDao userDao = new UserDaoImpl();

    @Override
    public User login(String username, String password) {
        User user = this.get(username);
        if (user != null && PasswordUtil.checkPassword(password, user.getPassword())) {
            // Tu dong nang cap mat khau cu sang BCrypt hash
            if (user.getPassword() != null && !user.getPassword().startsWith("$2a$") && !user.getPassword().startsWith("$2b$") && !user.getPassword().startsWith("$2y$")) {
                userDao.updatePassword(user.getUserName(), PasswordUtil.hashPassword(password));
            }
            return user;
        }
        return null;
    }

    @Override
    public User get(String username) {
        return userDao.findByUserName(username);
    }

    @Override
    public User get(int id) {
        return userDao.findById(id);
    }

    @Override
    public User findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public User findByUsernameOrEmail(String identifier) {
        if (identifier == null || identifier.trim().isEmpty()) {
            return null;
        }
        String clean = identifier.trim();
        if (clean.contains("@")) {
            User user = userDao.findByEmail(clean);
            if (user != null) {
                return user;
            }
        }
        return userDao.findByUserName(clean);
    }

    @Override
    public void insert(User user) {
        if (user.getPassword() != null && !user.getPassword().startsWith("$2a$") && !user.getPassword().startsWith("$2b$") && !user.getPassword().startsWith("$2y$")) {
            user.setPassword(PasswordUtil.hashPassword(user.getPassword()));
        }
        userDao.insert(user);
    }

    @Override
    public boolean register(String email, String password, String username, String fullname, String phone) {
        return registerWithOtp(email, password, username, fullname, phone);
    }

    @Override
    public boolean registerWithOtp(String email, String password, String username, String fullname, String phone) {
        if (userDao.checkExistUsername(username)) {
            return false;
        }

        long now = System.currentTimeMillis();
        Date createdDate = new Date(now);
        Timestamp otpExpiry = new Timestamp(now + 5 * 60 * 1000); // 5 phút
        String otp = OtpUtil.generateOtp();

        User user = new User();
        user.setEmail(email);
        user.setUserName(username);
        user.setFullName(fullname);
        user.setPassword(PasswordUtil.hashPassword(password));
        user.setPhone(phone);
        user.setRoleid(3); // Mặc định là User thường (roleid = 3)
        user.setCreatedDate(createdDate);
        user.setStatus(0); // 0: Chưa kích hoạt, chờ OTP
        user.setOtp(otp);
        user.setOtpExpiry(otpExpiry);

        try {
            userDao.insert(user);
            // Gửi email OTP
            EmailUtil.sendOtpEmail(email, otp, "KÍCH HOẠT TÀI KHOẢN");
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean verifyOtp(String username, String otp) {
        boolean valid = userDao.verifyOtp(username, otp);
        if (valid) {
            userDao.activateUser(username);
            return true;
        }
        return false;
    }

    @Override
    public boolean resendOtp(String username) {
        User user = userDao.findByUserName(username);
        if (user == null || user.getEmail() == null) {
            return false;
        }
        String newOtp = OtpUtil.generateOtp();
        Timestamp expiry = new Timestamp(System.currentTimeMillis() + 5 * 60 * 1000);
        userDao.updateOtp(username, newOtp, expiry);
        EmailUtil.sendOtpEmail(user.getEmail(), newOtp, "GỬI LẠI MÃ KÍCH HOẠT");
        return true;
    }

    @Override
    public boolean sendForgotPasswordOtp(String emailOrUsername) {
        User user = findByUsernameOrEmail(emailOrUsername);
        if (user == null || user.getEmail() == null) {
            return false;
        }
        String otp = OtpUtil.generateOtp();
        Timestamp expiry = new Timestamp(System.currentTimeMillis() + 5 * 60 * 1000);
        userDao.updateOtp(user.getUserName(), otp, expiry);
        EmailUtil.sendOtpEmail(user.getEmail(), otp, "ĐẶT LẠI MẬT KHẨU");
        return true;
    }

    @Override
    public boolean resetPasswordWithOtp(String emailOrUsername, String otp, String newPassword) {
        User user = findByUsernameOrEmail(emailOrUsername);
        if (user == null) {
            return false;
        }
        boolean valid = userDao.verifyOtp(user.getUserName(), otp);
        if (valid) {
            userDao.updatePassword(user.getUserName(), PasswordUtil.hashPassword(newPassword));
            return true;
        }
        return false;
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistPhone(String phone) {
        return userDao.checkExistPhone(phone);
    }
}
