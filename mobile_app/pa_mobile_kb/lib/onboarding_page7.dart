import 'dart:io';
import 'package:flutter/material.dart';
import 'chord_library.dart';
import 'onboarding_page5.dart';
import 'onboarding_page6.dart';
import 'onboarding_page8.dart';
import 'onboarding_page9.dart'; // untuk akses chordList dan ChordDiagram

class OnboardingPage7 extends StatelessWidget {
  final String imagePath; // path gambar dari Page5
  final String chordResult; // hasil chord yang terdeteksi

  const OnboardingPage7({
    super.key,
    required this.imagePath,
    required this.chordResult,
  });

  void _onNavTap(BuildContext context, int index) {
    switch (index) {
      case 0: // Home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingPage5()),
        );
        break;
      case 1: // Deteksi Chord
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingPage6()),
        );
        break;
      case 2: // Riwayat
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingPage8()),
        );
        break;
      case 3: // Library Chord / Tips
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingPage9()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Cari chord yang sesuai
    ChordData? detectedChord;
    try {
      detectedChord = chordList.firstWhere(
        (chord) => chord.name.toUpperCase() == chordResult.toUpperCase(),
      );
    } catch (e) {
      detectedChord = null;
    }


    return Scaffold(
      backgroundColor: const Color(0xFFF7F5F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F5F2),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF5D3A1A)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "HASIL DETEKSI",
                style: TextStyle(
                  color: Color(0xFF5D3A1A),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 20),

              // Kotak menampilkan hasil tangkap gambar
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFF5D3A1A), width: 1),
                ),
                child: imagePath.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(File(imagePath), fit: BoxFit.cover),
                      )
                    : const Center(
                        child: Icon(
                          Icons.music_note,
                          size: 60,
                          color: Color(0xFF5D3A1A),
                        ),
                      ),
              ),
              const SizedBox(height: 20),

              // Teks hasil chord
              Text(
                "Scan berhasil! Chord yang kamu mainkan adalah $chordResult",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF5D3A1A),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  
                ),
              ),
              const SizedBox(height: 20),

              // Tampilkan diagram chord jika ditemukan
              if (detectedChord != null)
                Column(
                  children: [
                    Text(
                      "Diagram Chord $chordResult",
                      style: const TextStyle(
                        color: Color(0xFF5D3A1A),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ChordDiagram(
                      title: detectedChord.name,
                      fingerDots: detectedChord.dots,
                      openStrings: detectedChord.open,
                      barre: detectedChord.barre,
                    ),
                  ],
                )
              else
                const Text(
                  "Chord diagram tidak tersedia",
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 30),

              // Tombol aksi
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                      label: const Text(
                        "Mulai Deteksi Lagi",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5D3A1A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OnboardingPage5()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.upload_file, color: Colors.white),
                      label: const Text(
                        "Upload Foto Lain",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5D3A1A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OnboardingPage6()),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Bottom Navigation Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _BottomNavItem(
                    icon: Icons.home,
                    label: "Home",
                    active: false,
                    onTap: () => _onNavTap(context, 0),
                  ),
                  _BottomNavItem(
                    icon: Icons.camera_alt,
                    label: "Deteksi Chord",
                    active: true,
                    onTap: () => _onNavTap(context, 1),
                  ),
                  _BottomNavItem(
                    icon: Icons.history,
                    label: "Riwayat",
                    active: false,
                    onTap: () => _onNavTap(context, 2),
                  ),
                  _BottomNavItem(
                    icon: Icons.menu_book,
                    label: "Library",
                    active: false,
                    onTap: () => _onNavTap(context, 3),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

// Bottom Nav Item Widget
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
          Icon(icon, color: active ? const Color(0xFF5D3A1A) : Colors.black45),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: active ? const Color(0xFF5D3A1A) : Colors.black45,
              fontWeight: active ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
