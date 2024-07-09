import 'package:dartz/dartz.dart';
import 'package:tune_box/data/models/auth/create_user_req.dart';

abstract class AuthRepository {
  Future<Either> signUp(CreateUserReq createUserReq);
  Future<void> signIn();
  Future<void> signOut();
}
