import 'package:flutter/material.dart';
import '../models/playlist_model.dart';
import '../models/song_model.dart';

class PlaylistProvider extends ChangeNotifier {
  List<PlaylistModel> _playlists = [];
  List<PlaylistModel> get playlists => _playlists;

  void createPlaylist(String name) {
    notifyListeners();
  }

  void addSongToPlaylist(String playlistId, SongModel song) {
    notifyListeners();
  }
}