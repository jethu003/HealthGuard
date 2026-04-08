class RiskResult {
  final int score;
  final String riskLevel;
  final String status;
  final List<String> suggestions;

  RiskResult({
    required this.score,
     required this.riskLevel,
    required this.status,
    required this.suggestions,
  });
}