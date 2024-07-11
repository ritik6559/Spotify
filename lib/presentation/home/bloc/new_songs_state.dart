import 'package:tune_box/domain/entities/song/song_entity.dart';

abstract class NewSongsState {}

class NewsSongsLoading extends NewSongsState {}

class NewsSongsLoaded extends NewSongsState {
  final List<SongEntity> songs;
  NewsSongsLoaded({
    required this.songs,
  });
}

class NewsSongsLoadedFailue extends NewSongsState{}
