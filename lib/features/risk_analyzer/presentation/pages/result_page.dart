import 'package:flutter/material.dart';
import 'package:healthguard/core/theme/appcolors.dart';

class RiskResultScreen extends StatelessWidget {
  final int score;
  final String riskLevel;
  final String status;
  final List<String> suggestions;

  const RiskResultScreen({
    super.key,
    required this.score,
    required this.riskLevel,
    required this.status,
    required this.suggestions,
  });

  @override
  Widget build(BuildContext context) {

    Color riskColor = _getRiskColor(riskLevel);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Risk Result"),
        backgroundColor: AppColors.primaryGreen,
      ),
      backgroundColor: AppColors.cream,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// 🧾 Risk Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "Risk Level",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      riskLevel,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: riskColor,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Score: $score",
                      style: const TextStyle(fontSize: 16),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      status,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// 💡 Suggestions
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Suggested Actions",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryGreen,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.check_circle_outline),
                      title: Text(suggestions[index]),
                    ),
                  );
                },
              ),
            ),

            /// 🔙 Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("Back"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Risk Color
  Color _getRiskColor(String level) {
    switch (level) {
      case "Safe":
        return Colors.green;
      case "Moderate":
        return Colors.orange;
      case "High Risk":
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}