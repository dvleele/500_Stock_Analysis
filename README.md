Dự án : Trực quan hóa 505 mã cổ phiếu trên thị trường Mỹ trong giai đoạn 5 năm (2013–2018) .

---


Công Cụ Sử Dụng

- Python: Làm sạch dữ liệu, xử lý file CSV, sơ lược dữ liệu
- Power BI: Tạo dashboard tương tác
- Data: S&P 500 stock data (Kaggle)

---
File trong Dự Án

- Dashboard.pbix : File Power BI chứa dashboard hoàn chỉnh 
- 500_Stock.ipynb: Notebook tiền xử lý dữ liệu CSV đầu vào
- 500_Stock.csv: Dữ liệu
- README.md Mô tả dự án chi tiết dự án

---
Dashboard gồm các thành phần chính:

- Bộ lọc: Tùy chọn khoảng thời gian từ 2013–2018
- Tổng số ticker: 505 mã cổ phiếu được phân tích
- Cổ phiếu tăng trưởng cao nhất: "CHD" với mức tăng 80.58%
- Biểu đồ khối lượng giao dịch (Volume Trend): Column Chart
- Top 5 cổ phiếu tăng trưởng cao nhất: Bar Chart
- Xu hướng giá đóng cửa: Theo thời gian đối với các mã AMZN, GOOG, GOOGL, PCLN
- Bảng Volume Spike: Ticker có khối lượng giao dịch cao nhất toàn kỳ

---
![image](https://github.com/user-attachments/assets/b76dd712-25cd-475f-84b4-c113e2f72f14)
Insights

1. Cổ phiếu tăng trưởng ổn định
- `CHD` dẫn đầu mức tăng trưởng với 80.58%, điều này cho thấy phù hợp chiến lược đầu tư dài hạn.
- `FTV`, `WMB`, `CHK`, `AMD` cũng tăng đáng kể

2. Khối lượng giao dịch và thanh khoản
- `BAC`, `AAPL`, `FB`, `GE`, `F` có khối lượng giao dịch cao, thể hiện mức độ quan tâm về những cổ phiếu này và cho thấy thanh khoản cao.
- Nhà đầu tư ngắn hạn có thể ưu tiên các mã này để đảm bảo khả năng khớp lệnh và giảm rủi ro trượt giá.

3. Nhóm ngành công nghệ tăng đều
- `GOOGL`, `AMZN`, `PCLN` cho thấy xu hướng giá tăng ổn định theo năm, điều này cũng chứng minh đươc ngành công nghệ là lĩnh vực HOT và có tiềm năng đầu tư dài hạn.

4. Sự sụt giảm volume năm 2018
- Hầu hết các mã cổ phiếu có khối lượng giao dịch giảm mạnh trong năm 2018.
- Cần theo dõi thêm các yếu tố vĩ mô (lãi suất, chiến tranh thương mại...) để lý giải xu hướng này.




