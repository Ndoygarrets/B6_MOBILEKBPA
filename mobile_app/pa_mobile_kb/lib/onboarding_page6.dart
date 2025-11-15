import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'onboarding_page4.dart';
import 'onboarding_page5.dart';
import 'onboarding_page7.dart';
import 'onboarding_page8.dart';
import 'onboarding_page9.dart';
import 'chord_history.dart';

class OnboardingPage6 extends StatefulWidget {
  final bool openGallery;

  const OnboardingPage6({super.key, this.openGallery = false});

  @override
  State<OnboardingPage6> createState() => _OnboardingPage6State();
}

class _OnboardingPage6State extends State<OnboardingPage6> {
  bool isCameraSelected = false;
  File? selectedImage;

  @override
  void initState() {
    super.initState();

    // Reset riwayat setiap kali aplikasi dijalankan

    if (widget.openGallery) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        pickImage();
      });
    }
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadAndDetect() async {
    if (selectedImage == null) return;

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.100.86:8000/api/predict/'),
      );

      request.files.add(await http.MultipartFile.fromPath('image', selectedImage!.path));

      var response = await request.send();
      var responseData = await http.Response.fromStream(response);

      String detectedChord = "Tidak diketahui";

      if (response.statusCode == 200) {
        final jsonData = json.decode(responseData.body);
        detectedChord = jsonData['predicted_label']?.toString() ?? "Tidak diketahui";
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal deteksi: ${response.statusCode}')),
          );
        }
        return;
      }

      if (!mounted) return;

      // Simpan riwayat sementara
      detectedChordHistory.add(
      DetectedChord(chordResult: detectedChord, imagePath: selectedImage!.path),
    );


      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OnboardingPage7(
            imagePath: selectedImage!.path,
            chordResult: detectedChord,
          ),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengirim gambar: $e')),
        );
      }
    }
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
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 8),
              const Text(
                "DETEKSI CHORD",
                style: TextStyle(
                  color: Color(0xFF5D3A1A),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Gunakan kamera atau upload foto untuk mendeteksi chord",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 13.5,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 20),

              // Tombol Kamera & Upload
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF5D3A1A)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isCameraSelected
                                ? const Color(0xFF5D3A1A)
                                : Colors.transparent,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt,
                                  color: isCameraSelected
                                      ? Colors.white
                                      : const Color(0xFF5D3A1A)),
                              const SizedBox(width: 6),
                              Text(
                                "Kamera",
                                style: TextStyle(
                                  color: isCameraSelected
                                      ? Colors.white
                                      : const Color(0xFF5D3A1A),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: !isCameraSelected
                                ? const Color(0xFF5D3A1A)
                                : Colors.transparent,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.upload_file,
                                  color: !isCameraSelected
                                      ? Colors.white
                                      : const Color(0xFF5D3A1A)),
                              const SizedBox(width: 6),
                              Text(
                                "Upload Foto",
                                style: TextStyle(
                                  color: !isCameraSelected
                                      ? Colors.white
                                      : const Color(0xFF5D3A1A),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Preview Foto
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade500),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: selectedImage == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.upload_outlined,
                                  size: 70, color: Color(0xFF5D3A1A)),
                              SizedBox(height: 10),
                              Text(
                                "Upload Foto",
                                style: TextStyle(
                                  color: Color(0xFF5D3A1A),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        : Image.file(selectedImage!),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  icon: Icon(
                      selectedImage == null ? Icons.upload_outlined : Icons.search,
                      color: Colors.white),
                  label: Text(
                    selectedImage == null ? "Upload Foto" : "Deteksi Chord",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5D3A1A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                  ),
                  onPressed: selectedImage == null ? pickImage : _uploadAndDetect,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // Bottom Navigation
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
