// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:password_manager/views/screens/auth/login_screen.dart';

creatingSignOutAlertDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          title: const Text('SignOut'),
          content: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(fontSize: 20, color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: "\nAre you sure you want to SignOut?",
                      style: TextStyle(fontSize: 15, color: Colors.red)),
                  TextSpan(
                      text: "\n*You can SigIn anytime*",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      )),
                ],
              )),
          actions: [
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['Email']);
                await googleSignIn.signOut();
                Fluttertoast.showToast(msg: "SignOutSuccessful");
                Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()))
                    .catchError((e) {
                  Fluttertoast.showToast(msg: e);
                });
              },
              child: const Text(
                "SignOut",
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
