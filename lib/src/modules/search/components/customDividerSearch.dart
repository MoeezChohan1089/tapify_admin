
import 'package:flutter/material.dart';

import '../../../utils/constants/margins_spacnings.dart';

class CustomDividerSearch extends StatelessWidget {
  const CustomDividerSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            top: pageMarginHorizontal,
            bottom: pageMarginHorizontal / 2
        ),
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1.0,
                ),
              )
          ),
        )
    );
  }
}
