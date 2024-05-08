import 'dart:async';

import 'package:demo_music_app/data/repo/Repository.dart';

import '../../data/models/Song.dart';

class MusicAppViewModel {
  StreamController<List<Song>> songStream = StreamController();

  void loadSongs(){
    final repository = DefaultRepository();

    repository.loadData().then((value) => songStream.add(value));
  }
}