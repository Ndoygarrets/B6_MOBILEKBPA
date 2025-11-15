import 'package:flutter/material.dart';
import 'onboarding_page4.dart'; // pastikan file ini sudah dibuat

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo di pojok kiri atas
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/guitar_vision_logo.png',
                  height: 120,
                ),
              ),
            ),

            // Gambar utama (jam)
            Image.asset(
              'assets/gambar_jam.png', // ganti sesuai nama file gambar kamu
              height: 250,
              fit: BoxFit.cover,
            ),

            // Deskripsi
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Text(
                'Lihat kembali hasil dan riwayat analisis gitar Anda. '
                'Fitur ini menyimpan catatan permainan sebelumnya agar Anda '
                'dapat memantau, membandingkan, dan belajar dari setiap sesi '
                'permainan gitar Anda.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ),

            // Tombol NEXT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4E2C1E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 3,
                  ),
                  onPressed: () {
                    // Navigasi ke Onboarding Page 4
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            FadeTransition(
                          opacity: animation,
                          child: const OnboardingPage4(),
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'NEXT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Indikator halaman (3 titik)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDot(isActive: false),
                const SizedBox(width: 8),
                _buildDot(isActive: false),
                const SizedBox(width: 8),
                _buildDot(isActive: true), // titik aktif di halaman ke-3
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF4E2C1E) : Colors.black26,
        shape: BoxShape.circle,
      ),
    );
  }
}
