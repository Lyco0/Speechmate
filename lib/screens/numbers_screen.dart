import 'package:flutter/material.dart';
import '../services/audio_service.dart';

class NumbersScreen extends StatelessWidget {
  NumbersScreen({super.key});

  final AudioService audioService = AudioService();

  final List<Map<String, String>> numbers = [
    {"num": "1", "audio": "assets/audio/numbers/one.mp3"},
    {"num": "2", "audio": "assets/audio/numbers/two.mp3"},
    {"num": "3", "audio": "assets/audio/numbers/three.mp3"},
    {"num": "4", "audio": "assets/audio/numbers/four.mp3"},
    {"num": "5", "audio": "assets/audio/numbers/five.mp3"},
    {"num": "6", "audio": "assets/audio/numbers/six.mp3"},
    {"num": "7", "audio": "assets/audio/numbers/seven.mp3"},
    {"num": "8", "audio": "assets/audio/numbers/eight.mp3"},
    {"num": "9", "audio": "assets/audio/numbers/nine.mp3"},
    {"num": "10", "audio": "assets/audio/numbers/ten.mp3"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Learn Numbers")),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: numbers.map((n) {
          return GestureDetector(
            onTap: () => audioService.play(n["audio"]!),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  n["num"]!,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
