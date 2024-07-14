import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tune_box/domain/entities/song/song_entity.dart';
import 'package:tune_box/domain/usecases/song/get_favorite_song_usecase.dart';
import 'package:tune_box/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:tune_box/service_locator.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  FavoriteSongsCubit() : super(FavoriteSongsLoading());

  List<SongEntity> favoriteSongs = [];

  Future<void> getFavoriteSongs() async {
    try {
      var result = await sl<GetFavoriteSongUsecase>().call();

      result.fold(
        (l) {
          emit(
            FavoriteSongsFailure(),
          );
        },
        (r) {
          favoriteSongs = r;
          emit(
            FavoriteSongsLoaded(favoriteSongs: favoriteSongs),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  void removeSong(int index) {
    favoriteSongs.removeAt(index);
    emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs));
  }
}
