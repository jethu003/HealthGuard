import 'package:flutter/material.dart';
import 'package:healthguard/core/theme/appcolors.dart';

class CustomCheckbox extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomCheckbox({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: CheckboxListTile(
        activeColor: AppColors.primaryGreen,
        title: Text(title),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}