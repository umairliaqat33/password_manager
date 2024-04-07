import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

createDialogBox({
  required BuildContext context,
  required String email,
  required String username,
  required String password,
  required String website,
}) {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final websiteController = TextEditingController();
  final passwordController = TextEditingController();
  bool isCopyErrorVisible = false;

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
          title: const Text("View Credentials"),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Visibility(
                    visible: isCopyErrorVisible,
                    child: const Text(
                      "Something went wrong try again",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            if (emailController.text.isNotEmpty) {
                              Clipboard.setData(
                                  ClipboardData(text: emailController.text));
                              Fluttertoast.showToast(msg: "Text Copied");
                              isCopyErrorVisible = false;
                            } else {
                              isCopyErrorVisible = true;
                            }
                          },
                          icon: const Icon(Icons.copy)),
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: Colors.purpleAccent),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                    ),
                    controller: emailController,
                  ),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            if (usernameController.text.isNotEmpty) {
                              Clipboard.setData(
                                  ClipboardData(text: usernameController.text));
                              Fluttertoast.showToast(msg: "Text Copied");
                              isCopyErrorVisible = false;
                            } else {
                              isCopyErrorVisible = true;
                            }
                          },
                          icon: const Icon(Icons.copy)),
                      labelText: 'Username',
                      labelStyle: const TextStyle(color: Colors.purpleAccent),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                    ),
                    controller: usernameController,
                  ),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            if (passwordController.text.isNotEmpty) {
                              Clipboard.setData(
                                  ClipboardData(text: passwordController.text));
                              Fluttertoast.showToast(msg: "Text Copied");
                              isCopyErrorVisible = false;
                            } else {
                              isCopyErrorVisible = true;
                            }
                          },
                          icon: const Icon(Icons.copy)),
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.purpleAccent),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                    ),
                    controller: passwordController,
                  ),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (websiteController.text.isNotEmpty) {
                            Clipboard.setData(
                                ClipboardData(text: websiteController.text));
                            Fluttertoast.showToast(msg: "Text Copied");
                            isCopyErrorVisible = false;
                          } else {
                            isCopyErrorVisible = true;
                          }
                        },
                        icon: const Icon(Icons.copy),
                      ),
                      labelText: 'Website/App',
                      labelStyle: const TextStyle(color: Colors.purpleAccent),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                    ),
                    controller: websiteController,
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
