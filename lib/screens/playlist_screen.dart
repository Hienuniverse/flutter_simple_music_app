import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/playlist_provider.dart';
import 'playlist_detail_screen.dart';

class PlaylistScreen extends StatelessWidget {
  final TextEditingController _dialogController = TextEditingController();

  void _showCreatePlaylistDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF282828),
        title: const Text('Tạo Playlist mới', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: _dialogController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Nhập tên playlist...',
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF1DB954))),
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('Tạo', style: TextStyle(color: Color(0xFF1DB954))),
            onPressed: () {
              if (_dialogController.text.isNotEmpty) {
                context.read<PlaylistProvider>().createPlaylist(_dialogController.text);
                _dialogController.clear();
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191414),
      appBar: AppBar(
        title: const Text('Tuyển tập của tôi', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreatePlaylistDialog(context),
          )
        ],
      ),
      body: Consumer<PlaylistProvider>(
        builder: (context, provider, child) {
          if (provider.playlists.isEmpty) {
            return const Center(
              child: Text('Chưa có playlist nào. Hãy tạo mới!', style: TextStyle(color: Colors.grey)),
            );
          }
          return ListView.builder(
            itemCount: provider.playlists.length,
            itemBuilder: (context, index) {
              final playlist = provider.playlists[index];
              return ListTile(
                leading: Container(
                  width: 50, height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF282828),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.music_note, color: Color(0xFF1DB954)),
                ),
                title: Text(playlist.name, style: const TextStyle(color: Colors.white)),
                subtitle: Text('${playlist.songIds.length} bài hát', style: const TextStyle(color: Colors.grey)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.grey),
                  onPressed: () => provider.deletePlaylist(playlist.id),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaylistDetailScreen(playlist: playlist),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}