
import 'package:cloud_firestore/cloud_firestore.dart';

class SongModel {
  final String title;
  final String artist;
  final num duration;
  final Timestamp release;
  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.release,
  });

  SongModel copyWith({
    String? title,
    String? artist,
    num? duration,
    Timestamp? release,
  }) {
    return SongModel(
      title: title ?? this.title,
      artist: artist ?? this.artist,
      duration: duration ?? this.duration,
      release: release ?? this.release,
    );
  }

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      title: map['title'] ?? '',
      artist: map['artist'] ?? '',
      duration: map['duration'] ?? 0,
      release: map['release'],
    );
  }
}
