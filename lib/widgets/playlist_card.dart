import 'package:flutter/material.dart';
import '../models/playlist_model.dart';

class PlaylistCard extends StatelessWidget {
  final PlaylistModel playlist;

  const PlaylistCard({Key? key, required this.playlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF282828),
      child: ListTile(
        leading: const Icon(Icons.queue_music, color: Color(0xFF1DB954)),
        title: Text(playlist.name, style: const TextStyle(color: Colors.white)),
        subtitle: Text('${playlist.songIds.length} songs', style: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}