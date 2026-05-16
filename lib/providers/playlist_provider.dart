import 'package:flutter/material.dart';
import '../models/playlist_model.dart';
import '../models/song_model.dart';
import '../services/storage_service.dart';

class PlaylistProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();
  
  List<PlaylistModel> _playlists = [];
  List<String> _recentlyPlayedIds = [];

  List<PlaylistModel> get playlists => _playlists;
  List<String> get recentlyPlayedIds => _recentlyPlayedIds;

  PlaylistProvider() {
    loadDataFromStorage();
  }

  Future<void> loadDataFromStorage() async {
    _playlists = await _storageService.getPlaylists();
    _recentlyPlayedIds = await _storageService.getRecentlyPlayed();
    notifyListeners();
  }

  //Tạo playlist mới
  Future<void> createPlaylist(String name) async {
    final newPlaylist = PlaylistModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      songIds: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _playlists.add(newPlaylist);
    await _storageService.savePlaylists(_playlists);
    notifyListeners();
  }

  //Xóa playlist
  Future<void> deletePlaylist(String playlistId) async {
    _playlists.removeWhere((p) => p.id == playlistId);
    await _storageService.savePlaylists(_playlists);
    notifyListeners();
  }

  //Thêm bài hát vào playlist
  Future<void> addSongToPlaylist(String playlistId, String songId) async {
    final index = _playlists.indexWhere((p) => p.id == playlistId);
    if (index != -1) {
      if (!_playlists[index].songIds.contains(songId)) {
        List<String> updatedSongs = List.from(_playlists[index].songIds)..add(songId);
        _playlists[index] = _playlists[index].copyWith(songIds: updatedSongs);
        await _storageService.savePlaylists(_playlists);
        notifyListeners();
      }
    }
  }

  //Xóa bài hát khỏi playlist
  Future<void> removeSongFromPlaylist(String playlistId, String songId) async {
    final index = _playlists.indexWhere((p) => p.id == playlistId);
    if (index != -1) {
      List<String> updatedSongs = List.from(_playlists[index].songIds)..remove(songId);
      _playlists[index] = _playlists[index].copyWith(songIds: updatedSongs);
      await _storageService.savePlaylists(_playlists);
      notifyListeners();
    }
  }

  //Thêm bài hát vào danh sách vừa phát vừa phát
  Future<void> addToRecentlyPlayed(String songId) async {
    _recentlyPlayedIds.remove(songId); //Xóa nếu đã tồn tại để đưa lên đầu
    _recentlyPlayedIds.insert(0, songId);
    if (_recentlyPlayedIds.length > 10) {
      _recentlyPlayedIds.removeLast(); //Giới hạn 10 bài
    }
    await _storageService.saveRecentlyPlayed(_recentlyPlayedIds);
    notifyListeners();
  }
}