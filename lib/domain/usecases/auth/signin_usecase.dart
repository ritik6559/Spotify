import 'package:dartz/dartz.dart';
import 'package:tune_box/core/usecases/usecase.dart';
import 'package:tune_box/data/models/auth/signin_user_req.dart';
import 'package:tune_box/domain/repository/auth/auth_repository.dart';
import 'package:tune_box/service_locator.dart';

class SigninUsecase extends UseCase<Either, SigninUserReq> {
  @override
  Future<Either> call({SigninUserReq? params}) async{
    return sl<AuthRepository>().signIn(params!);
  }
}
