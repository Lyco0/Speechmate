import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> play(String assetPath) async {
    try {
      await _player.stop();
      await _player.play(
        AssetSource(assetPath.replaceFirst('assets/', '')),
      );
    } catch (e) {
      print('Audio play error: $e');
    }
  }
}
