import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/song_model.dart';
import '../providers/playlist_provider.dart';

class SongTile extends StatelessWidget {
  final SongModel song;
  final VoidCallback onTap;

  const SongTile({
    required this.song,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: _buildAlbumArt(),
      title: Text(
        song.title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        song.artist,
        style: const TextStyle(color: Colors.grey),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert, color: Colors.grey),
        onPressed: () {
          _showOptionsMenu(context);
        },
      ),
      onTap: onTap,
    );
  }

  Widget _buildAlbumArt() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color(0xFF282828),
      ),
      child: song.albumArt != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.file(File(song.albumArt!), fit: BoxFit.cover),
            )
          : const Icon(Icons.music_note, color: Colors.grey),
    );
  }

  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF282828),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.playlist_add, color: Colors.white),
              title: const Text('Thêm vào Playlist', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context); //Đóng menu 3 chấm
                _showPlaylistsDialog(context); //Mở hộp thoại chọn Playlist
              },
            ),
            ListTile(
              leading: const Icon(Icons.share, color: Colors.white),
              title: const Text('Chia sẻ', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  //HỘP THOẠI CHỌN PLAYLIST
  void _showPlaylistsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF282828),
          title: const Text('Chọn Playlist', style: TextStyle(color: Colors.white)),
          content: SizedBox(
            width: double.maxFinite,
            child: Consumer<PlaylistProvider>(
              builder: (context, provider, child) {
                if (provider.playlists.isEmpty) {
                  return const Text(
                    'Chưa có playlist nào. Hãy tạo playlist mới trong menu trước!',
                    style: TextStyle(color: Colors.grey),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.playlists.length,
                  itemBuilder: (context, index) {
                    final playlist = provider.playlists[index];
                    return ListTile(
                      leading: const Icon(Icons.queue_music, color: Color(0xFF1DB954)),
                      title: Text(playlist.name, style: const TextStyle(color: Colors.white)),
                      onTap: () {
                        //Gọi hàm thêm nhạc vào Playlist
                        provider.addSongToPlaylist(playlist.id, song.id);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Đã thêm "${song.title}" vào ${playlist.name}')),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Đóng', style: TextStyle(color: Colors.grey)),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}