import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tune_box/domain/usecases/auth/get_user_usecase.dart';
import 'package:tune_box/presentation/profile/bloc/profile_info_state.dart';
import 'package:tune_box/service_locator.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoLoading());

  Future<void> getUser() async {
    var result = await sl<GetUserUsecase>().call();

    result.fold(
      (l) {
        emit(
          ProfileInfoFailure(),
        );
      },
      (r) {
        emit(
          ProfileInfoLoaded(userEntity: r),
        );
      },
    );
  }
}
