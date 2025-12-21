import 'dart:convert';
import 'package:flutter/services.dart';

class DictionaryService {
  List<Map<String, dynamic>> _data = [];

  /// Load dictionary JSON
  Future<void> load() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/dictionary.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    _data = jsonData.cast<Map<String, dynamic>>();
  }

  /// 🔁 BIDIRECTIONAL SEARCH
  Map<String, dynamic>? search(String input) {
    if (input.trim().isEmpty) return null;

    final query = input.trim().toLowerCase();

    for (final item in _data) {
      final english = item['english']?.toString().toLowerCase() ?? '';
      final nicobarese = item['nicobarese']?.toString().toLowerCase() ?? '';

      // ✅ English → Nicobarese
      if (english == query) {
        return item;
      }

      // ✅ Nicobarese → English
      if (nicobarese == query) {
        return item;
      }
    }

    return null;
  }
}
