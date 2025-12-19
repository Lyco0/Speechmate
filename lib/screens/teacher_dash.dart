import 'package:flutter/material.dart';
import '../services/dictionary_service.dart';
import '../services/audio_service.dart';
import '../services/tts_service.dart';

class TeacherDash extends StatefulWidget {
  const TeacherDash({super.key});

  @override
  State<TeacherDash> createState() => _TeacherDashState();
}

class _TeacherDashState extends State<TeacherDash> {
  final searchController = TextEditingController();
  final dictionaryService = DictionaryService();
  final audioService = AudioService();
  final ttsService = TtsService();

  Map<String, dynamic>? result;

  @override
  void initState() {
    super.initState();
    dictionaryService.load();
  }

  void search() {
    setState(() {
      result = dictionaryService.search(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Teacher Mode")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: "Enter English word",
              ),
              onSubmitted: (_) => search(),
            ),
            const SizedBox(height: 20),

            if (result != null) ...[
              Text(
                result!['nicobarese'],
                style: const TextStyle(fontSize: 28),
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (result!['audio'] != null)
                    IconButton(
                      icon: const Icon(Icons.record_voice_over),
                      onPressed: () {
                        audioService.playFromJson(result!['audio']);
                      },
                    ),
                  IconButton(
                    icon: const Icon(Icons.volume_up),
                    onPressed: () {
                      ttsService.speak(result!['nicobarese']);
                    },
                  ),
                ],
              )
            ],
          ],
        ),
      ),
    );
  }
}
