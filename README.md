# 🎵 Simple Offline Music Player

Một ứng dụng nghe nhạc offline đa nền tảng được xây dựng bằng Flutter. Ứng dụng cho phép người dùng quét các file âm thanh trên thiết bị, quản lý danh sách phát và trải nghiệm trình phát nhạc với giao diện hiện đại (Dark Theme) mang phong cách Spotify.

Đây là dự án học thuật được phát triển nhằm đáp ứng các yêu cầu về quản lý trạng thái, truy cập tệp cục bộ và xử lý âm thanh chạy nền trong Flutter.

## ✨ Tính năng nổi bật (Features)

* **Quản lý Thư viện Nhạc:** Tự động quét và hiển thị tất cả các bài hát từ bộ nhớ thiết bị.
* **Trình phát Âm thanh Toàn diện:** Hỗ trợ Phát/Tạm dừng, Chuyển bài (Next/Previous), và Tua (Seek) chính xác.
* **Điều khiển Nâng cao:** Chế độ phát ngẫu nhiên (Shuffle) và Lặp lại (Repeat Off/All/One).
* **Phát nhạc chạy nền (Background Playback):** Âm nhạc vẫn tiếp tục phát ngay cả khi thu nhỏ ứng dụng hoặc tắt màn hình.
* **Giao diện Người dùng (UI):** * Màn hình chính (Home) với danh sách bài hát.
    * Mini Player luôn hiển thị dưới đáy màn hình.
    * Màn hình Now Playing chi tiết với hiệu ứng bóng đổ và thanh tiến trình.
* **Lưu trữ Trạng thái (Persistence):** Tự động lưu lại bài hát cuối cùng, trạng thái Shuffle/Repeat và mức âm lượng bằng `shared_preferences`.
* **Xử lý Quyền thông minh:** Tương thích với cả thiết bị Android cũ (Storage Permission) và Android 13+ (Audio Permission).

## 🛠 Công nghệ sử dụng (Technologies Used)

* **Framework:** Flutter & Dart
* **Audio Playback:** `just_audio`, `audio_service`, `audio_session`
* **Truy xuất Dữ liệu Local:** `on_audio_query` (v2.9.0)
* **Quản lý Trạng thái (State Management):** `provider`
* **Xử lý Bất đồng bộ (Reactive):** `rxdart`
* **Lưu trữ dữ liệu (Local Storage):** `shared_preferences`
* **Quản lý Quyền (Permissions):** `permission_handler`

## 🚀 Hướng dẫn Cài đặt (Setup Instructions)

1. **Clone repository:**
   ```bash
   git clone [https://github.com/Hienuniverse/flutter_simple_music_app.git](https://github.com/Hienuniverse/flutter_simple_music_app.git)
   cd flutter_simple_music_app
2. **Giao diện**
<img width="1920" height="1080" alt="Screenshot 2026-05-15 234054" src="https://github.com/user-attachments/assets/0a05f731-0414-4bfb-a651-30a4a0a8fcf9" />
