import 'package:flutter/material.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/guitar_vision_logo.png',
                  height: 120, // lebih besar dari sebelumnya (80)
                ),
              ),
            ),

            // Gambar utama
            Image.asset(
              'assets/guitar_play.png',
              height: 250,
              fit: BoxFit.cover,
            ),

            // Teks deskripsi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: const Text(
                'Deteksi chord gitar secara menggunakan kamera atau foto. '
                'Teknologi AI untuk membantu perjalanan musik Anda.',
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
                    Navigator.pushNamed(context, '/onboarding2');
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

            // Indikator halaman
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDot(isActive: true),
                const SizedBox(width: 8),
                _buildDot(isActive: false),
                const SizedBox(width: 8),
                _buildDot(isActive: false),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Widget bulatan indikator
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
