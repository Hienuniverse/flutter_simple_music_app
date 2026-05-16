# 🎵 Ứng dụng Nghe nhạc Offline Cơ bản (Simple Offline Music Player)

## 📖 Mô tả Dự án và Tính năng
Simple Offline Music Player là một ứng dụng nghe nhạc nội bộ (offline) đa nền tảng được xây dựng hoàn toàn bằng Flutter. Ứng dụng tự động quét các file âm thanh trong bộ nhớ máy và mang lại trải nghiệm nghe nhạc mượt mà với giao diện hiện đại (Dark Theme) mang phong cách Spotify.

**Các tính năng cốt lõi:**
* **Thư viện Âm nhạc:** Tự động lấy và hiển thị tất cả các file âm thanh cục bộ (MP3, M4A, WAV, v.v.) từ bộ nhớ thiết bị.
* **Phát nhạc:** Đầy đủ các nút điều khiển như Phát, Tạm dừng, Chuyển bài (Tiếp theo/Trước đó) và Tua nhạc (Seek).
* **Điều khiển Trình phát:** Hỗ trợ chế độ Phát ngẫu nhiên (Shuffle) và Lặp lại (Tắt, Tất cả, Một bài).
* **Phát nhạc dưới nền:** Âm nhạc vẫn tiếp tục phát liền mạch ngay cả khi thu nhỏ ứng dụng hoặc khóa màn hình.
* **Quản lý Danh sách phát (Playlist):** Tạo danh sách phát tùy chỉnh, thêm/xóa bài hát và theo dõi các bài hát vừa nghe.
* **Giao diện Người dùng (UI):** Bao gồm màn hình Trang chủ với danh sách bài hát, Mini Player luôn hiển thị, màn hình Chi tiết bài hát (Now Playing) với ảnh bìa album, màn hình Tìm kiếm và màn hình Danh sách phát.
* **Lưu trữ Trạng thái:** Lưu lại bài hát nghe lần cuối, mức âm lượng, tùy chọn phát ngẫu nhiên/lặp lại và danh sách phát bằng bộ nhớ cục bộ (`shared_preferences`).

## ⚙️ Hướng dẫn Cài đặt
Để chạy dự án này trên máy của bạn, hãy làm theo các bước sau:

1. **Yêu cầu hệ thống:**
   * Đã cài đặt Flutter SDK.
   * Có máy ảo Android/iOS hoặc thiết bị thật kết nối qua cáp USB/Wireless Debugging.
2. **Clone mã nguồn (repository):**
   ```bash
   git clone [https://github.com/Hienuniverse/flutter_simple_music_app.git](https://github.com/Hienuniverse/flutter_simple_music_app.git)
   cd flutter_simple_music_app
3. **Cài đặt thự viện**
   ```bash
   flutter pub get
4. Khởi chạy ứng dụng:
    ```bash
   flutter run
## 📸 Ảnh chụp màn hình các giao diện

Màn hình chính

<img width="447" height="967" alt="image" src="https://github.com/user-attachments/assets/9c9995e1-3f21-4a49-9583-6b46a9392d84" />

Màn hình chứa các tính năng

<img width="453" height="966" alt="Screenshot 2026-05-16 141259" src="https://github.com/user-attachments/assets/4140a9f3-a76e-45f9-bf39-e65e00c2f0cd" />

Màn hình playlist và thêm playlist

<img width="456" height="1000" alt="image" src="https://github.com/user-attachments/assets/504584bf-c241-4e39-9e79-b877f241ed74" />

<img width="442" height="987" alt="image" src="https://github.com/user-attachments/assets/bb6ad1c4-4054-4d2a-b05e-494d5cb8c100" />

Màn hình thêm nhạc vào playplist

<img width="443" height="870" alt="image" src="https://github.com/user-attachments/assets/4c6bf908-ea53-4963-9559-4f3c2c352d6d" />

Màn hình tìm kiếm

<img width="456" height="882" alt="image" src="https://github.com/user-attachments/assets/e0645d2b-4e26-4eda-83c3-1ca49613c3cd" />

Màn hình setting

<img width="455" height="888" alt="image" src="https://github.com/user-attachments/assets/69d292b1-200d-4c1e-8c10-a02d4d98895f" />

🎧 Cách thêm nhạc để Kiểm thử
Nếu test trên thiết bị thật: Chỉ cần tải các file .mp3 về máy hoặc chuyển qua cáp USB. Ứng dụng sẽ tự động xin cấp quyền và quét bộ nhớ của bạn.

Nếu test trên Máy ảo Android (Emulator):

Mở trình duyệt web (ví dụ: Google Chrome) bên trong máy ảo Android.

Tải các file .mp3 mẫu từ trên mạng, hoặc kéo thả các file .mp3 từ máy tính vào màn hình máy ảo (chúng sẽ chạy vào thư mục Downloads).

Mở ứng dụng Files (Tệp) mặc định của máy ảo.

Chuyển đến thư mục Downloads, chọn các file âm thanh và Di chuyển (Move) chúng vào thư mục Internal Storage > Music. Hành động này sẽ kích hoạt bộ quét MediaStore của Android.

Mở lại ứng dụng Music Player để thấy các bài hát mới được thêm vào.

🛠 Công nghệ Sử dụng
Framework: Flutter (Dart)

1. Phát âm thanh: just_audio, audio_service, audio_session

2. Quét bộ nhớ cục bộ: on_audio_query

3. Quản lý Trạng thái: provider

4. Lưu trữ dữ liệu: shared_preferences

5. Xử lý Quyền (Permissions): permission_handler

⚠️ Hạn chế Hiện tại
Âm thanh bị rè trên Máy ảo (Emulator): Khi chạy trên một số máy ảo Android, âm thanh có thể bị rè hoặc phát sai tốc độ do giới hạn của Trình điều khiển âm thanh ảo (Virtual Audio Driver). Lỗi này không xảy ra trên thiết bị thật.

Mã hóa Metadata: Các file âm thanh có chuẩn mã hóa thẻ ID3 cũ (không phải UTF-8) có thể hiển thị sai font chữ tiếng Việt (hiện các ký tự ?).

🚀 Định hướng Phát triển Tương lai
Hẹn giờ Tắt nhạc (Sleep Timer): Cho phép người dùng cài đặt thời gian để tự động dừng phát nhạc.

Theme Động (Dynamic Theming): Trích xuất màu chủ đạo từ ảnh bìa album đang phát để tự động thay đổi màu nền giao diện (sử dụng palette_generator).

Bộ chỉnh âm (Equalizer): Tích hợp bộ chỉnh âm thanh tùy chỉnh với các thiết lập có sẵn (Tăng bass, Virtualizer).

Hiển thị Lời bài hát: Thêm hỗ trợ đọc và đồng bộ lời bài hát nếu có sẵn trong metadata của file âm thanh.
