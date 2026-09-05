package vn.iotstar.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.entity.Video;

public class Test {

    public static void main(String[] args) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();

        String suffix = String.valueOf(System.currentTimeMillis() % 10000);

        Category cate = new Category();
        cate.setCategoryname("Smartphone " + suffix);
        cate.setImages("category.jpg");
        cate.setStatus(1);

        Video video = new Video();
        video.setVideoId("v" + suffix);
        video.setTitle("Video Review " + suffix);
        video.setCategory(cate);

        Product prod = new Product();
        prod.setProductName("iPhone 16 Pro Max " + suffix);
        prod.setDescription("Sản phẩm cao cấp chip A18 Pro, thiết kế titan, camera 48MP.");
        prod.setPrice(34990000);
        prod.setQuantity(25);
        prod.setStatus(1);
        prod.setImages("https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500");
        prod.setCategory(cate);

        try {
            trans.begin();
            enma.persist(cate);
            enma.persist(video);
            enma.persist(prod);
            trans.commit();
            System.out.println("[JPA Test] Thao tac CSDL (Category, Video, Product, User) thanh cong!");
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            enma.close();
            System.exit(0);
        }
    }
}
