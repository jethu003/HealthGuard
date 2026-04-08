import 'package:flutter/material.dart';
import 'package:healthguard/core/theme/appcolors.dart';
import 'package:healthguard/core/widgets/custom_appbar.dart';
import 'package:healthguard/core/widgets/risk_card.dart';
import 'package:healthguard/core/widgets/suggestion_tile.dart';

// Result screen that displays the analyzed risk level, status and suggested actions
// Output: Risk Level, Security Status, Suggested Actions
class RiskResultScreen extends StatelessWidget {
  final String riskLevel;
  final String status;
  final List<String> suggestions;

  const RiskResultScreen({
    super.key,
    required this.riskLevel,
    required this.status,
    required this.suggestions,
  });

  @override
  Widget build(BuildContext context) {

    
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.04;

    return Scaffold(
      appBar: CustomAppBar.build(title: "Risk Result"),
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: SingleChildScrollView(
          // ClampingScrollPhysics for consistent scroll on Android and iOS
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Risk Card: shows risk level icon, label and security status
              RiskCard(riskLevel: riskLevel, status: status),

              const SizedBox(height: 24),

              // Suggested Actions: shown only when there are suggestions
              // If no suggestions, device is considered fully safe
              if (suggestions.isNotEmpty) ...[
                Text(
                  "Suggested Actions",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryGreen,
                  ),
                ),
                const SizedBox(height: 12),
                
                ...suggestions.map((s) => SuggestionTile(text: s)),
              ] else
                // Empty state: no suggestions means device is safe
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Text(
                      "No actions needed. Your device is safe ✅",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.primaryGreen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 24),

              // Analyze Again button: pops back to input screen
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Analyze Again",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}