// Provides isolated audio playback for the CookJar animation phases.
//
// This service keeps audio concerns separate from the visual widgets.
// Visual widgets never import this file directly — audio is triggered from the
// animation orchestration layer in cook_jar.dart.
//
// The service uses audioplayers for asset playback. When moving the feature to
// a real project, this file is the single place to swap the audio backend or
// replace asset paths.

import 'package:audioplayers/audioplayers.dart';
import '../presentation/view/widgets/jar_constants.dart';

/// Manages audio playback for the jar's animation phases.
///
/// Each semantic phase has a dedicated play method. The service owns its own
/// [AudioPlayer] instances and disposes them when [dispose] is called.
class JarAudioService {
  final AudioPlayer _shakePlayer = AudioPlayer();
  final AudioPlayer _corkPlayer = AudioPlayer();
  final AudioPlayer _paperPlayer = AudioPlayer();

  /// Plays the jar-shaking audio asset.
  Future<void> playShake(String assetPath) async {
    await _shakePlayer.stop();
    await _shakePlayer.setVolume(JarConstants.globalAudioVolume);
    await _shakePlayer.play(AssetSource(assetPath));
  }

  /// Plays the cork-opening audio asset.
  Future<void> playCork(String assetPath) async {
    await _corkPlayer.stop();
    await _corkPlayer.setVolume(JarConstants.globalAudioVolume);
    await _corkPlayer.play(AssetSource(assetPath));
  }

  /// Plays the paper-crumpling audio asset.
  Future<void> playPaper(String assetPath) async {
    await _paperPlayer.stop();
    await _paperPlayer.setVolume(JarConstants.globalAudioVolume);
    await _paperPlayer.play(AssetSource(assetPath));
  }

  /// Stops all audio playback immediately.
  Future<void> stopAll() async {
    await _shakePlayer.stop();
    await _corkPlayer.stop();
    await _paperPlayer.stop();
  }

  /// Stops all audio and releases resources.
  Future<void> dispose() async {
    await stopAll();
    await _shakePlayer.dispose();
    await _corkPlayer.dispose();
    await _paperPlayer.dispose();
  }
}
