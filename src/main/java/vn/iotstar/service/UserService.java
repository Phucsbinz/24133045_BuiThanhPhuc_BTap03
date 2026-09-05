package vn.iotstar.service;

import vn.iotstar.entity.User;

public interface UserService {

    User login(String username, String password);

    User get(String username);

    User get(int id);

    User findByEmail(String email);

    User findByUsernameOrEmail(String identifier);

    void insert(User user);

    boolean register(String email, String password, String username, String fullname, String phone);

    boolean registerWithOtp(String email, String password, String username, String fullname, String phone);

    boolean verifyOtp(String username, String otp);

    boolean resendOtp(String username);

    boolean sendForgotPasswordOtp(String emailOrUsername);

    boolean resetPasswordWithOtp(String emailOrUsername, String otp, String newPassword);

    boolean checkExistEmail(String email);

    boolean checkExistUsername(String username);

    boolean checkExistPhone(String phone);
}
