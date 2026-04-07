import 'package:flutter/material.dart';
import 'package:healthguard/core/theme/appcolors.dart';
import 'package:healthguard/features/risk_analyzer/presentation/pages/result_page.dart';
import 'package:healthguard/features/risk_analyzer/services/risk_service.dart';

class RiskInputScreen extends StatefulWidget {
  const RiskInputScreen({super.key});

  @override
  State<RiskInputScreen> createState() => _RiskInputScreenState();
}

class _RiskInputScreenState extends State<RiskInputScreen> {

  bool hasScreenLock = true;
  String appSource = "Play Store";
  int appCount = 0;

  bool location = false;
  bool camera = false;
  bool storage = false;

  bool osUpdated = true;
  bool antivirus = true;

  final TextEditingController appCountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HealthGuard",
        style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.primaryGreen,
      ),
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ///  Screen Lock
              _sectionTitle("Screen Lock"),
              SwitchListTile(
                value: hasScreenLock,
                onChanged: (val) => setState(() => hasScreenLock = val),
                activeColor: AppColors.primaryGreen,
                title: const Text("Enabled"),
              ),

              /// 📥 App Source
              _sectionTitle("App Install Source"),
              DropdownButtonFormField<String>(
                value: appSource,
                items: ["Play Store", "Third-party"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => appSource = val!),
                decoration: _inputDecoration(),
              ),

              /// 📱 Number of Apps
              _sectionTitle("Number of Installed Apps"),
              TextField(
                controller: appCountController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration().copyWith(
                  hintText: "Enter number of apps",
                ),
                onChanged: (val) {
                  appCount = int.tryParse(val) ?? 0;
                },
              ),

              /// 🔑 Permissions
              _sectionTitle("Permissions Granted"),
              CheckboxListTile(
                value: location,
                onChanged: (val) => setState(() => location = val!),
                title: const Text("Location"),
                activeColor: AppColors.primaryGreen,
              ),
              CheckboxListTile(
                value: camera,
                onChanged: (val) => setState(() => camera = val!),
                title: const Text("Camera"),
                activeColor: AppColors.primaryGreen,
              ),
              CheckboxListTile(
                value: storage,
                onChanged: (val) => setState(() => storage = val!),
                title: const Text("Storage"),
                activeColor: AppColors.primaryGreen,
              ),

              /// 🔄 OS Update
              _sectionTitle("OS Updated"),
              SwitchListTile(
                value: osUpdated,
                onChanged: (val) => setState(() => osUpdated = val),
                activeColor: AppColors.primaryGreen,
                title: const Text("Up to date"),
              ),

              /// 🛡️ Antivirus
              _sectionTitle("Antivirus Installed"),
              SwitchListTile(
                value: antivirus,
                onChanged: (val) => setState(() => antivirus = val),
                activeColor: AppColors.primaryGreen,
                title: const Text("Installed"),
              ),

              const SizedBox(height: 20),

              /// 🚀 Analyze Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {

  /// Validate input
  if (appCountController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please enter number of apps")),
    );
    return;
  }

  /// Parse value
  final count = int.tryParse(appCountController.text) ?? 0;

  /// Call service
  final result = RiskService().calculateScore(
    hasScreenLock: hasScreenLock,
    isThirdParty: appSource == "Third-party",
    appCount: count,
    location: location,
    camera: camera,
    storage: storage,
    osUpdated: osUpdated,
    antivirus: antivirus,
  );

  /// Navigate with real data
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => RiskResultScreen(
        score: result.score,
        riskLevel: result.riskLevel,
        status: result.status,
        suggestions: result.suggestions,
      ),
    ),
  );
},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Analyze Risk",
                    style: TextStyle(fontSize: 16,
                    color: AppColors.white
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🧩 Helpers

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryGreen,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}