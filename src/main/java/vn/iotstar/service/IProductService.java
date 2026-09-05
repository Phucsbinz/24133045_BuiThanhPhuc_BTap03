package vn.iotstar.service;

import java.util.List;
import vn.iotstar.entity.Product;

public interface IProductService {

    void insert(Product product);

    void update(Product product);

    void delete(int id) throws Exception;

    Product findById(int id);

    List<Product> findAll();

    List<Product> findTop10Latest();

    List<Product> findPage(int page, int pageSize);

    List<Product> findByCategoryId(int cateId);

    List<Product> searchByName(String keyword);

    int count();

    int countActive();
}
