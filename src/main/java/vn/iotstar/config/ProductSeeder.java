package vn.iotstar.config;

import java.sql.Date;
import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.iotstar.dao.ICategoryDao;
import vn.iotstar.dao.IProductDao;
import vn.iotstar.dao.impl.CategoryDao;
import vn.iotstar.dao.impl.ProductDaoImpl;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;

public class ProductSeeder {

    public static void main(String[] args) {
        ICategoryDao cateDao = new CategoryDao();
        IProductDao prodDao = new ProductDaoImpl();

        List<Category> categories = cateDao.findAll();
        if (categories == null || categories.isEmpty()) {
            Category c1 = new Category();
            c1.setCategoryname("Điện thoại");
            c1.setStatus(1);
            c1.setImages("https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=300");
            cateDao.insert(c1);

            Category c2 = new Category();
            c2.setCategoryname("Laptop & Máy tính");
            c2.setStatus(1);
            c2.setImages("https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=300");
            cateDao.insert(c2);

            Category c3 = new Category();
            c3.setCategoryname("Đồng hồ & Phụ kiện");
            c3.setStatus(1);
            c3.setImages("https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=300");
            cateDao.insert(c3);

            categories = cateDao.findAll();
        }

        Category catPhone = categories.get(0);
        Category catLaptop = categories.size() > 1 ? categories.get(1) : catPhone;
        Category catAccessory = categories.size() > 2 ? categories.get(2) : catPhone;

        String[][] sampleProducts = {
            {"iPhone 15 Pro Max 256GB Titan Tự Nhiên", "Thiết kế titan siêu nhẹ, chip Apple A17 Pro mạnh mẽ, camera tiềm vọng zoom quang học 5x.", "29990000", "https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=500", "catPhone"},
            {"Samsung Galaxy S24 Ultra 512GB AI", "Khung viền titan, bút S-Pen tích hợp, màn hình 6.8 inch phẳng Dynamic AMOLED 2X, Galaxy AI.", "27990000", "https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=500", "catPhone"},
            {"MacBook Pro 14 M3 Pro 18GB 512GB", "Hiệu năng đỉnh cao với chip M3 Pro, màn hình Liquid Retina XDR 120Hz siêu sắc nét.", "48500000", "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=500", "catLaptop"},
            {"Dell XPS 13 Plus 9320 Core i7", "Thiết kế tối giản tương lai, bàn di chuột tàng hình, màn hình OLED 3.5K cảm ứng tuyệt đẹp.", "36900000", "https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?w=500", "catLaptop"},
            {"iPad Pro M4 11 inch 256GB Wi-Fi", "Độ mỏng kỷ lục 5.3mm, chip Apple M4 thế hệ mới nhất, màn hình OLED 2 lớp Ultra Retina XDR.", "26490000", "https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=500", "catLaptop"},
            {"Apple Watch Ultra 2 Dây Alpine", "Vỏ titan chuẩn quân đội 49mm, định vị GPS tần số kép, pin lên tới 72 giờ ở chế độ tiết kiệm.", "19990000", "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500", "catAccessory"},
            {"Tai nghe AirPods Pro 2 USB-C", "Chống ồn chủ động gấp 2 lần, âm thanh thích ứng thông minh, chuẩn sạc Type-C tiện lợi.", "5890000", "https://images.unsplash.com/photo-1600294037681-c80b4cb5b434?w=500", "catAccessory"},
            {"Sony WH-1000XM5 Chống Ồn Cao Cấp", "Bộ xử lý V1 và QN1, thời lượng pin 30 giờ, đệm tai da êm ái, công nghệ đàm thoại AI rõ nét.", "7990000", "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500", "catAccessory"},
            {"Xiaomi 14 Ultra 16GB 512GB", "Hệ thống 4 camera Leica đỉnh cao cảm biến 1 inch, chip Snapdragon 8 Gen 3, màn hình 2K AMOLED.", "24990000", "https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=500", "catPhone"},
            {"Asus ROG Zephyrus G16 RTX 4070", "Laptop gaming mỏng nhẹ cao cấp, màn hình ROG Nebula OLED 240Hz, âm thanh 6 loa vòm Dolby Atmos.", "52990000", "https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=500", "catLaptop"},
            {"Bàn phím cơ Keychron K3 Pro Wireless", "Thiết kế Low-profile siêu mỏng, kết nối Bluetooth 5.1 và Type-C, switch Gateron mượt mà.", "2290000", "https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=500", "catAccessory"},
            {"Chuột Logitech MX Master 3S", "Cảm biến 8000 DPI lướt trên mặt kính, cuộn siêu tốc MagSpeed, click êm ái giảm 90% tiếng ồn.", "2190000", "https://images.unsplash.com/photo-1615663245857-ac93bb7c39e7?w=500", "catAccessory"}
        };

        int currentCount = prodDao.countActive();
        if (currentCount < 10) {
            for (String[] item : sampleProducts) {
                Product p = new Product();
                p.setProductName(item[0]);
                p.setDescription(item[1]);
                p.setPrice(Double.parseDouble(item[2]));
                p.setImages(item[3]);
                p.setQuantity(15);
                p.setStatus(1);
                p.setCreatedDate(new Date(System.currentTimeMillis()));

                if ("catPhone".equals(item[4])) {
                    p.setCategory(catPhone);
                } else if ("catLaptop".equals(item[4])) {
                    p.setCategory(catLaptop);
                } else {
                    p.setCategory(catAccessory);
                }

                prodDao.insert(p);
            }
            System.out.println("[Seeder] Da khoi tao 12 san pham mau vao CSDL!");
        } else {
            System.out.println("[Seeder] Da co " + currentCount + " san pham trong CSDL.");
        }

        System.exit(0);
    }
}
