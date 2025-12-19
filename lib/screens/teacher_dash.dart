import 'package:flutter/material.dart';
import '../widgets/background.dart';
import '../widgets/search_bar.dart';
import '../widgets/translation_card.dart';
import '../services/dictionary_service.dart';
import '../services/audio_service.dart';
import '../services/tts_service.dart';

class TeacherDash extends StatefulWidget {
  const TeacherDash({super.key});

  @override
  State<TeacherDash> createState() => _TeacherDashState();
}

class _TeacherDashState extends State<TeacherDash> {
  final TextEditingController searchController = TextEditingController();
  final DictionaryService dictionaryService = DictionaryService();
  final AudioService audioService = AudioService();
  final TtsService ttsService = TtsService();

  Map<String, dynamic>? result;

  @override
  void initState() {
    super.initState();
    dictionaryService.load();
  }

  void performSearch() {
    FocusScope.of(context).unfocus();
    setState(() {
      result = dictionaryService.search(searchController.text);
    });
  }

  void clearSearch() {
    setState(() {
      searchController.clear();
      result = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        colors: const [Color(0xFF38BDF8), Color(0xFF94FFF8)],
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "English → Nicobarese",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ),

              const SizedBox(height: 25),

              Search(
                controller: searchController,
                onSearch: performSearch,
                onClear: clearSearch,
              ),

              const SizedBox(height: 25),

              if (searchController.text.isNotEmpty)
                TranslationCard(
                  nicobarese:
                      result != null ? result!['nicobarese'] : "Word not found",
                  english: result != null ? result!['english'] : "",
                  isError: result == null,
                  onPlayAudio: result != null
                      ? () {
                          if (result!['audio'] != null) {
                            audioService.playFromJson(result!['audio']);
                          } else {
                            ttsService.speak(result!['nicobarese']);
                          }
                        }
                      : null,
                ),

              const SizedBox(height: 30),

              const Text(
                "Common Classroom Phrases",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 10),

              phraseButton(
                text: "Good Morning",
                audioPath: "assets/audio/phrases/good_morning.mp3",
              ),
              phraseButton(
                text: "How are you?",
                audioPath: "assets/audio/phrases/how_are_you.mp3",
              ),
              phraseButton(
                text: "Keep Silent",
                audioPath: "assets/audio/phrases/keep_silent.mp3",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget phraseButton({
    required String text,
    required String audioPath,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => audioService.playAsset(audioPath),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: const TextStyle(fontSize: 16)),
            const Icon(Icons.volume_up),
          ],
        ),
      ),
    );
  }
}              phraseButton(
                text: "Good Morning",
                audioPath: "assets/audio/phrases/good_morning.mp3",
              ),
              phraseButton(
                text: "How are you?",
                audioPath: "assets/audio/phrases/how_are_you.mp3",
              ),
              phraseButton(
                text: "Keep Silent",
                audioPath: "assets/audio/phrases/keep_silent.mp3",
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Phrase Button
  Widget phraseButton({
    required String text,
    required String audioPath,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => audioService.playAsset(audioPath),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: const TextStyle(fontSize: 16)),
            const Icon(Icons.volume_up),
          ],
        ),
      ),
    );
  }
}                  "Common Classroom Phrases",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              /// 🔹 Phrase buttons
              Column(
                children: [
                  phraseButton(
                    text: "Good Morning",
                    audioPath: "assets/audio/phrases/good_morning.mp3",
                  ),
                  phraseButton(
                    text: "How are you?",
                    audioPath: "assets/audio/phrases/how_are_you.mp3",
                  ),
                  phraseButton(
                    text: "Keep Silent",
                    audioPath: "assets/audio/phrases/keep_silent.mp3",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Reusable phrase button
  Widget phraseButton({
    required String text,
    required String audioPath,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => audioService.playAsset(audioPath),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: const TextStyle(fontSize: 16)),
            const Icon(Icons.volume_up),
          ],
        ),
      ),
    );
  }
}
