import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext{
  ThemeData get theme => Theme.of(this); 
  TextTheme get textTheme => Theme.of(this).textTheme; 
  Color get primaryColor => Theme.of(this).primaryColor; 
}