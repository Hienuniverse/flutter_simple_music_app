import 'package:flutter/material.dart';

class PlaylistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Playlists'),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Text('Danh sách Playlist sẽ hiển thị ở đây', style: TextStyle(color: Colors.grey)),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1DB954),
        onPressed: () {
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}