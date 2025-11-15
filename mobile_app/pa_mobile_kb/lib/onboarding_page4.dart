import 'package:flutter/material.dart';
import 'onboarding_page5.dart';
import 'onboarding_page8.dart';
import 'onboarding_page9.dart';

class OnboardingPage4 extends StatelessWidget {
  const OnboardingPage4({super.key});

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5F2),

      // 🔽 Bottom Navigation Bar
      bottomNavigationBar: Container(
        color: const Color(0xFFF7F5F2),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _BottomNavItem(
              icon: Icons.home,
              label: "Beranda",
              active: true,
              onTap: () => _navigateTo(context, const OnboardingPage4()),
            ),
            _BottomNavItem(
              icon: Icons.camera_alt,
              label: "Deteksi",
              active: false,
              onTap: () => _navigateTo(context, const OnboardingPage5()),
            ),
            _BottomNavItem(
              icon: Icons.history,
              label: "Riwayat",
              active: false,
              onTap: () => _navigateTo(context, const OnboardingPage8()),
            ),
            _BottomNavItem(
              icon: Icons.menu_book,
              label: "Library",
              active: false,
              onTap: () => _navigateTo(context, const OnboardingPage9()),
            ),
          ],
        ),
      ),

      // 🔽 Body
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/guitar_vision_logo.png',
                  height: 200,
                ),

                const SizedBox(height: 12),
                Text(
                  "Deteksi chord gitar secara menggunakan kamera atau foto.\n"
                  "Teknologi AI untuk membantu perjalanan musik Anda.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[800],
                  ),
                ),

                const SizedBox(height: 36),

                // 🟤 Tombol Mulai Deteksi — Ke OnboardingPage5
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OnboardingPage5(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.camera_alt, color: Colors.white),
                  label: const Text(
                    "Mulai Deteksi",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5D3A1A),
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // 🟤 Tombol Lihat Library — Ke OnboardingPage9
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OnboardingPage9(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.menu_book, color: Color(0xFF5D3A1A)),
                  label: const Text(
                    "Lihat Library",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5D3A1A),
                      fontSize: 16,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF5D3A1A)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 36),

                const Text(
                  "Fitur Utama",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D3A1A),
                  ),
                ),

                const SizedBox(height: 16),

                _buildFeatureCard(
                  icon: Icons.camera_alt_outlined,
                  title: "Foto Langsung Untuk Mendeteksi",
                  desc:
                      "Deteksi chord secara langsung menggunakan kamera atau upload foto untuk analisis instan.",
                ),
                const SizedBox(height: 12),

                _buildFeatureCard(
                  icon: Icons.library_music_outlined,
                  title: "Chord Library",
                  desc:
                      "Database lengkap chord gitar dengan diagram dan informasi posisi jari yang akurat.",
                ),
                const SizedBox(height: 12),

                _buildFeatureCard(
                  icon: Icons.history_outlined,
                  title: "Riwayat Deteksi",
                  desc:
                      "Simpan dan lihat kembali semua chord yang pernah Anda deteksi untuk referensi kapan saja.",
                ),

                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🟤 Kartu fitur
  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String desc,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF5D3A1A), width: 0.8),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
            offset: const Offset(0, 2),
          )
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF5D3A1A), size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xFF5D3A1A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// 🔸 Widget Reusable untuk item Bottom Navigation
class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              color: active ? const Color(0xFF5D3A1A) : Colors.black45,
              size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: active ? const Color(0xFF5D3A1A) : Colors.black45,
              fontWeight: active ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
