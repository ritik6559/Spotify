import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tune_box/domain/entities/song/song_entity.dart';

class SongModel {
  String ? title;
  String ? artist;
  num ? duration;
  Timestamp ? release;

  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.release
  });

  SongModel.fromJson(Map<String,dynamic> data) {
    title = data['title'];
    artist = data['artist'];
    duration = data['duration'];
    release = data['release'];
  }
}

extension SongModelX on SongModel {

  SongEntity toEntity() {
    return SongEntity(
      title: title!,
      artist: artist!,
      duration: duration!,
      release: release!,
    
    );
  }
}