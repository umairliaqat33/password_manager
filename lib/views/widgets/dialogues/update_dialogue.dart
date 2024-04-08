import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:password_manager/models/password_model/password_model.dart';
import 'package:password_manager/repositories/firestore_repository.dart';
import 'package:password_manager/utils/utils.dart';
import 'package:password_manager/views/widgets/text_fields/text_form_field_widget.dart';

createUpdateDialogBox({
  required BuildContext context,
  required String email,
  required String username,
  required String password,
  required String website,
}) {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  return showDialog(
      context: context,
      builder: (context) {
        emailController.text = email;
        usernameController.text = username;
        passwordController.text = password;
        websiteController.text = website;
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          title: const Text("Update Credentials"),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormFieldWidget(
                      controller: passwordController,
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
                      controller: usernameController,
                      validator: (value) => Utils.userNameValidator(value),
                      label: "User Name ",
                      hintText: "Enter your name",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormFieldWidget(
                      controller: emailController,
                      validator: (value) => Utils.emailValidator(value),
                      label: "Email",
                      hintText: "Enter your email",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormFieldWidget(
                      controller: websiteController,
                      validator: (value) => Utils.websiteValidator(value),
                      label: "Website/App name",
                      hintText: "i.e. Facebook or Instagram",
                      inputAction: TextInputAction.done,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final FirestoreRepository firestoreRepository =
                    FirestoreRepository();
                firestoreRepository.updatePassword(
                  PasswordModel(
                    email: emailController.text,
                    userName: usernameController.text,
                    password: passwordController.text,
                    website: websiteController.text,
                  ),
                  username,
                );
                Fluttertoast.showToast(msg: "Credentials updated");
                Navigator.of(context).pop();
              },
              child: const Text(
                "Update",
                style: TextStyle(color: Colors.purple),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.purple),
              ),
            ),
          ],
        );
      });
}
