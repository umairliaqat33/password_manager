import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PasswordCreation extends StatefulWidget {
  const PasswordCreation({super.key});

  @override
  State<StatefulWidget> createState() => _PasswordCreationState();
}

class _PasswordCreationState extends State<PasswordCreation> {
  final TextEditingController textController = TextEditingController();
  bool _isAlphabets = false;
  bool _isSpecialCharacters = false;
  bool _isDigits = false;
  double _sliderValue = 8;
  bool _isAnySelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    label: Text(
                      "Your Password",
                      style: TextStyle(color: Colors.purple),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.purple,
                  ),
                  enabled: false,
                  controller: textController,
                ),
                const SizedBox(height: 10),
                const Visibility(
                  visible: false,
                  child: Text(
                    "Please generate password first",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => _checkAndGeneratePassword(),
                      style: ButtonStyle(
                        foregroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.purple),
                      ),
                      child: const Text("Generate"),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        if (textController.text.isNotEmpty) {
                          Clipboard.setData(
                              ClipboardData(text: textController.text));
                          Fluttertoast.showToast(msg: "Password Copied");
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please generate password first");
                        }
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.purple),
                      ),
                      child: const Text("Copy"),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "Select checkbox to generate password",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.purple),
                ),
                Visibility(
                  visible: _isAnySelected,
                  child: const Text(
                    "Please make a selection below for password",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _isAlphabets,
                      onChanged: (v) {
                        setState(() {
                          _isAlphabets = !_isAlphabets;
                        });
                      },
                    ),
                    const Text(
                      "Alphabets",
                      style: TextStyle(color: Colors.purpleAccent),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _isSpecialCharacters,
                      onChanged: (v) {
                        setState(() {
                          _isSpecialCharacters = !_isSpecialCharacters;
                        });
                      },
                    ),
                    const Text(
                      "Special Characters",
                      style: TextStyle(
                        color: Colors.purpleAccent,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _isDigits,
                      onChanged: (v) {
                        setState(() {
                          _isDigits = !_isDigits;
                        });
                      },
                    ),
                    const Text(
                      "Digits",
                      style: TextStyle(
                        color: Colors.purpleAccent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text("Password Length: ",
                        style: TextStyle(color: Colors.purpleAccent)),
                    Text(
                      _sliderValue.toStringAsFixed(0),
                      style: const TextStyle(
                        color: Colors.purpleAccent,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 15),
                    overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 30),
                    activeTrackColor: Colors.purple,
                    thumbColor: Colors.purpleAccent,
                    inactiveTrackColor: const Color(0xFF8D8E98),
                    inactiveTickMarkColor: const Color(0xFF8D8E98),
                    activeTickMarkColor: Colors.pink,
                  ),
                  child: Slider(
                    value: _sliderValue,
                    divisions: 50,
                    max: 50.0,
                    min: 8,
                    onChanged: (v) => _toggleState(v),
                    label: _sliderValue.toStringAsFixed(0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toggleState(double value) {
    _sliderValue = value;
    setState(() {});
  }

  void _checkAndGeneratePassword() {
    if (_isAlphabets == false &&
        _isDigits == false &&
        _isSpecialCharacters == false) {
      setState(() {
        _isAnySelected = true;
      });
    } else {
      setState(() {
        _isAnySelected = false;
        textController.text = _generatePassword();
      });
    }
  }

  String _generatePassword() {
    const letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    const letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const number = '0123456789';
    const special = '@#%^*>\$@?/[]=+';

    String chars = "";
    if (_isAlphabets) chars += letterUpperCase;
    if (_isAlphabets) chars += letterLowerCase;
    if (_isDigits) chars += number;
    if (_isSpecialCharacters) chars += special;

    if (chars.isEmpty) return 'Please select an option first';

    return List.generate(_sliderValue.toInt(), (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join('');
  }
}
