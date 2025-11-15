import 'package:flutter/material.dart';

// =======================================
// Data Model
// =======================================
class BarreChord {
  final int fret;
  final int from;
  final int to;

  BarreChord({
    required this.fret,
    required this.from,
    required this.to,
  });
}

class ChordData {
  final String name;
  final List<Offset> dots;   // (string, fret)
  final List<int> open;      // string index
  final BarreChord? barre;

  ChordData({
    required this.name,
    required this.dots,
    required this.open,
    this.barre,
  });
}

// =======================================
// Daftar Chord
// =======================================
final List<ChordData> chordList = [
  ChordData(name: "A", dots: [Offset(1,2), Offset(2,2), Offset(3,2)], open: [0,5], barre: null),
  ChordData(name: "B", dots: [Offset(1,4), Offset(2,4), Offset(3,4), Offset(4,2)], open: [], barre: BarreChord(fret: 2, from: 0, to: 5)),
  ChordData(name: "C", dots: [Offset(1,0), Offset(2,1), Offset(3,0), Offset(4,2), Offset(5,3)], open: [0], barre: null),
  ChordData(name: "D", dots: [Offset(1,2), Offset(2,3), Offset(3,2)], open: [3,5], barre: null),
  ChordData(name: "E", dots: [Offset(1,1), Offset(2,2), Offset(3,2)], open: [0,4,5], barre: null),
  ChordData(name: "F", dots: [Offset(2,3), Offset(3,2), Offset(4,1), Offset(5,1)], open: [1], barre: null),
  ChordData(name: "G", dots: [Offset(0,3), Offset(4,2), Offset(5,3)], open: [2,3], barre: null),
];

// =======================================
// Widget Diagram Chord
// =======================================
class ChordDiagram extends StatelessWidget {
  final String title;
  final List<Offset> fingerDots;
  final List<int> openStrings;
  final BarreChord? barre;

  const ChordDiagram({
    super.key,
    required this.title,
    required this.fingerDots,
    required this.openStrings,
    this.barre,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ChordPainter(
        fingerDots: fingerDots,
        openStrings: openStrings,
        barre: barre,
      ),
      size: const Size(100, 130),
    );
  }
}

class ChordPainter extends CustomPainter {
  final List<Offset> fingerDots;
  final List<int> openStrings;
  final BarreChord? barre;

  ChordPainter({
    required this.fingerDots,
    required this.openStrings,
    required this.barre,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black..strokeWidth = 2;
    double startX = 20, spacingX = 15, startY = 30, spacingY = 25;

    // Strings
    for (int i = 0; i < 6; i++) {
      canvas.drawLine(Offset(startX + i*spacingX, startY), Offset(startX + i*spacingX, startY + spacingY*4), paint);
    }

    // Frets
    for (int i = 0; i < 5; i++) {
      canvas.drawLine(Offset(startX, startY + i*spacingY), Offset(startX + spacingX*5, startY + i*spacingY), paint);
    }

    // Barre
    if(barre != null){
      final barrePaint = Paint()..color = Colors.black;
      double y = startY + (barre!.fret -1)*spacingY;
      double x1 = startX + barre!.from*spacingX;
      double x2 = startX + barre!.to*spacingX;
      final rect = RRect.fromRectAndRadius(Rect.fromLTRB(x1-5, y-8, x2+5, y+8), const Radius.circular(8));
      canvas.drawRRect(rect, barrePaint);
    }

    // Finger Dots
    for(final dot in fingerDots){
      final dx = startX + dot.dx*spacingX;
      final dy = startY + (dot.dy-1)*spacingY;
      canvas.drawCircle(Offset(dx, dy), 6, paint);
    }

    // Open Strings
    for(final s in openStrings){
      final dx = startX + s*spacingX;
      final textPainter = TextPainter(
        text: const TextSpan(text: "O", style: TextStyle(color: Colors.black, fontSize: 14)),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, Offset(dx-6, startY-22));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
