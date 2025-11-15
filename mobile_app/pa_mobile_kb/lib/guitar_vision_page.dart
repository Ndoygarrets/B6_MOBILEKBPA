import 'package:flutter/material.dart';

class GuitarVisionPage extends StatelessWidget {
  const GuitarVisionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),

            // Logo (sudah termasuk tulisan)
            Center(
              child: Image.asset(
                'assets/guitar_vision_logo.png', // ganti sesuai nama file kamu
                height: 200,
              ),
            ),

            const Spacer(),

            // Tombol Get Started
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4E2C1E), // warna coklat
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 3,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/onboarding1');
        },
                  child: const Text(
                    'GET STARTED',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}