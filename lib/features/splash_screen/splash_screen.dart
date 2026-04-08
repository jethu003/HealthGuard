import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthguard/core/theme/appcolors.dart';
import 'package:healthguard/features/risk_analyzer/presentation/pages/input_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
   
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _navigate();
  }

  @override
  void dispose() {
    
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2)); 
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const RiskInputScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.lightGreen,
              AppColors.primaryGreen,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Icon(
              Icons.shield,
              size: screenHeight * 0.09,
              color: AppColors.white,
            ),

            SizedBox(height: screenHeight * 0.02),

            const Text(
              "HealthGuard",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                letterSpacing: 1.5,
              ),
            ),

            SizedBox(height: screenHeight * 0.01),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                "Device Health & Security Risk Analyzer",
                textAlign: TextAlign.center, 
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}