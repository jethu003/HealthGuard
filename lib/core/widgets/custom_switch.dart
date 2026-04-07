import 'package:flutter/material.dart';
import 'package:healthguard/core/theme/appcolors.dart';

class CustomSwitchTile extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool) onChanged;

  const CustomSwitchTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.primaryGreen,
      title: Text(title),
    );
  }
}