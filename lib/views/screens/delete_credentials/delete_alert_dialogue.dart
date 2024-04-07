import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:password_manager/repositories/firestore_repository.dart';

creatingDeleteAlertDialog({
  required BuildContext context,
  required String website,
  required String userName,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          title: const Text('Delete Credentials'),
          content: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(fontSize: 20, color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: website,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                  const TextSpan(
                      text: "'s credentials",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                  const TextSpan(
                      text: "\nAre you sure you want to delete?",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      )),
                  const TextSpan(
                      text: "\n*Once deleted will never be restored*",
                      style: TextStyle(fontSize: 10, color: Colors.red))
                ],
              )),
          actions: [
            TextButton(
              onPressed: () {
                FirestoreRepository firestoreRepository = FirestoreRepository();
                firestoreRepository.deletePassword(userName);
                Fluttertoast.showToast(
                  msg: "Credentials deleted",
                );
                Navigator.of(context).pop();
              },
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        );
      });
}
