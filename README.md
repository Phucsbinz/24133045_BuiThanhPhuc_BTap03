# Dự Án Web JPA 3.0: Xác Thực OTP Email, Quản Trị & Hiển Thị Sản Phẩm

Dự án Java Web hoàn chỉnh được xây dựng trên nền tảng **JPA 3.0 & Jakarta Servlet 6.0 (Hibernate 6.6.1)**, tích hợp các tính năng bảo mật xác thực qua OTP Email và hệ thống bán hàng quản lý Sản phẩm - Danh mục.

---

## 1. Công Nghệ Sử Dụng
* **Ngôn ngữ**: Java 17+ (tương thích JDK 17, 21, 26)
* **Web Container**: Jakarta Servlet 6.0, Jakarta JSP 3.1, JSTL 3.0 (Apache Tomcat 10.1+ / 11)
* **ORM / JPA**: JPA 3.0, Hibernate ORM 6.6.1.Final, Jakarta Persistence API 3.1.0
* **Email Service**: Jakarta Mail (Angus Mail 2.0.3), Gmail SMTP (`smtp.gmail.com:587`, STARTTLS)
* **Validation**: Jakarta Validation 3.0.2, Hibernate Validator 8.0.1.Final
* **CSDL**: MySQL Server 8.0+ (`servletjpa`), tự động cập nhật schema (`hibernate.hbm2ddl.auto = update`)
* **Bảo mật**: Thuật toán băm mật khẩu chuẩn BCrypt (jBCrypt 0.4) với salt ngẫu nhiên
* **Thư viện**: MySQL Connector/J 8.4.0, Commons-IO 2.16.1, Commons-BeanUtils 1.9.4

---

## 2. Các Chức Năng Nổi Bật

### 1. Xác thực & Kích hoạt tài khoản qua OTP Email
- **Đăng ký tài khoản (`/register`)**:
  - Người dùng đăng ký tài khoản mới -> Tài khoản ở trạng thái chưa kích hoạt (`status = 0`).
  - Hệ thống tự động sinh mã **OTP 6 số ngẫu nhiên** có hiệu lực trong 5 phút.
  - Tự động gửi email HTML chứa mã OTP đến địa chỉ email của người dùng qua Gmail SMTP.
- **Kích hoạt tài khoản (`/verify-otp`)**:
  - Nhập mã OTP 6 số để kích hoạt tài khoản sang trạng thái hoạt động (`status = 1`).
  - Có nút "Gửi lại mã OTP" (`/resend-otp`) nếu chưa nhận được hoặc mã hết hạn.

### 2. Đăng nhập hệ thống (`/login`)
- Xác thực tài khoản & mật khẩu.
- **Kiểm tra trạng thái kích hoạt**: Nếu tài khoản chưa kích hoạt qua OTP, hệ thống sẽ cảnh báo và cung cấp liên kết để chuyển nhanh đến trang nhập mã kích hoạt.
- Hỗ trợ tính năng "Nhớ tôi" (Remember Me) lưu Cookie 30 phút và phiên làm việc `HttpSession`.
- Tự động phân quyền điều hướng tại `/waiting`:
  - `roleid == 1` (Admin) -> `/admin/home` (Admin Panel).
  - `roleid == 2` (Manager) -> `/manager/home`.
  - Khác -> `/home` (User Home).

### 3. Quên mật khẩu & Đặt lại mật khẩu (`/forgot-password` & `/reset-password`)
- **Quên mật khẩu (`/forgot-password`)**:
  - Nhập Username hoặc Email liên kết.
  - Hệ thống kiểm tra và gửi mã OTP 6 số đến email của người dùng.
- **Đặt lại mật khẩu (`/reset-password`)**:
  - Nhập mã OTP, mật khẩu mới và xác nhận mật khẩu mới.
  - Kiểm tra tính hợp lệ và thời hạn OTP, sau đó cập nhật mật khẩu mới và chuyển hướng về trang Đăng nhập.

### 4. Bảng Products (Quan hệ 1 - N với Categories)
- **Entity Product (`vn.iotstar.entity.Product`)**:
  - `productId` (Khóa chính tự tăng), `productName`, `description`, `price`, `images`, `quantity`, `status`, `createdDate`.
  - Liên kết `@ManyToOne @JoinColumn(name = "CategoryId") Category category`.
- **Entity Category (`vn.iotstar.entity.Category`)**:
  - Liên kết `@OneToMany(mappedBy = "category") List<Product> products`.

### 5. Quản trị CRUD Sản Phẩm Cho Admin
- **Danh sách sản phẩm (`/admin/products`)**: Hiển thị bảng dữ liệu gồm ảnh, tên, giá bán, danh mục, số lượng, trạng thái, thao tác.
- **Thêm sản phẩm mới (`/admin/product/add`)**: Form chọn danh mục bằng Dropdown, tải ảnh lên từ máy tính (lưu vào `d:\upload`) hoặc nhập link online.
- **Chỉnh sửa sản phẩm (`/admin/product/edit`)**: Xem ảnh cũ, thay đổi thông tin và upload ảnh mới (tự động xóa ảnh cũ trên đĩa).
- **Xóa sản phẩm (`/admin/product/delete`)**: Xóa sản phẩm khỏi CSDL.

### 6. Hiển thị 10 Sản Phẩm Mới Nhất Lên Trang Chủ (`/home`)
- Trang chủ tự động truy vấn 10 sản phẩm mới nhất đang kinh doanh (`status = 1`).
- Hiển thị dạng lưới thẻ sản phẩm (Product Cards) hiện đại, có hình ảnh, giá bán, danh mục và nút "Xem chi tiết".

### 7. Phân Trang 6 Sản Phẩm / Trang Tại URL `/product`
- Hiển thị tất cả sản phẩm đang kinh doanh với phân trang chuẩn **6 sản phẩm / trang**.
- Thanh phân trang linh hoạt: `« Trước`, `1`, `2`, ..., `Tiếp »`.

### 8. Xem Chi Tiết 01 Sản Phẩm (`/product/detail?id=...`)
- Khi người dùng click vào sản phẩm từ Trang chủ (`/home`) hoặc trang Danh sách (`/product`), hệ thống mở trang chi tiết sản phẩm.
- Hiển thị: Hình ảnh lớn sắc nét, tên sản phẩm, danh mục, giá tiền, số lượng tồn kho, mô tả chi tiết, nút mua hàng và danh sách các sản phẩm liên quan cùng danh mục.

---

## 3. Danh Sách URL Chính
| Chức Năng | URL | Phương Thức | Mô Tả |
|---|---|---|---|
| Trang chủ | `/home` | GET | Hiển thị 10 sản phẩm mới nhất |
| Danh sách sản phẩm | `/product` | GET | Phân trang 6 sp/trang |
| Chi tiết sản phẩm | `/product/detail?id=...` | GET | Xem chi tiết 01 sản phẩm |
| Đăng ký | `/register` | GET/POST | Đăng ký & gửi OTP kích hoạt |
| Xác thực OTP | `/verify-otp` | GET/POST | Kích hoạt tài khoản bằng OTP |
| Gửi lại OTP | `/resend-otp` | GET | Gửi lại mã OTP vào email |
| Đăng nhập | `/login` | GET/POST | Đăng nhập & kiểm tra kích hoạt |
| Quên mật khẩu | `/forgot-password` | GET/POST | Yêu cầu gửi OTP đặt lại mật khẩu |
| Đặt lại mật khẩu | `/reset-password` | GET/POST | Nhập OTP và đổi mật khẩu mới |
| Đăng xuất | `/logout` | GET | Xóa session & cookie |
| QL Sản phẩm Admin | `/admin/products` | GET | Danh sách sản phẩm |
| Thêm sản phẩm | `/admin/product/add` | GET/POST | Thêm sản phẩm mới kèm ảnh |
| Sửa sản phẩm | `/admin/product/edit` | GET/POST | Cập nhật sản phẩm |
| QL Danh mục Admin | `/admin/categories` | GET | Quản lý danh mục |
| Tải ảnh | `/image?fname=...` | GET | Stream hình ảnh từ ổ cứng |

---

## 4. Hướng Dẫn Triển Khai & Kiểm Thử
* **Đường dẫn ứng dụng**: Ứng dụng đã được cấu hình chạy trực tiếp tại Root Context (`http://localhost:8080/`), không cần tiền tố thư mục.
* **Cơ sở dữ liệu**: MySQL CSDL `servletjpa`, tự động cập nhật schema với Hibernate.
* **Mã hóa bảo mật**: Đã tích hợp và kiểm thử giải thuật BCrypt (rounds 12) cho toàn bộ mật khẩu người dùng (`PasswordUtil.java`).
* **Kiểm thử tính năng**: Đã kiểm thử thành công 100% các chức năng:
  - Đăng ký tài khoản, sinh và gửi OTP kích hoạt qua Email.
  - Kích hoạt tài khoản và gửi lại OTP.
  - Đăng nhập xác thực BCrypt, ghi nhớ Cookie và phân quyền điều hướng (Admin/User).
  - Quên mật khẩu, xác thực OTP và đặt lại mật khẩu mới.
  - CRUD Quản lý Danh mục và Sản phẩm (upload hình ảnh lên ổ đĩa).
  - Hiển thị Top 10 sản phẩm mới nhất tại trang chủ (`/home`).
  - Phân trang chuẩn 6 sản phẩm / trang tại `/product`.
  - Xem chi tiết sản phẩm và gợi ý sản phẩm cùng danh mục (`/product/detail`).

---

## 5. Hướng Dẫn Dành Cho Giảng Viên / Người Chấm (Clone & Mở Dự Án Nhanh Nhất)

### Bước 1: Clone và Import vào IDE
1. Clone dự án từ GitHub:
   ```bash
   git clone https://github.com/Phucsbinz/24133045_BuiThanhPhuc_BTap03.git
   ```
2. Mở Eclipse / STS / IntelliJ:
   - Chọn **File -> Import... -> Existing Maven Projects** -> Trỏ đến thư mục vừa clone -> Nhấn **Finish**.
   - Maven sẽ tự động tải các thư viện cần thiết (JPA 3.0, Hibernate 6.6, jBCrypt, Jakarta Mail, MySQL Connector).

### Bước 2: Cấu hình Cơ sở dữ liệu MySQL
* Mở file: `src/main/resources/META-INF/persistence.xml`
* Cập nhật `password` của MySQL cho khớp với máy cá nhân:
  ```xml
  <property name="jakarta.persistence.jdbc.user" value="root" />
  <property name="jakarta.persistence.jdbc.password" value="mat_khau_mysql_cua_ban" />
  ```
* Chuỗi kết nối JDBC đã được tích hợp `createDatabaseIfNotExist=true`, do đó MySQL sẽ tự động khởi tạo cơ sở dữ liệu `servletjpa` nếu chưa có.

### Bước 3: Khởi tạo dữ liệu mẫu (Có sẵn 2 cách thuận tiện)
* **Cách 1 (Nhanh nhất)**: Import trực tiếp file SQL có sẵn ở thư mục gốc: `database_servletjpa.sql` vào MySQL.
* **Cách 2**: Chạy class Seeder có sẵn trong mã nguồn:
  - Mở file `src/main/java/vn/iotstar/config/ProductSeeder.java`
  - Chuột phải chọn **Run As -> Java Application**. Hệ thống tự động tạo các danh mục và 12 sản phẩm mẫu kèm hình ảnh.

### Bước 4: Tài khoản Test có sẵn
Hệ thống đã mã hóa mật khẩu chuẩn BCrypt. Các tài khoản test có sẵn:
| Vai trò | Tên đăng nhập | Mật khẩu mặc định |
|---|---|---|
| Quản trị viên (Admin) | `admin` | `123456` |
| Quản lý (Manager) | `manager` | `123456` |
| Người dùng (User) | `phuc` | `123456` |

### Bước 5: Chạy dự án trên Tomcat
1. Thêm dự án vào Apache Tomcat (v10.1 hoặc v11.0).
2. Chuột phải vào project -> **Run As -> Run on Server**.
3. Truy cập hệ thống tại:
   - Trang Đăng nhập: `http://localhost:8080/login` (hoặc `http://localhost:8080/BaiTap02/login`). Hệ thống hỗ trợ tương thích hoàn toàn cả 2 định dạng đường dẫn.
   - Trang chủ Sản phẩm: `http://localhost:8080/home` (hoặc `http://localhost:8080/BaiTap02/home`).

### Bước 6: Cấu hình Upload ảnh & Gửi Mail OTP
* **Thư mục Upload ảnh**: Đã được xử lý tự động nhận diện an toàn (`Constant.java`). Ưu tiên lưu tại `D:\upload`. Nếu máy không có ổ `D:`, hệ thống tự động lưu vào thư mục `upload` của người dùng (`~/upload`), đảm bảo không phát sinh lỗi đường dẫn trên mọi hệ điều hành.
* **Email OTP**: Cấu hình tại `vn.iotstar.util.EmailUtil.java`. Đã tích hợp sẵn Gmail SMTP với cơ chế gửi bất đồng bộ qua đa luồng (`ExecutorService`).

