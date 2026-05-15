import 'package:on_audio_query/on_audio_query.dart' as audio_query;
import '../models/song_model.dart';

class PlaylistService {
  final audio_query.OnAudioQuery _audioQuery = audio_query.OnAudioQuery();

  //Get all songs from device
  Future<List<SongModel>> getAllSongs() async {
    try {
      //Nhận list nhạc từ thư viện, sử dụng kiểu audio_query.SongModel để không bị trùng
      final List<audio_query.SongModel> audioList = await _audioQuery.querySongs(
        sortType: audio_query.SongSortType.TITLE,
        orderType: audio_query.OrderType.ASC_OR_SMALLER,
        uriType: audio_query.UriType.EXTERNAL,
        ignoreCase: true,
      );
      
      //Chuyển đổi từ SongModel của thư viện sang SongModel của app chúng ta
      return audioList.map((audio) => SongModel.fromAudioQuery(audio)).toList();
    } catch (e) {
      throw Exception('Error loading songs: $e');
    }
  }

  //Get songs by artist
  Future<List<SongModel>> getSongsByArtist(String artist) async {
    final allSongs = await getAllSongs();
    return allSongs.where((song) => song.artist == artist).toList();
  }

  //Get songs by album
  Future<List<SongModel>> getSongsByAlbum(String album) async {
    final allSongs = await getAllSongs();
    return allSongs.where((song) => song.album == album).toList();
  }

  //Search songs
  Future<List<SongModel>> searchSongs(String query) async {
    final allSongs = await getAllSongs();
    final lowerQuery = query.toLowerCase();
    return allSongs.where((song) {
      return song.title.toLowerCase().contains(lowerQuery) ||
             song.artist.toLowerCase().contains(lowerQuery) ||
             (song.album?.toLowerCase().contains(lowerQuery) ?? false);
    }).toList();
  }
}