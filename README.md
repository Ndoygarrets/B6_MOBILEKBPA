
##GUITAR VISION##
Penjelasan Lengkap Aplikasi "Guitar Chord Vision"
1. Deskripsi Aplikasi

Guitar Chord Vision adalah aplikasi mobile berbasis Flutter yang mampu mendeteksi chord gitar secara otomatis dari gambar menggunakan teknologi Computer Vision + Machine Learning.

User cukup:

membuka kamera atau galeri,

mengambil foto gitar / fret,

lalu sistem akan memprediksi chord apa yang dimainkan.

Aplikasi ini sangat membantu pemula yang ingin belajar gitar lebih mudah dan cepat tanpa harus menebak-nebak chord.

⭐ 2. Fitur Utama
✔ 1. Deteksi Chord Gitar Otomatis

Aplikasi mengirimkan gambar ke backend Machine Learning, lalu server mengembalikan hasil prediksi chord.

✔ 2. Upload Gambar dari Kamera atau Galeri

Menggunakan package Flutter:

image_picker

http

✔ 3. Tampilan Modern & Simpel

Desain onboarding dan UI dibuat agar mudah dipahami.

⚙️ 3. Cara Menggunakan Aplikasi

Buka aplikasi Guitar Chord Vision

Pilih salah satu:

📸 Ambil Foto

🖼️ Pilih dari Galeri

Setelah gambar dipilih, aplikasi akan:

mengirim file ke server API

menunggu hasil prediksi

Hasil yang tampil:

Nama chord (misalnya: C, G, Am, Em)

Akurasi model

Selesai! Chord sudah terlihat dalam aplikasi.

🔧 4. Cara Kerja Sistem (Flow Aplikasi)
Flutter App → Upload Image → Django API → Model CNN → Prediksi Chord → Kirim Balik ke Flutter

🧠 5. Teknologi yang Digunakan
Frontend

Flutter

Dart

Image Picker

HTTP Request

Backend

Python

Django REST Framework

Machine Learning Model (CNN)

GitHub + Git LFS untuk penyimpanan model besar

Tools tambahan

Ngrok / LocalTunnel (untuk testing API online)

Git Bash (push project ke GitHub)
LINK APK https://drive.google.com/drive/folders/1FbkyaPmBX9a9XqZODXxvJVwOVkgmW4mj?usp=drive_link
