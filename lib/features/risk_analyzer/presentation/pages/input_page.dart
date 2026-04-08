import 'package:flutter/material.dart';
import 'package:healthguard/core/theme/appcolors.dart';
import 'package:healthguard/core/widgets/custom_appbar.dart';
import 'package:healthguard/core/widgets/custom_checkbox.dart';
import 'package:healthguard/core/widgets/custom_input_decoration.dart';
import 'package:healthguard/core/widgets/custom_section.dart';
import 'package:healthguard/core/widgets/custom_switch.dart';
import 'package:healthguard/features/risk_analyzer/presentation/pages/result_page.dart';
import 'package:healthguard/features/risk_analyzer/services/risk_service.dart';

// Input screen where user enters device security details
// Features: Screen Lock, App Source, App Count, Permissions, OS Update, Antivirus
class RiskInputScreen extends StatefulWidget {
  const RiskInputScreen({super.key});

  @override
  State<RiskInputScreen> createState() => _RiskInputScreenState();
}

class _RiskInputScreenState extends State<RiskInputScreen> {

  // Input state variables
  bool hasScreenLock = true;
  String appSource = "Play Store";
  bool location = false;
  bool camera = false;
  bool storage = false;
  bool osUpdated = true;
  bool antivirus = true;

  // Controller for number of installed apps input
  final TextEditingController _appCountController = TextEditingController();

  // Dispose controller to avoid memory leak
  @override
  void dispose() {
    _appCountController.dispose();
    super.dispose();
  }

  // Validates input, calculates risk score and navigates to result screen
  Future<void> _analyzeRisk() async {

    // Dismiss keyboard before processing
    FocusScope.of(context).unfocus();

    final text = _appCountController.text.trim();

    // Validation: empty check
    if (text.isEmpty) {
      _showSnackBar("Please enter the number of installed apps");
      return;
    }

    // Validation: range check (0 to 500)
    final count = int.tryParse(text);
    if (count == null || count < 0 || count > 500) {
      _showSnackBar("Enter a valid app count between 0 and 500");
      return;
    }

    // Calculate risk score using RiskService
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

    // Navigate to result screen with calculated result
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RiskResultScreen(
          riskLevel: result.riskLevel,
          status: result.status,
          suggestions: result.suggestions,
        ),
      ),
    );

    // Clear app count field when returning from result screen
    _appCountController.clear();
  }

  // Shows a floating snackbar with warning color
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.warning,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.04;

    return GestureDetector(
      // Tapping outside any field dismisses the keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBar.build(title: "HealthGuard"),
        backgroundColor: AppColors.cream,
        // Pushes content up when keyboard appears
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Feature 1: Screen Lock (Yes/No toggle)
                const CustomSectionTitle(title: 'Screen Lock'),
                CustomSwitch(
                  title: "Enabled",
                  value: hasScreenLock,
                  onChanged: (val) => setState(() => hasScreenLock = val),
                ),

                const Divider(height: 28),

                // Feature 2: App Install Source (Play Store / Third-party)
                const CustomSectionTitle(title: 'App Install Source'),
                DropdownButtonFormField<String>(
                  value: appSource,
                  isExpanded: true,
                  items: ["Play Store", "Third-party"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) => setState(() => appSource = val!),
                  decoration: AppInputDecoration.defaultDecoration(),
                ),

                const Divider(height: 28),

                // Feature 3: Number of Installed Apps (numeric input)
                const CustomSectionTitle(title: 'Number of Installed Apps'),
                TextField(
                  controller: _appCountController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  // Dismiss keyboard on done press
                  onSubmitted: (_) => FocusScope.of(context).unfocus(),
                  decoration: AppInputDecoration.defaultDecoration(
                    hintText: "Enter number of apps",
                  ),
                ),

                const Divider(height: 28),

                // Feature 4: Permissions Granted (Location, Camera, Storage)
                const CustomSectionTitle(title: 'Permissions Granted'),
                CustomCheckbox(
                  title: 'Location',
                  value: location,
                  onChanged: (val) => setState(() => location = val!),
                ),
                CustomCheckbox(
                  title: 'Camera',
                  value: camera,
                  onChanged: (val) => setState(() => camera = val!),
                ),
                CustomCheckbox(
                  title: 'Storage',
                  value: storage,
                  onChanged: (val) => setState(() => storage = val!),
                ),

                const Divider(height: 28),

                // Feature 5: OS Version Updated (Yes/No toggle)
                const CustomSectionTitle(title: 'OS Updated'),
                CustomSwitch(
                  title: "Up to date",
                  value: osUpdated,
                  onChanged: (val) => setState(() => osUpdated = val),
                ),

                const Divider(height: 28),

                // Feature 6: Antivirus Installed (Yes/No toggle)
                const CustomSectionTitle(title: 'Antivirus Installed'),
                CustomSwitch(
                  title: "Installed",
                  value: antivirus,
                  onChanged: (val) => setState(() => antivirus = val),
                ),

                const SizedBox(height: 24),

                // Analyze button: triggers validation and risk calculation
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _analyzeRisk,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Analyze Risk",
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
      ),
    );
  }
}