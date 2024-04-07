import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:password_manager/models/password_model/password_model.dart';
import 'package:password_manager/models/user_model/user_model.dart';
import 'package:password_manager/utils/collection_names.dart';
import 'package:password_manager/utils/exceptions.dart';

class FirestoreRepository {
  final User? _user = FirebaseAuth.instance.currentUser;
  void uploadUserInfo(UserModel userModel) async {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.usersCollection)
          .doc(userModel.uid)
          .set(
            userModel.toJson(),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${"Something went wrong"} ${e.code} ${e.message}");
      }
    }
  }

  Future<UserModel> getUserData() async {
    return CollectionsNames.firestoreCollection
        .collection(CollectionsNames.usersCollection)
        .doc(_user!.uid)
        .get()
        .then(
          (value) => UserModel.fromJson(value.data()!),
        );
  }

  static User? checkUser() {
    User? user = CollectionsNames.firebaseAuth.currentUser;
    return user;
  }

  void uploadPassword(PasswordModel passwordModel) {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.usersCollection)
          .doc(FirestoreRepository.checkUser()!.uid)
          .collection(CollectionsNames.passwordCollection)
          .doc(passwordModel.userName)
          .set(
            passwordModel.toJson(),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${"Something went wrong"} ${e.code} ${e.message}");
      }
    }
  }

  void updatePassword(
    PasswordModel passwordModel,
    String docId,
  ) {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.usersCollection)
          .doc(FirestoreRepository.checkUser()!.uid)
          .collection(CollectionsNames.passwordCollection)
          .doc(docId)
          .update(
            passwordModel.toJson(),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${"Something went wrong"} ${e.code} ${e.message}");
      }
    }
  }

  Stream<List<PasswordModel?>> getAllPasswords() {
    return CollectionsNames.firestoreCollection
        .collection(CollectionsNames.usersCollection)
        .doc(FirestoreRepository.checkUser()!.uid)
        .collection(CollectionsNames.passwordCollection)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => PasswordModel.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<PasswordModel?>> searchPasswords(String searchValue) {
    return CollectionsNames.firestoreCollection
        .collection(CollectionsNames.usersCollection)
        .doc(FirestoreRepository.checkUser()!.uid)
        .collection(CollectionsNames.passwordCollection)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .where(
                (doc) => (doc['website'] as String).toLowerCase().contains(
                      searchValue.toLowerCase(),
                    ),
              )
              .map(
                (doc) => PasswordModel.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  void deletePassword(String docId) {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.usersCollection)
          .doc(FirestoreRepository.checkUser()!.uid)
          .collection(CollectionsNames.passwordCollection)
          .doc(docId)
          .delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${"Something went wrong"} ${e.code} ${e.message}");
      }
    }
  }
}
