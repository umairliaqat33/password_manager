import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:password_manager/utils/exceptions.dart';
import 'package:password_manager/utils/strings.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signUp(
    String email,
    String password,
  ) async {
    UserCredential? userCredential;
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw EmailAlreadyExistException('Email already in use');
      } else {
        throw UnknownException(
            '${"Something went wrong"}${e.code} ${e.message}');
      }
    }
    return userCredential;
  }

  Future<UserCredential?> signIn(
    String email,
    String password,
  ) async {
    UserCredential? userCredential;
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' ||
          e.code == 'user-not-found' ||
          e.code == 'invalid-credential') {
        throw IncorrectPasswordOrUserNotFound(AppStrings.enteredWrongPassword);
      } else if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException('Something went wrong ${e.code} ${e.message}');
      }
    }
    return userCredential;
  }

  static bool userLoginStatus() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    } else {
      return true;
    }
  }
}
