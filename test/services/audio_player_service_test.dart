import 'package:flutter_simple_offline_music_app/services/audio_player_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AudioPlayerService Tests', () {
    late AudioPlayerService service;

    setUp(() {
      service = AudioPlayerService();
    });

    test('Initial state is not playing', () {
      expect(service.isPlaying, false);
    });

    test('Load audio file successfully', () async {
      // Test with valid audio file path
      await service.loadAudio('assets/audio/sample.mp3');
      expect(service.currentDuration, isNotNull);
    });

    tearDown(() {
      service.dispose();
    });
  });
}