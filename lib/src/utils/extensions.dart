import 'package:flutter/material.dart';

extension SizedBoxExtension on num {
  SizedBox get heightBox => SizedBox(height: toDouble());
  SizedBox get widthBox => SizedBox(width: toDouble());
}

extension SizedBoxDoubleExtension on double {
  SizedBox get heightBox => SizedBox(height: this);
  SizedBox get widthBox => SizedBox(width: this);
}


extension ThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get text => theme.textTheme;
  double get deviceHeight => MediaQuery.of(this).size.height;
  double get deviceWidth => MediaQuery.of(this).size.width;
}