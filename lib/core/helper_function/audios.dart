import 'package:audioplayers/audioplayers.dart';

class SoundService {
  static Future<void> play(String audio) async {
    await AudioPlayer().play(AssetSource(audio));
  }
}
