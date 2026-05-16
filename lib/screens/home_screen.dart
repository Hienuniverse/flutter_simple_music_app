import 'package:flutter/material.dart';
import 'package:flutter_simple_offline_music_app/models/song_model.dart';
import 'package:flutter_simple_offline_music_app/providers/audio_provider.dart';
import 'package:flutter_simple_offline_music_app/services/permission_service.dart';
import 'package:flutter_simple_offline_music_app/services/playlist_service.dart';
import 'package:flutter_simple_offline_music_app/widgets/mini_player.dart';
import 'package:flutter_simple_offline_music_app/widgets/song_tile.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

//Thêm import các màn hình mới
import 'package:flutter_simple_offline_music_app/screens/search_screen.dart';
import 'package:flutter_simple_offline_music_app/screens/playlist_screen.dart';
import 'package:flutter_simple_offline_music_app/screens/settings_screen.dart';

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
      backgroundColor: const Color(0xFF191414),
      //THÊM MỚI: Thanh điều hướng Menu (Drawer)
      drawer: Drawer(
        backgroundColor: const Color(0xFF282828),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF191414)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.music_note, color: Color(0xFF1DB954), size: 48),
                  SizedBox(height: 10),
                  Text('Simple Music', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.library_music, color: Colors.white),
              title: const Text('Thư viện nhạc', style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.playlist_play, color: Colors.white),
              title: const Text('Playlists của tôi', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => PlaylistScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text('Cài đặt', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            //App Bar đã được chỉnh sửa
            _buildAppBar(),
            //Content
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : !_hasPermission
                      ? _buildPermissionDenied()
                      : _songs.isEmpty
                          ? _buildNoSongs()
                          : _buildSongList(),
            ),
            //Mini Player
            Consumer<AudioProvider>(
              builder: (context, provider, child) {
                if (provider.currentSong == null) return const SizedBox.shrink();
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
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Nút bấm mở Drawer điều hướng
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 28),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          const Text(
            'My Music',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          //Nút mở màn hình tìm kiếm bài hát
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 28),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
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
          const Icon(Icons.music_off, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          const Text(
            'Storage Permission Required',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 10),
          const Text(
            'Please grant storage permission to access music',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await openAppSettings();
            },
            child: const Text('Open Settings'),
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
          const Icon(Icons.music_note, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          const Text(
            'No Music Found',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 10),
          const Text(
            'Add some music files to your device',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}