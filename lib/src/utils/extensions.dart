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


extension StringColorExtension on String {
  Color toColor() {
    String colorString = toString();
    if (colorString.startsWith('#')) {
      colorString = colorString.substring(1);
    }
    final parsedColor = int.parse(colorString, radix: 16);
    const opacity = 0xFF000000;
    final combinedColor = parsedColor + opacity;
    return Color(combinedColor);
  }
}



extension NumberFormatting on num {
  String formatWithCommas() {
    String valueString = toStringAsFixed(2);
    final parts = valueString.split('.');
    final wholeNumberPart = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    );
    final decimalPart = parts[1];
    return '$wholeNumberPart.$decimalPart';
  }
}

double convertToDouble(dynamic value) {
  if (value is int) {
    return value.toDouble();
  } else if (value is double) {
    return value;
  } else {
    throw ArgumentError("Value $value cannot be converted to double.");
  }
}

// extension NumberFormatting on num {
//   String formatWithCommas() {
//     String valueString = toString();
//     if (valueString.contains('.')) {
//       List<String> parts = valueString.split('.');
//       String wholeNumberPart = parts[0];
//       String decimalPart = parts[1];
//       String formattedWholeNumber = wholeNumberPart.replaceAllMapped(
//         RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
//             (Match m) => '${m[1]},',
//       );
//       return '$formattedWholeNumber.$decimalPart';
//     } else {
//       return valueString.replaceAllMapped(
//         RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
//             (Match m) => '${m[1]},',
//       );
//     }
//   }
// }