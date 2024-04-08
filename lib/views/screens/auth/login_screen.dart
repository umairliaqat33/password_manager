// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:password_manager/repositories/auth_repository.dart';
import 'package:password_manager/utils/exceptions.dart';
import 'package:password_manager/views/screens/auth/register_screen.dart';
import 'package:password_manager/views/screens/splash_screen/splash_screen.dart';
import 'package:password_manager/utils/utils.dart';
import 'package:password_manager/views/screens/tab_bar_screen/tab_bar_screen.dart';
import 'package:password_manager/views/widgets/general_widgets/logo_widget.dart';
import 'package:password_manager/views/widgets/text_fields/password_text_field.dart';
import 'package:password_manager/views/widgets/text_fields/text_form_field_widget.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthRepository _authRepository = AuthRepository();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showSpinner = false;
  bool isLoginError = false;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['Email']);
  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
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
                  const SizedBox(
                    height: 48.0,
                  ),
                  Visibility(
                    visible: isLoginError,
                    child: const Text(
                      "Please check your email or password",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                      ),
                    ),
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
                    height: 24.0,
                  ),
                  _showSpinner
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Material(
                            color: Colors.purple,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30.0)),
                            elevation: 5.0,
                            child: MaterialButton(
                              onPressed: () {
                                singIn(_emailController.text,
                                    _passController.text);
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              minWidth: 200.0,
                              height: 42.0,
                              child: const Text(
                                'Log In',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Don\'t have an account? '),
                      TextButton(
                        style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegistrationScreen()));
                        },
                        child: const Text("SignUp"),
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
    );
  }

  void singIn(String email, String password) async {
    setState(() {
      _showSpinner = true;
    });
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential? userCredential =
            await _authRepository.signIn(email, password);
        if (userCredential != null) {
          Fluttertoast.showToast(msg: "Login Successfull");
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const TabBarScreen(),
            ),
            (route) => false,
          );
        }
      } on IncorrectPasswordOrUserNotFound catch (e) {
        Fluttertoast.showToast(msg: e.message);
        log(e.message);
      } on NoInternetException catch (e) {
        Fluttertoast.showToast(msg: e.message);
        log(e.message);
      } on UnknownException catch (e) {
        Fluttertoast.showToast(msg: e.message);
        log(e.message);
      }
    }
    setState(() {
      _showSpinner = false;
    });
  }

  Future googleSignIn() async {
    final googleUser = await _googleSignIn.signIn();
    setState(() {
      _showSpinner = true;
    });
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    setState(() {
      _showSpinner = false;
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SplashScreen()));
  }
}
