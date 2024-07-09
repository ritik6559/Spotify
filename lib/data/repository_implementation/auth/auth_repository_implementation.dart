import 'package:tune_box/data/models/auth/create_user_req.dart';
import 'package:tune_box/data/sources/auth/auth_firebase_service.dart';
import 'package:tune_box/domain/repository/auth/auth_repository.dart';
import 'package:tune_box/service_locator.dart';

class AuthRepositoryImplementation extends AuthRepository {
  @override
  Future<void> signIn() {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(CreateUserReq createUserReq) async {
    await sl<AuthFirebaseService>().signUp(createUserReq);
  }
}
