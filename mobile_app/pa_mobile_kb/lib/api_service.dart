import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = "http://192.168.100.86:8000/api/predict/"; // Ganti sesuai IP server Django kamu

  static Future<String> uploadImageAndDetectChord(File imageFile) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/detect/'));
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    var response = await request.send();


    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseBody);
      return jsonResponse['predicted_label'] ?? "Tidak terdeteksi";
    } else {
      throw Exception('Gagal deteksi chord (status: ${response.statusCode})');
    }
  }
}