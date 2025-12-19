import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();

  /// Play recorded tribal audio
  Future<void> playFromJson(Map<String, dynamic> audio) async {
    final String category = audio['category'];
    final String file = audio['file'];

    final String path = 'assets/audio/$category/$file';

    await _player.stop();
    await _player.play(AssetSource(path.replaceFirst('assets/', '')));
  }
}
