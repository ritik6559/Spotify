import 'package:dartz/dartz.dart';
import 'package:tune_box/core/usecases/usecase.dart';
import 'package:tune_box/domain/repository/auth/auth_repository.dart';
import 'package:tune_box/service_locator.dart';

class GetUserUsecase extends UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async{
    return sl<AuthRepository>().getUser();
  }
}
