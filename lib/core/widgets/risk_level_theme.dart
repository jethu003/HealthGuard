import 'package:flutter/material.dart';
import 'package:healthguard/core/theme/appcolors.dart';

class RiskLevelTheme {
  static Color colorOf(String level) {
    switch (level) {
      case "Safe":      return AppColors.safe;
      case "Moderate":  return AppColors.moderate;
      case "High Risk": return AppColors.highRisk;
      default:          return Colors.black;
    }
  }

  static IconData iconOf(String level) {
    switch (level) {
      case "Safe":      return Icons.shield;
      case "Moderate":  return Icons.warning_amber_rounded;
      case "High Risk": return Icons.dangerous_rounded;
      default:          return Icons.info_outline;
    }
  }
}