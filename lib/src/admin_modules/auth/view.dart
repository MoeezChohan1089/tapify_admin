import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/constants/assets.dart';
import '../../utils/constants/colors.dart';
import 'components/customLoginForm.dart';
import 'components/signInButton.dart';
import 'logic.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key? key}) : super(key: key);

  final logic = Get.put(AuthLogic());
  final state = Get.find<AuthLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.customWhiteTextColor,
      body: CustomLoginForm(),
    );
  }
}
