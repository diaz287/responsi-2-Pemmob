# Responsi 2 Mobile Paket 2 - [ISI NIM ANDA]

Aplikasi Inventaris Bahan Makanan untuk Supermarket (Studi Kasus: Abimart). Aplikasi ini dibangun menggunakan **Flutter** sebagai Frontend dan **CodeIgniter 4** sebagai Backend (RESTful API).

## 👨‍🎓 Data Diri
* **Nama:** KHAFRIZA DIAZ PERMANA
* **NIM:** H1D023072
* **Shift Asal:** F
* **Shift Baru:** D

## 🎥 Demo Aplikasi
Berikut adalah link video demo penggunaan aplikasi ini:
https://github.com/user-attachments/assets/e8b344eb-3e2e-43de-a868-6798fd9e1cfd
---

## 📡 Spesifikasi API
Aplikasi ini menggunakan RESTful API yang dibuat dengan CodeIgniter 4. Berikut adalah spesifikasi endpoint yang digunakan:

| Fitur | Endpoint | Method | Keterangan |
| :--- | :--- | :--- | :--- |
| **Registrasi** | `/registrasi` | `POST` | Mendaftarkan akun member baru. Mengirim data: `nama`, `email`, `password`. |
| **Login** | `/login` | `POST` | Autentikasi user. Mengirim data: `email`, `password`. Menerima respon: `token`, `userID`. |
| **List Barang** | `/barang` | `GET` | Mengambil semua data inventaris barang. |
| **Tambah Barang** | `/barang` | `POST` | Menambahkan data barang baru. Mengirim data: `nama_barang`, `harga`, `jumlah`, `tanggal_masuk`, `tanggal_kedaluwarsa`. |
| **Detail Barang** | `/barang/{id}` | `GET` | Mengambil detail satu barang berdasarkan ID. |
| **Ubah Barang** | `/barang/{id}` | `PUT` | Mengupdate data barang berdasarkan ID. Mengirim data JSON body. |
| **Hapus Barang** | `/barang/{id}` | `DELETE` | Menghapus data barang berdasarkan ID. |

---

## 💻 Penjelasan Kode & Fungsi

Berikut adalah penjelasan struktur kode dan fungsi utama dalam aplikasi ini:

### 1. Helper & Utilitas (`lib/helpers/`)
* **`api.dart`**: Class `Api` menangani semua request HTTP (`POST`, `GET`, `PUT`, `DELETE`) ke server. Class ini otomatis menyisipkan **Token Bearer** dan header `Content-Type: application/json` agar komunikasi data berjalan lancar.
* **`api_url.dart`**: Menyimpan konstanta URL endpoint server agar mudah dikelola satu pintu. Menggunakan IP Laptop lokal.
* **`user_info.dart`**: Mengelola penyimpanan sesi lokal menggunakan `SharedPreferences`. Berfungsi menyimpan dan mengambil `token` login serta `userID`.
* **`app_exception.dart`**: Menangani pesan error standar jika terjadi masalah koneksi atau respon server error.

### 2. Business Logic Component (`lib/bloc/`)
* **`login_bloc.dart`**: Menangani logika login. Mengirim email/password ke API dan memparsing respon JSON menjadi objek Model Login.
* **`registrasi_bloc.dart`**: Menangani logika pendaftaran member baru.
* **`barang_bloc.dart`**: Jembatan antara UI dan API untuk fitur Inventaris.
    * `getBarangs()`: Mengambil list barang.
    * `addBarang()`: Mengirim data barang baru.
    * `updateBarang()`: Mengirim perubahan data barang (Encode JSON).
    * `deleteBarang()`: Menghapus barang.
* **`logout_bloc.dart`**: Menghapus sesi token dari memori HP.

### 3. Model Data (`lib/model/`)
* **`barang.dart`**: Representasi objek Barang. Memetakan JSON dari API (field: `nama_barang`, `harga`, `jumlah`, dll) menjadi objek Dart.
* **`login.dart` & `registrasi.dart`**: Model untuk menampung respon hasil login dan registrasi.

### 4. User Interface (`lib/ui/`)
* **`main.dart`**: Pintu masuk aplikasi. Mengecek apakah user sudah memiliki token login. Jika sudah, langsung ke `BarangPage`, jika belum ke `LoginPage`. Mengatur tema aplikasi menjadi **Hijau (`Colors.green`)**.
* **`login_page.dart`**: Halaman login user. Memvalidasi input email & password sebelum dikirim ke Bloc.
* **`registrasi_page.dart`**: Halaman pendaftaran user baru.
* **`barang_page.dart`**: Halaman utama yang menampilkan daftar inventaris. Menggunakan `FutureBuilder` untuk me-load data dari API dan menampilkannya dalam `ListView`. Terdapat menu **Logout** di Drawer.
* **`barang_detail.dart`**: Menampilkan detail lengkap barang (Nama, Harga, Stok, Tgl Masuk, Tgl Exp). Memiliki tombol **Edit** dan **Delete**.
* **`barang_form.dart`**: Halaman formulir yang berfungsi ganda:
    * Sebagai **Tambah Barang** jika dibuka dari tombol (+).
    * Sebagai **Ubah Barang** jika dibuka dari tombol Edit (form terisi otomatis data lama).

### 5. Widget Kustom (`lib/widget/`)
* **`success_dialog.dart`**: Pop-up dialog hijau untuk notifikasi sukses.
* **`warning_dialog.dart`**: Pop-up dialog merah untuk notifikasi gagal/error.

---
**Responsi 2 Pemrograman Mobile - 2025**
