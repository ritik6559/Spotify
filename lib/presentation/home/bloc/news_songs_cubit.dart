import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tune_box/domain/usecases/song/get_news_songs.dart';
import 'package:tune_box/presentation/home/bloc/new_songs_state.dart';
import 'package:tune_box/service_locator.dart';

class NewsSongsCubit extends Cubit<NewSongsState> {
  NewsSongsCubit() : super(NewsSongsLoading());

  Future<void> getNewsSongs() async {
    var songs = await sl<GetNewsSongsUseCase>().call();

    songs.fold(
      (l) {
        emit(NewsSongsLoadedFailue());
      },
      (data) {
        emit(
          NewsSongsLoaded(
            songs: data,
          ),
        );
      },
    );
  }
}
