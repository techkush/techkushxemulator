import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TechKushTextField extends StatelessWidget {
  FocusNode focusNode;
  TextEditingController textController;
  String hintText;
  bool passwordText;
  bool textCapital;
  bool textCharacters;
  bool textInputType;

  TechKushTextField(
      {super.key, required this.focusNode,
        required this.textController,
        this.passwordText = false,
        this.textCapital = false,
        this.textInputType = false,
        this.textCharacters = false,
        required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF1EFF5),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          controller: textController,
          style: const TextStyle(fontSize: 16),
          obscureText: passwordText,
          cursorColor: const Color(0xff8f41f9),
          textCapitalization: textCapital
              ? textCharacters
              ? TextCapitalization.characters
              : TextCapitalization.words
              : TextCapitalization.none,
          keyboardType:
          textInputType ? TextInputType.number : TextInputType.text,
          textInputAction: TextInputAction.next,
          onEditingComplete: () => focusNode.nextFocus(),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black12)),
        ),
      ),
    );
  }
}