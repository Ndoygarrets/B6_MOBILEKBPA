import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'onboarding_page4.dart';
import 'onboarding_page6.dart';
import 'onboarding_page7.dart';
import 'onboarding_page8.dart';
import 'onboarding_page9.dart';
import 'chord_history.dart';

class OnboardingPage5 extends StatefulWidget {
  const OnboardingPage5({super.key});

  @override
  State<OnboardingPage5> createState() => _OnboardingPage5State();
}

class _OnboardingPage5State extends State<OnboardingPage5> {
  bool isCameraSelected = true;
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  CameraLensDirection _currentCameraDirection = CameraLensDirection.back;

  @override
  void initState() {
    super.initState();
    if (isCameraSelected) {
      _initCamera();
    }
  }

  Future<void> _initCamera([CameraLensDirection? direction]) async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        final selectedDirection = direction ?? _currentCameraDirection;
        final selectedCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == selectedDirection,
          orElse: () => cameras.first,
        );

        _cameraController = CameraController(
          selectedCamera,
          ResolutionPreset.medium,
          enableAudio: false,
        );

        try {
          await _cameraController!.initialize();
          if (mounted) {
            setState(() {
              _isCameraInitialized = true;
            });
          }
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gagal inisialisasi kamera: $e')),
            );
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tidak ada kamera tersedia')),
          );
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Izin kamera ditolak')),
        );
      }
    }
  }

  Future<void> _switchCamera() async {
    setState(() => _isCameraInitialized = false);
    _cameraController?.dispose();
    _currentCameraDirection = _currentCameraDirection == CameraLensDirection.back
        ? CameraLensDirection.front
        : CameraLensDirection.back;
    await _initCamera(_currentCameraDirection);
  }

  Future<void> _takePictureAndGo() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        final XFile image = await _cameraController!.takePicture();

        var request = http.MultipartRequest(
          'POST',
          Uri.parse('https://guitarvischord.loca.lt/api/predict/'),
        );
        request.files.add(await http.MultipartFile.fromPath('image', image.path));
        var response = await request.send();

        String detectedChord = "Tidak diketahui";

        if (response.statusCode == 200) {
          var responseData = await http.Response.fromStream(response);
          var jsonData = json.decode(responseData.body);
          detectedChord = jsonData['predicted_label'] ?? "Tidak diketahui";
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gagal deteksi: ${response.statusCode}')),
            );
          }
        }

        if (!mounted) return;
        detectedChordHistory.add(
        DetectedChord(chordResult: detectedChord, imagePath: image.path),
    );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OnboardingPage7(
              imagePath: image.path,
              chordResult: detectedChord,
            ),
          ),
        );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal mengambil gambar: $e')),
          );
        }
      }
    }
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4E2C1E)),
          onPressed: () => _navigateTo(context, const OnboardingPage4()),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "DETEKSI CHORD",
                style: TextStyle(
                  color: Color(0xFF4E2C1E),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Gunakan kamera atau upload foto untuk mendeteksi chord.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87, fontSize: 14),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isCameraSelected = true;
                          _initCamera();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isCameraSelected
                              ? const Color(0xFF4E2C1E)
                              : Colors.transparent,
                          border: Border.all(color: const Color(0xFF4E2C1E)),
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
                                    : const Color(0xFF4E2C1E)),
                            const SizedBox(width: 6),
                            Text(
                              "Kamera",
                              style: TextStyle(
                                  color: isCameraSelected
                                      ? Colors.white
                                      : const Color(0xFF4E2C1E),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isCameraSelected = false;
                          _cameraController?.dispose();
                          _isCameraInitialized = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: !isCameraSelected
                              ? const Color(0xFF4E2C1E)
                              : Colors.transparent,
                          border: Border.all(color: const Color(0xFF4E2C1E)),
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
                                    : const Color(0xFF4E2C1E)),
                            const SizedBox(width: 6),
                            Text(
                              "Upload Foto",
                              style: TextStyle(
                                  color: !isCameraSelected
                                      ? Colors.white
                                      : const Color(0xFF4E2C1E),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: const Color(0xFF4E2C1E)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: isCameraSelected
                            ? (_isCameraInitialized
                                ? CameraPreview(_cameraController!)
                                : const CircularProgressIndicator(
                                    color: Color(0xFF4E2C1E),
                                  ))
                            : const Icon(Icons.upload_file,
                                size: 80, color: Color(0xFF4E2C1E)),
                      ),
                      if (isCameraSelected && _isCameraInitialized)
                        Positioned(
                          top: 10,
                          right: 10,
                          child: FloatingActionButton(
                            mini: true,
                            backgroundColor: Colors.black54,
                            onPressed: _switchCamera,
                            child: const Icon(
                              Icons.flip_camera_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (isCameraSelected) {
                      await _takePictureAndGo();
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OnboardingPage6(openGallery: true),
                        ),
                      );
                    }
                  },
                  icon: Icon(
                      isCameraSelected ? Icons.camera_alt : Icons.upload_file,
                      color: Colors.white),
                  label: Text(
                    isCameraSelected ? "Mulai Deteksi" : "Upload Foto",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4E2C1E),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
              active: false,
              onTap: () => _navigateTo(context, const OnboardingPage4()),
            ),
            _BottomNavItem(
              icon: Icons.camera_alt,
              label: "Deteksi",
              active: true,
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

// ✅ Widget Bottom Nav Item
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
          Icon(icon, color: active ? const Color(0xFF4E2C1E) : Colors.black45),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: active ? const Color(0xFF4E2C1E) : Colors.black45,
              fontWeight: active ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
