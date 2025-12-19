import 'dart:convert';
import 'package:flutter/services.dart';

class DictionaryService {
  List<Map<String, dynamic>> _data = [];

  Future<void> load() async {
    final String jsonStr =
        await rootBundle.loadString('assets/data/dictionary.json');
    final List list = json.decode(jsonStr);
    _data = list.cast<Map<String, dynamic>>();
  }

  Map<String, dynamic>? search(String word) {
    try {
      return _data.firstWhere(
        (e) => e['english'].toString().toLowerCase() ==
            word.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }
}
