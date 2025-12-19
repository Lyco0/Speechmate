import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playAsset(String path) async {
    await _player.stop();
    await _player.play(AssetSource(path.replaceFirst('assets/', '')));
  }
}
