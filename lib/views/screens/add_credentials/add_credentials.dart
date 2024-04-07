import 'dart:developer' as log;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:password_manager/models/password_model/password_model.dart';
import 'package:password_manager/repositories/firestore_repository.dart';
import 'package:password_manager/utils/colors.dart';
import 'package:password_manager/utils/exceptions.dart';
import 'package:password_manager/utils/utils.dart';
import 'package:password_manager/views/widgets/text_fields/text_form_field_widget.dart';

class AddCredentials extends StatefulWidget {
  const AddCredentials({super.key});

  @override
  State<AddCredentials> createState() => _AddCredentialsState();
}

class _AddCredentialsState extends State<AddCredentials> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _websiteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showSpinner = false;
  bool _isPasswordGenerated = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      title: const Text("Add Credentials"),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormFieldWidget(
                controller: _passwordController,
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return "Password is required";
                  } else {
                    return null;
                  }
                },
                label: "Password",
                hintText: "Your password",
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormFieldWidget(
                controller: _usernameController,
                validator: (value) => Utils.userNameValidator(value),
                label: "User Name ",
                hintText: "Enter your name",
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormFieldWidget(
                controller: _emailController,
                validator: (value) => Utils.emailValidator(value),
                label: "Email",
                hintText: "Enter your email",
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormFieldWidget(
                controller: _websiteController,
                validator: (value) => Utils.websiteValidator(value),
                label: "Website/App name",
                hintText: "i.e. Facebook or Instagram",
                inputAction: TextInputAction.done,
              ),
              const SizedBox(
                height: 8,
              ),
              Visibility(
                visible: _isPasswordGenerated,
                child: ElevatedButton(
                  onPressed: () {
                    _passwordController.text = _generatePassword();
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  child: const Text(
                    "Generate Password",
                    style: TextStyle(
                      fontSize: 12,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              _showSpinner
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: () => _savePassword(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                      ),
                      child: const Text(
                        "Add Credentials",
                        style: TextStyle(
                          fontSize: 13,
                          color: whiteColor,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  String _generatePassword() {
    const letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    const letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const number = '0123456789';
    const special = '@#%^*>\$@?/[]=+';

    String chars = letterUpperCase + letterLowerCase + number + special;
    Fluttertoast.showToast(
        msg: "Am alphanumeric password of 12 characters was generated");
    return List.generate(12, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join('');
  }

  void _savePassword() {
    setState(() {
      _showSpinner = true;
    });
    FocusManager.instance.primaryFocus?.unfocus();
    final FirestoreRepository firestoreRepository = FirestoreRepository();
    try {
      if (_passwordController.text.isEmpty) {
        setState(() {
          _isPasswordGenerated = true;
        });
      } else {
        setState(() {
          _isPasswordGenerated = false;
        });
      }
      if (_formKey.currentState!.validate()) {
        firestoreRepository.uploadPassword(
          PasswordModel(
              email: _emailController.text,
              userName: _usernameController.text,
              password: _passwordController.text,
              website: _websiteController.text),
        );
        Fluttertoast.showToast(msg: "Credentials Uploaded");
        Navigator.of(context).pop();
      }
    } on NoInternetException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log.log(e.message);
    } on UnknownException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log.log(e.message);
    }
    setState(() {
      _showSpinner = false;
    });
  }
}
