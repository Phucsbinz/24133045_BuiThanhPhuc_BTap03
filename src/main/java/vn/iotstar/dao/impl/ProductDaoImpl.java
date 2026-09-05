package vn.iotstar.dao.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.dao.IProductDao;
import vn.iotstar.entity.Product;

public class ProductDaoImpl implements IProductDao {

    @Override
    public void insert(Product product) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(product);
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
    public void update(Product product) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(product);
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
            Product product = enma.find(Product.class, id);
            if (product != null) {
                enma.remove(product);
            } else {
                throw new Exception("Không tìm thấy sản phẩm có ID = " + id);
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
    public Product findById(int id) {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            return enma.find(Product.class, id);
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Product> findAll() {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            TypedQuery<Product> query = enma.createNamedQuery("Product.findAll", Product.class);
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Product> findTop10Latest() {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT p FROM Product p WHERE p.status = 1 ORDER BY p.productId DESC";
        try {
            TypedQuery<Product> query = enma.createQuery(jpql, Product.class);
            query.setFirstResult(0);
            query.setMaxResults(10);
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Product> findPage(int page, int pageSize) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT p FROM Product p WHERE p.status = 1 ORDER BY p.productId DESC";
        try {
            TypedQuery<Product> query = enma.createQuery(jpql, Product.class);
            int firstResult = (page - 1) * pageSize;
            if (firstResult < 0) {
                firstResult = 0;
            }
            query.setFirstResult(firstResult);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Product> findByCategoryId(int cateId) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT p FROM Product p WHERE p.category.categoryid = :cateId AND p.status = 1 ORDER BY p.productId DESC";
        try {
            TypedQuery<Product> query = enma.createQuery(jpql, Product.class);
            query.setParameter("cateId", cateId);
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Product> searchByName(String keyword) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT p FROM Product p WHERE p.productName LIKE :keyword AND p.status = 1 ORDER BY p.productId DESC";
        try {
            TypedQuery<Product> query = enma.createQuery(jpql, Product.class);
            query.setParameter("keyword", "%" + keyword + "%");
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public int count() {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT COUNT(p) FROM Product p";
        try {
            Query query = enma.createQuery(jpql);
            return ((Long) query.getSingleResult()).intValue();
        } finally {
            enma.close();
        }
    }

    @Override
    public int countActive() {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT COUNT(p) FROM Product p WHERE p.status = 1";
        try {
            Query query = enma.createQuery(jpql);
            return ((Long) query.getSingleResult()).intValue();
        } finally {
            enma.close();
        }
    }
}
