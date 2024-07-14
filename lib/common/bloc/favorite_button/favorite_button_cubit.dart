import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tune_box/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:tune_box/domain/usecases/song/add_remove_favorite_use_case.dart';
import 'package:tune_box/service_locator.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  FavoriteButtonCubit() : super(FavoriteButtonInitial());

  Future<void> favoriteButtonUpdated(String songId) async {
    
    var result = await sl<AddOrRemoveFavoriteUseCase>().call(
      params: songId
    );
    result.fold(
      (l){},
      (isFavorite){
        emit(
          FavoriteButtonUpdated(
            isFavorite: isFavorite
          )
        );
      },
    );
  }
}
