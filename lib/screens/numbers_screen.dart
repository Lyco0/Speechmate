import 'package:flutter/material.dart';
import '../services/audio_service.dart';

class NumbersScreen extends StatelessWidget {
  NumbersScreen({super.key});

  final AudioService audioService = AudioService();

  final List<Map<String, String>> numbers = [
    {"label": "1", "audio": "assets/audio/numbers/one.mp3"},
    {"label": "2", "audio": "assets/audio/numbers/two.mp3"},
    {"label": "3", "audio": "assets/audio/numbers/three.mp3"},
    {"label": "4", "audio": "assets/audio/numbers/four.mp3"},
    {"label": "5", "audio": "assets/audio/numbers/five.mp3"},
    {"label": "6", "audio": "assets/audio/numbers/six.mp3"},
    {"label": "7", "audio": "assets/audio/numbers/seven.mp3"},
    {"label": "8", "audio": "assets/audio/numbers/eight.mp3"},
    {"label": "9", "audio": "assets/audio/numbers/nine.mp3"},
    {"label": "10", "audio": "assets/audio/numbers/ten.mp3"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Numbers")),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: numbers.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          final item = numbers[index];
          return InkWell(
            onTap: () => audioService.playAsset(item["audio"]!),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  item["label"]!,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
