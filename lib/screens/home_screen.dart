import 'package:flutter/material.dart';
import 'package:flutter_simple_offline_music_app/models/song_model.dart';
import 'package:flutter_simple_offline_music_app/providers/audio_provider.dart';
import 'package:flutter_simple_offline_music_app/services/permission_service.dart';
import 'package:flutter_simple_offline_music_app/services/playlist_service.dart';
import 'package:flutter_simple_offline_music_app/widgets/mini_player.dart';
import 'package:flutter_simple_offline_music_app/widgets/song_tile.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PlaylistService _playlistService = PlaylistService();
  final PermissionService _permissionService = PermissionService();

  List<SongModel> _songs = [];
  bool _isLoading = true;
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    //Xin cấp cả 2 quyền (Storage cho Android cũ, Audio cho Android 13+)
    await _permissionService.requestStoragePermission();
    await _permissionService.requestAudioPermission();

    //Kiểm tra xem ít nhất 1 trong 2 quyền đã được cấp chưa
    _hasPermission = await _permissionService.hasPermissions();

    if (_hasPermission) {
      await _loadSongs();
    }
    
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _loadSongs() async {
    try {
      final songs = await _playlistService.getAllSongs();
      setState(() {
        _songs = songs.cast<SongModel>();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading songs: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF191414),
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            _buildAppBar(),
            // Content
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : !_hasPermission
                      ? _buildPermissionDenied()
                      : _songs.isEmpty
                          ? _buildNoSongs()
                          : _buildSongList(),
            ),
            // Mini Player
            Consumer<AudioProvider>(
              builder: (context, provider, child) {
                if (provider.currentSong == null) return SizedBox.shrink();
                return MiniPlayer();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'My Music',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Navigate to search screen
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSongList() {
    return ListView.builder(
      itemCount: _songs.length,
      itemBuilder: (context, index) {
        final song = _songs[index];
        return SongTile(
          song: song,
          onTap: () {
            context.read<AudioProvider>().setPlaylist(_songs, index);
          },
        );
      },
    );
  }

  Widget _buildPermissionDenied() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.music_off, size: 80, color: Colors.grey),
          SizedBox(height: 20),
          Text(
            'Storage Permission Required',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(height: 10),
          Text(
            'Please grant storage permission to access music',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await openAppSettings();
            },
            child: Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  Widget _buildNoSongs() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.music_note, size: 80, color: Colors.grey),
          SizedBox(height: 20),
          Text(
            'No Music Found',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(height: 10),
          Text(
            'Add some music files to your device',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}