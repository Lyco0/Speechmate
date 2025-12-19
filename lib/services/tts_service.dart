import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _tts = FlutterTts();

  TtsService() {
    _tts.setLanguage("en-IN"); // fallback language
    _tts.setSpeechRate(0.45);
    _tts.setPitch(1.0);
  }

  /// 🔊 Universal speak method
  Future<void> speak(String text) async {
    if (text.isEmpty) return;
    await _tts.stop();
    await _tts.speak(text);
  }
}
