import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'state.dart';

class AuthLogic extends GetxController {
  static AuthLogic get to => Get.find();
  final AuthState state = AuthState();

  TextEditingController emailAdminController = TextEditingController();
  TextEditingController passwordAdminController = TextEditingController();

  RxBool obscureText = true.obs;
  GlobalKey<FormState> formKeyValue = GlobalKey<FormState>();
  RxBool isProcessing = false.obs;

}
