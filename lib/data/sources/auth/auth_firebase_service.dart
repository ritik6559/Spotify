import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tune_box/data/models/auth/create_user_req.dart';
import 'package:tune_box/data/models/auth/signin_user_req.dart';
import 'package:tune_box/data/models/user/user_model.dart';

abstract class AuthFirebaseService {
  Future<Either> signUp(CreateUserReq createUserReq);
  Future<Either> signIn(SigninUserReq signUserReq);
  Future<void> signOut();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signIn(SigninUserReq signUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signUserReq.email,
        password: signUserReq.password,
      );
      return const Right("Signin was SuccessFul");
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'invalid-email') {
        message = 'Wrong email';
      } else if (e.code == 'invalid-credential') {
        message = "Wrong password";
      }
      return Left(message);
    }
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password,
      );

      FirebaseFirestore.instance.collection("users").add(
        UserModel(
            id: userCredential.user!.uid,
            name: createUserReq.name,
            email: createUserReq.email,
          ).toMap());
      return const Right("Signup was SuccessFul");
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'weak-password') {
        message = 'The password is weak';
      } else if (e.code == 'email-already-in-use') {
        message = "The mail is already in use";
      }
      return Left(message);
    }
  }
}
