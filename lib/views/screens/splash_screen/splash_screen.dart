import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:password_manager/repositories/auth_repository.dart';
import 'package:password_manager/views/screens/auth/login_screen.dart';

import 'package:password_manager/views/screens/tab_bar_screen/tab_bar_screen.dart';
import 'package:password_manager/views/widgets/logo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _createSplash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Hero(
              tag: 'logo',
              child: LogoWidget(),
            ),
            Text(
              "Welcome Back",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                fontFamily: 'Quicksand',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _createSplash() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        log("I am in splash duration");

        if (AuthRepository.userLoginStatus()) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const TabBarScreen(),
            ),
            (route) => false,
          );
        } else {
          log('No user logged in');
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        }
      },
    );
  }
}
