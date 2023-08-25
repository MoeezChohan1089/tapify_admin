import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/global_controllers/app_config/config_controller.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../utils/constants/colors.dart';
import 'components/editProfileForm.dart';
import 'components/profileImage.dart';
import 'logic.dart';

class Edit_profilePage extends StatelessWidget {
  Edit_profilePage({Key? key}) : super(key: key);

  final logic = Get.put(Edit_profileLogic());
  final state = Get.find<Edit_profileLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConfig.to.appbarBGColor.value,
          centerTitle: true,
          title: Text("my profile".toUpperCase(),
              style: context.text.bodyLarge
                  ?.copyWith(color: AppConfig.to.iconCollectionColor.value)),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppConfig.to.iconCollectionColor.value,
            ),
          ),
        ),
        backgroundColor: AppColors.customWhiteTextColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              EditProfileImageSection(),
              const EditProfileFormScreen()
            ],
          ),
        ),
      );
    });
  }
}
