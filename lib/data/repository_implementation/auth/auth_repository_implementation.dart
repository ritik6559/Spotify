import 'package:dartz/dartz.dart';
import 'package:tune_box/data/models/auth/create_user_req.dart';
import 'package:tune_box/data/models/auth/signin_user_req.dart';
import 'package:tune_box/data/sources/auth/auth_firebase_service.dart';
import 'package:tune_box/domain/repository/auth/auth_repository.dart';
import 'package:tune_box/service_locator.dart';

class AuthRepositoryImplementation extends AuthRepository {
  @override
  Future<Either> signIn(SigninUserReq signInUserReq) async{
    return await sl<AuthFirebaseService>().signIn(signInUserReq);  
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
    return await sl<AuthFirebaseService>().signUp(createUserReq);
  }
  
  @override
  Future<Either> getUser() async{
    return await sl<AuthFirebaseService>().getUser();
  }
}
