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
        colors: const [
          Color(0xFF38BDF8),
          Color(0xFF94FFF8),
        ],
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// 🔹 Title
            const Text(
              "English → Nicobarese",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 30),

            /// 🔹 Search bar
            Search(
              controller: searchController,
              onSearch: performSearch,
              onClear: clearSearch,
            ),

            const SizedBox(height: 30),

            /// 🔹 Translation result
            if (searchController.text.isNotEmpty)
              TranslationCard(
                nicobarese:
                    result != null ? result!['nicobarese'] : "Word not found",
                english: result != null ? result!['english'] : "",
                isError: result == null,

                /// 🔊 AUDIO LOGIC
                onPlayAudio: result != null
                    ? () {
                        // 1️⃣ If recorded audio exists → play it
                        if (result!['audio'] != null) {
                          audioService.playFromJson(result!['audio']);
                        }
                        // 2️⃣ Else → fallback to TTS
                        else {
                          ttsService.speakNicobarese(
                            result!['nicobarese'],
                          );
                        }
                      }
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}
