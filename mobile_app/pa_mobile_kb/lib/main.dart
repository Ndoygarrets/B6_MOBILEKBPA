import 'package:flutter/material.dart';
import 'guitar_vision_page.dart';
import 'onboarding_page1.dart';
import 'onboarding_page2.dart';
import 'onboarding_page3.dart';
import 'onboarding_page4.dart';
import 'onboarding_page5.dart';
import 'onboarding_page6.dart';
import 'onboarding_page7.dart';
import 'onboarding_page8.dart';
import 'onboarding_page9.dart';
import 'chord_history.dart';

void main() {
  // Reset riwayat chord saat aplikasi mulai
  detectedChordHistory.clear();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const GuitarVisionPage(),
        '/onboarding1': (context) => const OnboardingPage1(),
        '/onboarding2': (context) => const OnboardingPage2(),
        '/onboarding3': (context) => const OnboardingPage3(),
        '/onboarding4': (context) => const OnboardingPage4(),
        '/onboarding5': (context) => const OnboardingPage5(),
        '/onboarding6': (context) => const OnboardingPage6(),
        '/onboarding7': (context) => const OnboardingPage7(
              imagePath: '',
              chordResult: '',
            ),
        '/onboarding8': (context) => const OnboardingPage8(),
        '/onboarding9': (context) => const OnboardingPage9(),
      },
    );
  }
}
