import 'package:dartz/dartz.dart';
import 'package:tune_box/core/usecases/usecase.dart';
import 'package:tune_box/data/models/auth/create_user_req.dart';
import 'package:tune_box/domain/repository/auth/auth_repository.dart';
import 'package:tune_box/service_locator.dart';

class SignupUsecase extends UseCase<Either, CreateUserReq> {
  @override
  Future<Either> call({CreateUserReq? params}) {
    return sl<AuthRepository>().signUp(params!);
  }
}
