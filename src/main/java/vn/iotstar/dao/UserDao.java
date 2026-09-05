package vn.iotstar.dao;

import java.sql.Timestamp;
import java.util.List;
import vn.iotstar.entity.User;

public interface UserDao {

    List<User> findAll();

    User findById(int id);

    User findByUserName(String username);

    User findByEmail(String email);

    void insert(User user);

    void update(User user);

    void delete(int id) throws Exception;

    boolean checkExistEmail(String email);

    boolean checkExistUsername(String username);

    boolean checkExistPhone(String phone);

    void updateOtp(String username, String otp, Timestamp expiry);

    boolean verifyOtp(String username, String otp);

    void activateUser(String username);

    void updatePassword(String username, String newPassword);
}
