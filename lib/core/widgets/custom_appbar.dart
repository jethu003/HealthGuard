import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/appcolors.dart';

class CustomAppBar {
  static AppBar build({
    required String title,
  }) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: const TextStyle(color: AppColors.white),
      ),
      backgroundColor: AppColors.primaryGreen,
      elevation: 0,
      //  Fixes status bar on all phones
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryGreen,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }
}