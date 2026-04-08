import 'package:flutter/material.dart';
import 'package:healthguard/core/theme/appcolors.dart';
import 'package:healthguard/core/widgets/risk_level_theme.dart';

class RiskCard extends StatelessWidget {
  final String riskLevel;
  final String status;

  const RiskCard({
    super.key,
    required this.riskLevel,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final color = RiskLevelTheme.colorOf(riskLevel);
    final icon = RiskLevelTheme.iconOf(riskLevel);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 56, color: color),
          const SizedBox(height: 12),
          Text(
            riskLevel,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            status,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}