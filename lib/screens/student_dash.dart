import 'package:flutter/material.dart';
import '../widgets/background.dart';
import '../widgets/common_word_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/translation_card.dart';
import '../services/dictionary_service.dart';
import '../services/audio_service.dart';

class StudentDash extends StatefulWidget {
  const StudentDash({super.key});

  @override
  State<StudentDash> createState() => _StudentDashState();
}

class _StudentDashState extends State<StudentDash> {
  final TextEditingController searchController = TextEditingController();
  final DictionaryService dictionaryService = DictionaryService();
  final AudioService audioService = AudioService();

  Map<String, dynamic>? result;

  final List<Map<String, dynamic>> commonWords = [
    {"word": "Tree", "emoji": "🌳"},
    {"word": "Water", "emoji": "💧"},
    {"word": "Sea", "emoji": "🌊"},
    {"word": "Sun", "emoji": "☀️"},
    {"word": "Cold", "emoji": "❄️"},
  ];

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
        colors: const [Color(0xFF94FFF8), Color(0xFF38BDF8)],
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "English → Nicobarese",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 20),

            Search(
              controller: searchController,
              onSearch: performSearch,
              onClear: clearSearch,
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: commonWords.map((w) {
                return CommonWordCard(
                  word: w["word"],
                  emoji: w["emoji"],
                  onWordSelected: (word) {
                    setState(() {
                      searchController.text = word;
                      result = dictionaryService.search(word);
                    });

                    if (result != null && result!['audio'] != null) {
                      audioService.playAsset(result!['audio']);
                    }
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            if (result != null)
              TranslationCard(
                english: result!['english'],
                nicobarese: result!['nicobarese'],
                onPlayAudio: result!['audio'] != null
                    ? () => audioService.playAsset(result!['audio'])
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}              alignment: Alignment.centerLeft,
              child: Text(
                "Some common words",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 15),

            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: commonWords.map((w) {
                return CommonWordCard(
                  word: w["word"],
                  emoji: w["emoji"],
                  gradient: List<Color>.from(w["colors"]),
                  onWordSelected: (selectedWord) {
                    FocusScope.of(context).unfocus();

                    final searchResult =
                        dictionaryService.search(selectedWord);

                    setState(() {
                      searchController.text = selectedWord;
                      result = searchResult;
                    });

                    if (searchResult != null &&
                        searchResult['audio'] != null) {
                      audioService.play(searchResult['audio']);
                    }
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 30),

            if (searchController.text.isNotEmpty)
              TranslationCard(
                nicobarese:
                    result != null ? result!['nicobarese'] : "Word not found",
                english: result != null ? result!['english'] : "",
                isError: result == null,
                onPlayAudio:
                    result != null && result!['audio'] != null
                        ? () => audioService.play(result!['audio'])
                        : null,
              ),
          ],
        ),
      ),
    );
  }
}    ],
        ),
      ),
    );
  }
}
