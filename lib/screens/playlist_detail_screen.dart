import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/playlist_model.dart';
import '../providers/audio_provider.dart';
import '../widgets/song_tile.dart';

class PlaylistDetailScreen extends StatelessWidget {
  final PlaylistModel playlist;

  const PlaylistDetailScreen({required this.playlist});

  @override
  Widget build(BuildContext context) {
    //Lọc ra các bài hát thuộc playlist này từ tổng kho nhạc của AudioProvider
    final allSongs = context.read<AudioProvider>().playlist;
    final playlistSongs = allSongs.where((song) => playlist.songIds.contains(song.id)).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF191414),
      appBar: AppBar(
        title: Text(playlist.name),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: playlistSongs.isEmpty
          ? const Center(
              child: Text('Playlist này chưa có bài hát nào', style: TextStyle(color: Colors.grey)),
            )
          : ListView.builder(
              itemCount: playlistSongs.length,
              itemBuilder: (context, index) {
                final song = playlistSongs[index];
                return SongTile(
                  song: song,
                  onTap: () {
                    context.read<AudioProvider>().setPlaylist(playlistSongs, index);
                  },
                );
              },
            ),
    );
  }
}