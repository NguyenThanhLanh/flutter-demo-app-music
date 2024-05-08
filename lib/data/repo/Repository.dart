import 'package:demo_music_app/data/models/Song.dart';
import 'package:demo_music_app/data/source/DbSource.dart';

abstract class Repository {
  Future<List<Song>> loadData();
}

class DefaultRepository implements Repository {
  final _localDataSource = LocalDataSource();
  final _remoteDataSource = RemoteDataSource();
  @override
  Future<List<Song>> loadData() async {
    List<Song>? songs = [];
    final songRemote = await _remoteDataSource.loadData();
    if (songRemote == null) {
      final songLocal = await _localDataSource.loadData();
      if ( songLocal != null) {
        songs.addAll(songLocal);
      }
    } else {
      songs.addAll(songRemote);
    }
    return songs;
  }
}