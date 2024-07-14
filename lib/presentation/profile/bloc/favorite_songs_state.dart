import 'package:tune_box/domain/entities/song/song_entity.dart';

abstract class FavoriteSongsState {}

class FavoriteSongsLoading extends FavoriteSongsState {}

class FavoriteSongsLoaded extends FavoriteSongsState {
  final List<SongEntity> favoriteSongs;
  FavoriteSongsLoaded({
    required this.favoriteSongs,
  });
}

class FavoriteSongsFailure extends FavoriteSongsState {}
