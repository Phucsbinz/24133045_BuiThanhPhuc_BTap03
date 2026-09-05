package vn.iotstar.dao.impl;

import java.sql.Timestamp;
import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.dao.UserDao;
import vn.iotstar.entity.User;

public class UserDaoImpl implements UserDao {

    @Override
    public List<User> findAll() {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            TypedQuery<User> query = enma.createNamedQuery("User.findAll", User.class);
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public User findById(int id) {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            return enma.find(User.class, id);
        } finally {
            enma.close();
        }
    }

    @Override
    public User findByUserName(String username) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT u FROM User u WHERE u.userName = :uname";
        try {
            TypedQuery<User> query = enma.createQuery(jpql, User.class);
            query.setParameter("uname", username);
            try {
                return query.getSingleResult();
            } catch (NoResultException nre) {
                return null;
            }
        } finally {
            enma.close();
        }
    }

    @Override
    public User findByEmail(String email) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT u FROM User u WHERE u.email = :email";
        try {
            TypedQuery<User> query = enma.createQuery(jpql, User.class);
            query.setParameter("email", email);
            try {
                return query.getSingleResult();
            } catch (NoResultException nre) {
                return null;
            }
        } finally {
            enma.close();
        }
    }

    @Override
    public void insert(User user) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(user);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void update(User user) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(user);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void delete(int id) throws Exception {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            User user = enma.find(User.class, id);
            if (user != null) {
                enma.remove(user);
            }
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public boolean checkExistEmail(String email) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT COUNT(u) FROM User u WHERE u.email = :email";
        try {
            Long count = enma.createQuery(jpql, Long.class).setParameter("email", email).getSingleResult();
            return count != null && count > 0;
        } finally {
            enma.close();
        }
    }

    @Override
    public boolean checkExistUsername(String username) {
        return findByUserName(username) != null;
    }

    @Override
    public boolean checkExistPhone(String phone) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT COUNT(u) FROM User u WHERE u.phone = :phone";
        try {
            Long count = enma.createQuery(jpql, Long.class).setParameter("phone", phone).getSingleResult();
            return count != null && count > 0;
        } finally {
            enma.close();
        }
    }

    @Override
    public void updateOtp(String username, String otp, Timestamp expiry) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            User user = findByUserName(username);
            if (user != null) {
                User managedUser = enma.find(User.class, user.getId());
                managedUser.setOtp(otp);
                managedUser.setOtpExpiry(expiry);
                enma.merge(managedUser);
            }
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public boolean verifyOtp(String username, String otp) {
        if (username == null || otp == null) {
            return false;
        }
        User user = findByUserName(username);
        if (user == null || user.getOtp() == null) {
            return false;
        }
        // Kiểm tra mã OTP khớp
        if (!user.getOtp().trim().equals(otp.trim())) {
            return false;
        }
        // Kiểm tra thời hạn
        if (user.getOtpExpiry() != null && user.getOtpExpiry().before(new Timestamp(System.currentTimeMillis()))) {
            return false; // Đã hết hạn
        }
        return true;
    }

    @Override
    public void activateUser(String username) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            User user = findByUserName(username);
            if (user != null) {
                User managedUser = enma.find(User.class, user.getId());
                managedUser.setStatus(1); // Đã kích hoạt
                managedUser.setOtp(null);
                managedUser.setOtpExpiry(null);
                enma.merge(managedUser);
            }
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void updatePassword(String username, String newPassword) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            User user = findByUserName(username);
            if (user != null) {
                User managedUser = enma.find(User.class, user.getId());
                managedUser.setPassword(newPassword);
                managedUser.setOtp(null);
                managedUser.setOtpExpiry(null);
                enma.merge(managedUser);
            }
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            enma.close();
        }
    }
}
