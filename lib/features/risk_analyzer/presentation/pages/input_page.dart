import 'package:flutter/material.dart';
import 'package:healthguard/core/theme/appcolors.dart';
import 'package:healthguard/core/widgets/custom_checkbox.dart';
import 'package:healthguard/core/widgets/custom_section.dart';
import 'package:healthguard/core/widgets/custom_switch.dart';
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
        title: const Text(
          "HealthGuard",
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
              
              CustomSectionTitle(title: 'Screen Lock'),
              CustomSwitch(
                title: "Enabled",
                value: hasScreenLock,
                onChanged: (val) => setState(() => hasScreenLock = val),
              ),




              /// App Source
             CustomSectionTitle(title: 'App Install Source'),
              DropdownButtonFormField<String>(
                value: appSource,
                items:
                    ["Play Store", "Third-party"]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                onChanged: (val) => setState(() => appSource = val!),
                decoration: _inputDecoration(),
              ),




              // Number of Apps
              CustomSectionTitle(title: 'Number of Installed Apps'),
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



              ///  Permissions
              CustomSectionTitle(title: 'Permissions Granted'),

              CustomCheckbox(title: 'Location', value: location, onChanged: (val) => setState(() => location = val!
              )),
             CustomCheckbox(title: 'Camera', value: camera, onChanged: (val) => setState(() => camera = val!
              )),
              CustomCheckbox(title: 'Storage', value: storage, onChanged: (val) => setState(() => storage = val!
              )),

              /// OS Update
              CustomSectionTitle(title: 'OS updated'),
               CustomSwitch(
                title: "Up to date",
                value: osUpdated,
                onChanged: (val) => setState(() => osUpdated = val),
              ),

              ///  Antivirus
              CustomSectionTitle(title: 'Antivirus Installed'),
               CustomSwitch(
                title: "Installed",
                value: antivirus,
                onChanged: (val) => setState(() => antivirus = val),
              ),

              const SizedBox(height: 20),

              ///  Analyze Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {

                    //validation
                    if (appCountController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter number of apps"),
                        ),
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

                  
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => RiskResultScreen(
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
                    style: TextStyle(fontSize: 16, color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
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
