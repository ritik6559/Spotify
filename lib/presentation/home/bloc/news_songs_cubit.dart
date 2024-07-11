import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tune_box/domain/usecases/song/get_news_songs.dart';
import 'package:tune_box/presentation/home/bloc/new_songs_state.dart';
import 'package:tune_box/service_locator.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {

  NewsSongsCubit() : super(NewsSongsLoading());

  Future < void > getNewsSongs() async {
    var returnedSongs = await sl < GetNewsSongsUseCase > ().call();
    returnedSongs.fold(
      (l) {
        emit(NewsSongsLoadFailure());
      },
      (data) {
        emit(
          NewsSongsLoaded(songs: data)
        );
      }
    );
  }
  
  
}