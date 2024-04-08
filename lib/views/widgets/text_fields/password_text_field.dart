import 'package:flutter/material.dart';

import 'package:password_manager/config/size_config.dart';
import 'package:password_manager/constants/text_field_decoration.dart';
import 'package:password_manager/utils/colors.dart';
import 'package:password_manager/utils/utils.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.controller,
    this.textFieldFilled = true,
  });
  final TextEditingController controller;
  final bool? textFieldFilled;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _textVisible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 3,
          ),
          child: Text(
            'Password',
            style: TextStyle(
              color: blackColor,
              fontWeight: FontWeight.w400,
              fontSize: SizeConfig.font12(context) + 1,
            ),
          ),
        ),
        SizedBox(
          height: SizeConfig.width8(context),
        ),
        TextFormField(
          validator: (value) => Utils.passwordValidator(value),
          textInputAction: TextInputAction.done,
          obscureText: _textVisible,
          controller: widget.controller,
          decoration: TextFieldDecoration.kPasswordFieldDecoration.copyWith(
            filled: widget.textFieldFilled,
            fillColor: textFieldFillColor,
            hintText: 'Password mini 8 characters',
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _textVisible = !_textVisible;
                });
              },
              icon: _textVisible
                  ? const Icon(
                      Icons.visibility,
                      size: 20,
                      color: greyColor,
                    )
                  : const Icon(
                      Icons.visibility_off,
                      size: 20,
                      color: greyColor,
                    ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
              borderSide: BorderSide(
                color: greyColor.withOpacity(0.3),
              ),
            ),
            disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
              borderSide: BorderSide(
                color: greyColor,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
              borderSide: BorderSide(
                color: redColor,
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
              borderSide: BorderSide(
                color: redColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
