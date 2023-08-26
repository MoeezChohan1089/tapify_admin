import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../custom_widgets/custom_snackbar.dart';
import '../bottom_nav_bar/view.dart';
import 'api_services/auth_api_service.dart';
import 'state.dart';
// import 'package:shopify_flutter/shopify_flutter.dart';

class AuthLogic extends GetxController with GetSingleTickerProviderStateMixin {
  static AuthLogic get to => Get.find();
  final AuthState state = AuthState();
  late TabController tabController;
  GlobalKey<FormState> formKeyValue = GlobalKey<FormState>();
  RxBool obscureText = true.obs;
  RxBool obscureText1 = true.obs;
  RxBool obscureText2 = true.obs;
  RxBool isProcessing = false.obs;
  RxBool isCheckoutContinue = false.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  // ShopifyUser userGet = ShopifyUser();

  ///------ On Logging Success
  Function? onSuccessNavigator;
  onAuthSuccessUpdate(dynamic onSuccessNavigate) {
    onSuccessNavigator = onSuccessNavigate;
  }

  ///------ Sign In Form Controllers ------
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  final signInFormKey = GlobalKey<FormState>();

  signInUser({required BuildContext context}) async {
    // customLoader.showLoader(context);
    if (await signInUserApiService(
        email: emailTextController.text,
        password: passwordTextController.text)) {
      ///----- API Successful

      // customLoader.hideLoader();

      isProcessing.value = false;
      emailTextController.clear();
      passwordTextController.clear();
      if (onSuccessNavigator != null) {
        onSuccessNavigator!();
      } else {
        Get.off(() => BottomNavBarPage());
      }
    } else {
      isProcessing.value = false;
      showToastMessage(
          message: "Error in signing in, wrong email password entered");
      // Get.showSnackbar(
      //   const GetSnackBar(
      //     isDismissible: true,
      //     message: 'Error in signing in, wrong email password entered',
      //     duration: Duration(seconds: 2),
      //     backgroundColor: Colors.black,
      //   ),
      // );
      // customLoader.hideLoader();
    }
  }

  ///------ Sign Up Form Controllers -------
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  final signUpFormKey = GlobalKey<FormState>();

  createNewUser({required BuildContext context}) async {
    // customLoader.showLoader(context);
    if (await createCustomerApiService(
        // user: userGet,
        firstName: firstNameController.text,
        password: passController.text,
        email: emailController.text,
        lastName: lastNameController.text)) {
      ///----- API Successful
      await createClientService(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text);
      // customLoader.hideLoader();
      firstNameController.clear();
      passController.clear();
      lastNameController.clear();
      emailController.clear();
      confirmController.clear();
      isProcessing.value = false;
      if (onSuccessNavigator != null) {
        onSuccessNavigator!();
      } else {
        Get.off(() => BottomNavBarPage());
      }
    } else {
      isProcessing.value = false;

      showToastMessage(message: "Error in creating account.");
      // Get.showSnackbar(
      //   const GetSnackBar(
      //     isDismissible: true,
      //     message: 'Error in creating account.',
      //     duration: Duration(seconds: 2),
      //     backgroundColor: Colors.black,
      //   ),
      // );
      // customLoader.hideLoader();
    }
  }

  // Forgot Password-------
  TextEditingController emailForgotController = TextEditingController();
  GlobalKey<FormState> forgetPassFormKey = GlobalKey<FormState>();

  forgotUser({required BuildContext context}) async {
    // customLoader.showLoader(context);
    if (await forgotPasswordApiService(email: emailForgotController.text)) {
      isProcessing.value = false;
      showToastMessage(message: "Email sent for reset password.");
      emailForgotController.clear();
    } else {
      isProcessing.value = false;
      showToastMessage(message: "Your email is not registered.");
    }
  }

  clearTextControllers() {
    emailTextController.clear();
    passwordTextController.clear();

    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passController.clear();
    confirmController.clear();

    emailForgotController.clear();
  }

  bool containsSpecialCharacters(String value) {
    final specialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    return specialCharacters.hasMatch(value);
  }

  bool containsNumbers(String value) {
    final numbers = RegExp(r'[0-9]');
    return numbers.hasMatch(value);
  }

  bool containsOnlySpaces(String value) {
    return value.trim().isEmpty;
  }
}
