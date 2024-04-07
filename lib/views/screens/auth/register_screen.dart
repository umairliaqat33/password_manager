// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:password_manager/models/user_model/user_model.dart';
import 'package:password_manager/repositories/auth_repository.dart';
import 'package:password_manager/repositories/firestore_repository.dart';
import 'package:password_manager/utils/utils.dart';
import 'package:password_manager/views/screens/tab_bar_screen/tab_bar_screen.dart';
import 'package:password_manager/views/widgets/logo_widget.dart';
import 'package:password_manager/views/widgets/text_fields/password_text_field.dart';
import 'package:password_manager/views/widgets/text_fields/text_form_field_widget.dart';

import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirestoreRepository _firestoreRepository = FirestoreRepository();
  final AuthRepository _authRepository = AuthRepository();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;
  bool isLoginError = false;
  String errorMessage = "Something Went Wrong Please Try again";
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['Email']);
  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Hero(
                      tag: 'logo',
                      child: LogoWidget(),
                    ),
                    Visibility(
                      visible: isLoginError,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          errorMessage,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormFieldWidget(
                      controller: _nameController,
                      validator: (value) => Utils.userNameValidator(value),
                      label: 'Name',
                      hintText: "Enter your name",
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormFieldWidget(
                      controller: _emailController,
                      validator: (value) => Utils.emailValidator(value),
                      label: 'Email',
                      hintText: "Enter your email",
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    PasswordTextField(
                      controller: _passController,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    showSpinner
                        ? const CircularProgressIndicator()
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Material(
                              color: Colors.purple,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30.0)),
                              elevation: 5.0,
                              child: MaterialButton(
                                onPressed: () {
                                  signUp(_emailController.text,
                                      _passController.text);
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                splashColor: null,
                                minWidth: 200.0,
                                height: 42.0,
                                child: const Text(
                                  'Register',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('Already have an account? '),
                        TextButton(
                          style: const ButtonStyle(
                              splashFactory: NoSplash
                                  .splashFactory //removing onclick splash color
                              ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: const Text("LogIn"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35,
                      child: GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("image/google_logo.png"),
                            const Text(
                              "oogle SignIn",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          try {
                            googleSignIn();
                          } catch (e) {
                            Fluttertoast.showToast(msg: e.toString());
                            if (kDebugMode) {
                              print(e.toString());
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    setState(() {
      showSpinner = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        UserCredential? userCredential =
            await _authRepository.signUp(email, password);
        _firestoreRepository.uploadUserInfo(
          UserModel(
              email: email,
              name: _nameController.text,
              uid: userCredential!.user!.uid),
        );
        Fluttertoast.showToast(msg: "Sign up successful");
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const TabBarScreen(),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      setState(() {
        showSpinner = false;
      });
      setState(() {
        isLoginError = true;
      });
    }
  }

  Future googleSignIn() async {
    setState(() {
      showSpinner = true;
    });
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential? userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    setState(() {
      _nameController.text = _user!.displayName.toString();
    });
    _firestoreRepository.uploadUserInfo(
      UserModel(
        email: _emailController.text,
        name: _nameController.text,
        uid: userCredential.user!.uid,
      ),
    );

    log(_nameController.text);

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const TabBarScreen(),
      ),
      (route) => false,
    );
    Fluttertoast.showToast(msg: credential.signInMethod);
    Fluttertoast.showToast(msg: "SignIn successful");
    setState(() {
      showSpinner = false;
    });
  }
}
