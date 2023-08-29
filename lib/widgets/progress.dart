import 'package:flutter/material.dart';

Container circularProgress() {
  return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 10.0),
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Color(0xff893BF7)),
      ));
}

Container linearProgress() {
  return Container(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: const LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Color(0xff893BF7)),
      backgroundColor: Colors.white,
    ),
  );
}