package vn.iotstar.entity;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;

@Entity
@Table(name = "users")
@NamedQuery(name = "User.findAll", query = "SELECT u FROM User u")
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "email", columnDefinition = "nvarchar(255) null")
    private String email;

    @Column(name = "username", columnDefinition = "nvarchar(255) not null", unique = true)
    private String userName;

    @Column(name = "fullname", columnDefinition = "nvarchar(255) null")
    private String fullName;

    @Column(name = "password", columnDefinition = "nvarchar(255) not null")
    private String password;

    @Column(name = "avatar", columnDefinition = "nvarchar(255) null")
    private String avatar;

    @Column(name = "roleid")
    private int roleid;

    @Column(name = "phone", columnDefinition = "nvarchar(50) null")
    private String phone;

    @Column(name = "createddate")
    private Date createdDate;

    // 0: Chưa kích hoạt, 1: Đã kích hoạt qua OTP Email
    @Column(name = "status")
    private int status = 0;

    // Mã OTP 6 số
    @Column(name = "otp", columnDefinition = "varchar(10) null")
    private String otp;

    // Thời gian hết hạn của OTP
    @Column(name = "otp_expiry")
    private Timestamp otpExpiry;

    public User() {
    }

    public User(int id, String email, String userName, String fullName, String password, String avatar, int roleid,
            String phone, Date createdDate) {
        this.id = id;
        this.email = email;
        this.userName = userName;
        this.fullName = fullName;
        this.password = password;
        this.avatar = avatar;
        this.roleid = roleid;
        this.phone = phone;
        this.createdDate = createdDate;
        this.status = 0;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public int getRoleid() {
        return roleid;
    }

    public void setRoleid(int roleid) {
        this.roleid = roleid;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getOtp() {
        return otp;
    }

    public void setOtp(String otp) {
        this.otp = otp;
    }

    public Timestamp getOtpExpiry() {
        return otpExpiry;
    }

    public void setOtpExpiry(Timestamp otpExpiry) {
        this.otpExpiry = otpExpiry;
    }
}
