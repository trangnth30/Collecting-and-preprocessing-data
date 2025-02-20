# Dự Báo Thời Tiết

## Thành viên thực hiện

### **Giảng viên hướng dẫn**
- **TS. Nguyễn Gia Tuấn Anh**
- **Th.S Trần Quốc Khánh**

### **Nhóm sinh viên thực hiện**
- **Huy Chan Huynh**
- **Trang Huyen Thi Nguyen**

## Môn học
- DS103.N21 - Thu thập và tiền xử lý dữ liệu
## Giới thiệu

Dự báo thời tiết là một bài toán quan trọng trong đời sống hàng ngày, giúp con người đưa ra quyết định chính xác và kịp thời. Dự án này tập trung vào việc **xây dựng một hệ thống dự báo thời tiết ngắn hạn (trong 3 giờ tiếp theo)** cho khu vực **Thành phố Hồ Chí Minh** bằng cách sử dụng **các mô hình học máy (Machine Learning)**.

Hệ thống này sử dụng **dữ liệu thời tiết lịch sử**, thu thập từ WorldWeatherOnline, và áp dụng các thuật toán dự báo để phân loại thời tiết thành hai nhóm: **mưa** và **không mưa**. Mục tiêu chính của dự án là đạt độ chính xác cao nhất có thể, với **độ chính xác kỳ vọng trên 80%**.

---

## Mục tiêu của dự án

- **Thu thập dữ liệu thời tiết lịch sử** từ **01/01/2020 - 30/04/2023**.
- **Tiền xử lý dữ liệu** để đảm bảo chất lượng cao, bao gồm loại bỏ nhiễu, chuẩn hóa và rút trích đặc trưng.
- **Xây dựng mô hình dự báo thời tiết ngắn hạn** (trong vòng 3 giờ) bằng cách sử dụng:
  - **Logistic Regression**
  - **XGBClassifier (Extreme Gradient Boosting)**
  - **Support Vector Classifier (SVC)**
- **So sánh độ chính xác của các mô hình** và chọn ra mô hình tốt nhất.
- **Hiển thị kết quả dự báo** trên giao diện trực tuyến hoặc ứng dụng di động.

---

## Bộ dữ liệu

- **Nguồn dữ liệu**: Thu thập từ **WorldWeatherOnline**.
- **Phương thức thu thập**: Dùng thư viện `selenium` trong Python để crawl dữ liệu.
- **Thời gian thu thập**: **01/01/2020 - 30/04/2023**.
- **Khoảng thời gian dữ liệu**: Mỗi bản ghi cách nhau **3 giờ**.
- **Các thuộc tính quan trọng**:
  - `Hour`: Giờ thu thập dữ liệu.
  - `Temperature`: Nhiệt độ thực tế (°C).
  - `Forecast`: Nhiệt độ cảm nhận (°C).
  - `Rain`: Lượng mưa (mm).
  - `Rain-rate`: Độ ẩm (%) chuẩn hóa về [0,1].
  - `Cloud-rate`: Độ che phủ mây (%) chuẩn hóa về [0,1].
  - `Pressure`: Áp suất không khí (mb).
  - `Wind`: Tốc độ gió trung bình (km/h).
  - `Gust`: Tốc độ gió cao nhất (km/h).
  - `Day`, `Month`, `Year`: Thời gian.

📌 **Tổng số điểm dữ liệu**: **16,528 bản ghi**.

---

## Các phương pháp xử lý dữ liệu

### 1️⃣ **Tiền xử lý dữ liệu**
- **Loại bỏ dữ liệu nhiễu và thiếu**: Sử dụng `drop()`, `rename()` và `fillna()`.
- **Chuẩn hóa dữ liệu**:
  - Chuyển đổi các thuộc tính sang kiểu số (`float`).
  - Chuẩn hóa **Rain-rate** và **Cloud-rate** về khoảng **[0,1]**.
- **Rút trích đặc trưng**:
  - Biến **Weather** được chuyển thành nhãn nhị phân: **0 (Không mưa)** và **1 (Mưa)**.
  - Loại bỏ **Day, Month, Year** hoặc nhóm **Month** theo **mùa mưa và mùa nắng** để cải thiện mô hình.

---

## Mô hình học máy sử dụng

### 🔹 **1. Logistic Regression**
- Phù hợp cho **bài toán phân loại nhị phân (mưa/không mưa)**.
### 🔹 **2. XGBClassifier (Extreme Gradient Boosting)**
- Áp dụng **Gradient Boosting Decision Trees (GBDT)**.
- Học từ các lỗi của mô hình trước để cải thiện dự báo.
- Là một trong những mô hình hiệu quả nhất hiện nay.

### 🔹 **3. SVC (Support Vector Classifier)**
- Phân loại dữ liệu bằng **mặt phẳng siêu phẳng (hyperplane)**.
- Hoạt động tốt với dữ liệu phi tuyến tính nhưng **tốc độ huấn luyện chậm**.

---

## Đánh giá mô hình

Dưới đây là kết quả đánh giá mô hình trên **bộ dữ liệu đã xử lý**:

| Mô hình                | Accuracy | Precision | Recall | F1-score | Thời gian huấn luyện (s) |
|------------------------|----------|-----------|--------|---------|--------------------------|
| **Logistic Regression** | 83.44%   | 70.38%    | 74.96% | 70.98%  | 0.021                    |
| **XGBClassifier**      | **95.15%** | **85.75%** | **88.26%** | **86.85%** | 0.273                    |
| **SVC**               | 88.12%   | 75.52%    | 79.51% | 76.79%  | **42.912** (rất lâu)      |

📌 **Nhận xét**:
- **XGBClassifier đạt độ chính xác cao nhất (95.15%)** và thời gian huấn luyện hợp lý.
- **Logistic Regression nhanh nhưng độ chính xác thấp hơn**.
- **SVC có thời gian huấn luyện rất lâu (42.9s), không phù hợp**.

---

## Hướng phát triển trong tương lai

- **Thu thập thêm dữ liệu thời tiết** từ nhiều nguồn khác nhau.
- **Tích hợp thêm yếu tố khí hậu** (mùa, hiện tượng tự nhiên) để cải thiện dự báo.
- **Sử dụng Deep Learning (LSTM, CNN)** để dự báo thời tiết chính xác hơn.
- **Triển khai API dự báo thời tiết** trên web/app để người dùng sử dụng trực tiếp.
