// chord_history.dart
import 'dart:io';

// Model untuk menyimpan riwayat deteksi chord
class DetectedChord {
  final String chordResult; // Nama chord yang terdeteksi
  final String imagePath;   // Path gambar yang diupload/dideteksi

  DetectedChord({required this.chordResult, required this.imagePath});
}

// List riwayat chord (sementara, akan reset saat aplikasi dimulai)
List<DetectedChord> detectedChordHistory = [];
