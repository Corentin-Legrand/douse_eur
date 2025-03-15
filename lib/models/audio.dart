import 'package:audioplayers/audioplayers.dart';

final player = AudioPlayer();

void playMusic() async {
  await player.play(AssetSource('audio/pipe.mp3'));
}

void stopMusic() async {
  await player.stop();
}