class Song {

  String id;
  String title;
  String album;
  String artist;
  String source;
  String image;
  int  duration;

  Song({required this.id,required this.title,required this.album,required this.artist,required this.source,required this.image,
    required this.duration});

  factory Song.fromJson(Map<String, dynamic> dataFromJson){
    return Song(
        id: dataFromJson['id'],
        title: dataFromJson['title'],
        album: dataFromJson['album'],
        artist: dataFromJson['artist'],
        source: dataFromJson['source'],
        image: dataFromJson['image'],
        duration: dataFromJson['duration']
    );
  }

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
      other is Song && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Song{id: $id, title: $title, album: $album, artist: $artist, source: $source, image: $image, duration: $duration}';
  }
}