import 'package:flutter/material.dart';
import 'chord_library.dart'; // <-- import ini cukup untuk semua data chord
import 'onboarding_page4.dart';
import 'onboarding_page5.dart';
import 'onboarding_page8.dart';

class OnboardingPage9 extends StatelessWidget {
  const OnboardingPage9({super.key});

  void _navigateTo(BuildContext context, Widget page){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD9D9D9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4B2E05)),
          onPressed: ()=> _navigateTo(context, const OnboardingPage4()),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:16, vertical:10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Column(
                  children: [
                    Text("CHORD LIBRARY", style: TextStyle(color: Color(0xFF4B2E05), fontWeight: FontWeight.bold, fontSize:16, letterSpacing:1.2)),
                    SizedBox(height:6),
                    Text("Database lengkap chord gitar dengan diagram dan\ninformasi posisi jari yang detail.",
                      style: TextStyle(color: Color(0xFF4B2E05), fontSize:12, fontWeight: FontWeight.w400, height:1.3),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height:16),

              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.only(bottom:10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio:0.95, mainAxisSpacing:10, crossAxisSpacing:10
                  ),
                  itemCount: chordList.length,
                  itemBuilder: (context, index){
                    final chord = chordList[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        border: Border.all(color: Colors.brown.shade300, width: 1.2),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          children: [
                            Text(chord.name, style: const TextStyle(fontSize:14, fontWeight: FontWeight.bold, color: Color(0xFF4B2E05))),
                            const SizedBox(height:4),
                            Expanded(child: Center(child: ChordDiagram(title: chord.name, fingerDots: chord.dots, openStrings: chord.open, barre: chord.barre))),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        color: const Color(0xFFF7F5F2),
        padding: const EdgeInsets.symmetric(vertical:10, horizontal:20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _BottomNavItem(icon: Icons.home, label:"Beranda", active:false, onTap: ()=> _navigateTo(context, const OnboardingPage4())),
            _BottomNavItem(icon: Icons.camera_alt, label:"Deteksi", active:false, onTap: ()=> _navigateTo(context, const OnboardingPage5())),
            _BottomNavItem(icon: Icons.history, label:"Riwayat", active:false, onTap: ()=> _navigateTo(context, const OnboardingPage8())),
            _BottomNavItem(icon: Icons.menu_book, label:"Library", active:true, onTap: ()=> _navigateTo(context, const OnboardingPage9())),
          ],
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget{
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _BottomNavItem({required this.icon, required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: active ? const Color(0xFF5D3A1A) : Colors.black45),
          const SizedBox(height:4),
          Text(label, style: TextStyle(fontSize:11, color: active ? const Color(0xFF5D3A1A) : Colors.black45, fontWeight: active?FontWeight.bold:FontWeight.normal)),
        ],
      ),
    );
  }
}
