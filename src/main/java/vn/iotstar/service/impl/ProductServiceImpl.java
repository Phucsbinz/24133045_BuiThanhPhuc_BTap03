package vn.iotstar.service.impl;

import java.util.List;

import vn.iotstar.dao.IProductDao;
import vn.iotstar.dao.impl.ProductDaoImpl;
import vn.iotstar.entity.Product;
import vn.iotstar.service.IProductService;

public class ProductServiceImpl implements IProductService {

    private final IProductDao productDao = new ProductDaoImpl();

    @Override
    public void insert(Product product) {
        productDao.insert(product);
    }

    @Override
    public void update(Product product) {
        productDao.update(product);
    }

    @Override
    public void delete(int id) throws Exception {
        productDao.delete(id);
    }

    @Override
    public Product findById(int id) {
        return productDao.findById(id);
    }

    @Override
    public List<Product> findAll() {
        return productDao.findAll();
    }

    @Override
    public List<Product> findTop10Latest() {
        return productDao.findTop10Latest();
    }

    @Override
    public List<Product> findPage(int page, int pageSize) {
        return productDao.findPage(page, pageSize);
    }

    @Override
    public List<Product> findByCategoryId(int cateId) {
        return productDao.findByCategoryId(cateId);
    }

    @Override
    public List<Product> searchByName(String keyword) {
        return productDao.searchByName(keyword);
    }

    @Override
    public int count() {
        return productDao.count();
    }

    @Override
    public int countActive() {
        return productDao.countActive();
    }
}
