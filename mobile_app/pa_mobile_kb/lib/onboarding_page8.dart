import 'dart:io';
import 'package:flutter/material.dart';
import 'onboarding_page4.dart';
import 'onboarding_page5.dart';
import 'onboarding_page6.dart';
import 'onboarding_page9.dart';
import 'chord_history.dart'; // daftar riwayat deteksi sementara
import 'chord_library.dart'; // file library chord (ChordData, ChordDiagram, chordList)

class OnboardingPage8 extends StatelessWidget {
  const OnboardingPage8({super.key});

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5F2),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F5F2),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF5D3A1A)),
          onPressed: () => _navigateTo(context, const OnboardingPage4()),
        ),
        title: const Text(
          "RIWAYAT DETEKSI",
          style: TextStyle(
            color: Color(0xFF5D3A1A),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: detectedChordHistory.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.history, size: 90, color: Color(0xFF5D3A1A)),
                      SizedBox(height: 10),
                      Text(
                        "Belum ada riwayat deteksi.\nMulai deteksi chord sekarang!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF5D3A1A),
                        ),
                      ),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.95,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: detectedChordHistory.length,
                  itemBuilder: (context, index) {
                    final item = detectedChordHistory[index];

                    // Cek apakah chord ada di library
                    final chordFromLibrary = chordList.firstWhere(
                      (chord) => chord.name == item.chordResult,
                      orElse: () => ChordData(
                        name: item.chordResult,
                        dots: [],
                        open: [],
                        barre: null,
                      ),
                    );

                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        border: Border.all(color: Colors.brown.shade300, width: 1.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          children: [
                            Text(
                              chordFromLibrary.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4B2E05),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Expanded(
                              child: Center(
                                child: item.imagePath.isNotEmpty
                                    ? Image.file(
                                        File(item.imagePath),
                                        fit: BoxFit.cover,
                                      )
                                    : ChordDiagram(
                                        title: chordFromLibrary.name,
                                        fingerDots: chordFromLibrary.dots,
                                        openStrings: chordFromLibrary.open,
                                        barre: chordFromLibrary.barre,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),

      // Tombol Mulai Deteksi
      bottomNavigationBar: Container(
        color: const Color(0xFFF7F5F2),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _BottomNavItem(
              icon: Icons.home,
              label: "Beranda",
              active: false,
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
              active: true,
              onTap: () {},
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
    );
  }
}

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
          Icon(icon, color: active ? const Color(0xFF5D3A1A) : Colors.grey),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: active ? const Color(0xFF5D3A1A) : Colors.grey,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
