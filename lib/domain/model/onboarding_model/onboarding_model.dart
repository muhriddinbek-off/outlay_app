import 'package:flutter/material.dart';

class OnBoardingModel {
  final Widget picture;
  final String text;
  final String buttonName;
  final int key;

  OnBoardingModel(
      {required this.picture,
        required this.text,
        required this.buttonName,
        required this.key});
}