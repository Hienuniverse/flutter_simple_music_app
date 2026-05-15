import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/audio_player_service.dart';
import 'services/storage_service.dart';
import 'providers/audio_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/playlist_provider.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const OfflineMusicApp());
}

class OfflineMusicApp extends StatelessWidget {
  const OfflineMusicApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AudioProvider(
            AudioPlayerService(),
            StorageService(),
          ),
        ),
        ChangeNotifierProvider(create: (context) => PlaylistProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MaterialApp(
        title: 'Simple Offline Music',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: const Color(0xFF1DB954), //Spotify Green
          scaffoldBackgroundColor: const Color(0xFF191414), //Dark Background
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF1DB954),
            secondary: Colors.white,
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}