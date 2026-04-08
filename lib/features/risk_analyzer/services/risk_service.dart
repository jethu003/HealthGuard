import 'package:healthguard/features/risk_analyzer/models/risk_input.dart';

class RiskService {
 RiskResult calculateScore({
  required bool hasScreenLock,
  required bool isThirdParty,
  required int appCount,
  required bool location,
  required bool camera,
  required bool storage,
  required bool osUpdated,
  required bool antivirus,
}) {

  int score = 0;



  /// Base Score
  if (!hasScreenLock) score += 4;

  if (isThirdParty) {
    score += 5;
  } else {
    score += 1;
  }

  if (appCount > 50) {
    score += 3;
  } else if (appCount >= 20) {
    score += 2;
  } else {
    score += 1;
  }

  if (location) score += 1;
  if (camera) score += 1;
  if (storage) score += 1;

  if (!osUpdated) score += 4;
  if (!antivirus) score += 3;




  /// Critical Override
  bool isHighRisk = false;

  if (!hasScreenLock && isThirdParty) {
    isHighRisk = true;
  }

  if (!osUpdated && !antivirus) {
    isHighRisk = true;
  }



  /// Adjustments
  if (appCount < 10) score -= 2;

  bool allSafe = hasScreenLock &&
      !isThirdParty &&
      osUpdated &&
      antivirus &&
      !location &&
      !camera &&
      !storage;

  if (allSafe) score -= 3;


  if (score < 0) score = 0;

  /// Risk Level
  String riskLevel;
  String status;

  if (isHighRisk) {
    riskLevel = "High Risk";
    status = "Critical security issues detected";
  } else if (score <= 5) {
    riskLevel = "Safe";
    status = "Your device is secure";
  } else if (score <= 12) {
    riskLevel = "Moderate";
    status = "Some risks detected";
  } else {
    riskLevel = "High Risk";
    status = "High security risk detected";
  }


  

  /// Suggestions
  List<String> suggestions = [];

  if (!hasScreenLock) suggestions.add("Enable screen lock");
  if (isThirdParty) suggestions.add("Avoid third-party apps");
  if (!osUpdated) suggestions.add("Update OS");
  if (!antivirus) suggestions.add("Install antivirus");
  if (location || camera || storage) {
    suggestions.add("Limit unnecessary permissions");
  }
  if (appCount > 50) suggestions.add("Reduce installed apps");

  return RiskResult(
    score: score,
    riskLevel: riskLevel,
    status: status,
    suggestions: suggestions,
  );
}
}