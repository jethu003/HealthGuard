import 'package:flutter/material.dart';
import 'package:healthguard/core/theme/appcolors.dart';

class CustomSectionTitle extends StatelessWidget {
  final String title;

  const CustomSectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryGreen,
        ),
      ),
    );
  }
}