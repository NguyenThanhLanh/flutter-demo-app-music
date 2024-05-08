import 'dart:convert';
import 'package:demo_music_app/data/models/Song.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
abstract interface class DataSource {
  Future<List<Song>?> loadData();
}

class RemoteDataSource implements DataSource {
  @override
  Future<List<Song>?> loadData() async {
    const url = "https://thantrieu.com/resources/braniumapis/songs.json";
    final urlSource = Uri.parse(url);
    final res = await http.get(urlSource);
    if(res.statusCode == 200){
      final contentBody = utf8.decode(res.bodyBytes);
      var songWrapper = jsonDecode(contentBody) as Map;
      var listSong = songWrapper['songs'] as List;
      List<Song> songs = listSong.map((song) => Song.fromJson(song)).toList();
      return songs;
    } else {
      return null;
    }

  }

}

class LocalDataSource implements DataSource {
  @override
  Future<List<Song>?> loadData() async {
    try {
      final String jsonDataStr = await rootBundle.loadString('assets/songs.json');
      final jsonBodyData = jsonDecode(jsonDataStr) as Map;
      final listSong = jsonBodyData['songs'] as List;
      final result = listSong.map((song) => Song.fromJson(song)).toList();
      return result;
    } catch (e){
      debugPrint(e.toString());
    }
  }
}