import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioProvider = context.watch<AudioProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFF191414),
      appBar: AppBar(
        title: const Text('Cài đặt'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'ÂM THANH',
              style: TextStyle(color: Color(0xFF1DB954), fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.volume_up, color: Colors.white),
            title: const Text('Âm lượng ứng dụng', style: TextStyle(color: Colors.white)),
            subtitle: Slider(
              value: audioProvider.playlist.isEmpty ? 1.0 : 1.0, // fallback
              activeColor: const Color(0xFF1DB954),
              onChanged: (value) {
                audioProvider.setVolume(value);
              },
            ),
          ),
          const Divider(color: Colors.grey),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'THÔNG TIN',
              style: TextStyle(color: Color(0xFF1DB954), fontWeight: FontWeight.bold),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.info, color: Colors.white),
            title: Text('Phiên bản ứng dụng', style: TextStyle(color: Colors.white)),
            trailing: Text('v1.0.0 (Lab 6)', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}