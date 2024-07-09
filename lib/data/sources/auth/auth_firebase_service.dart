import 'package:firebase_auth/firebase_auth.dart';
import 'package:tune_box/data/models/auth/create_user_req.dart';

abstract class AuthFirebaseService {
  Future<void> signUp(CreateUserReq createUserReq);
  Future<void> signIn();
  Future<void> signOut();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
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
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password,
      );
    } on FirebaseAuthException catch (e) {}
  }
}
