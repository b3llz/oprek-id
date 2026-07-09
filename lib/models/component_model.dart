
class MotorComponent {
  final String id;
  final String name;
  final String category;
  final double baseLifeKm;
  final int maxMonths;
  final bool isExposedToWater;
  
  double totalEffectiveKm;
  DateTime lastChangedDate;

  MotorComponent({
    required this.id, required this.name, required this.category,
    required this.baseLifeKm, this.maxMonths = 0, this.isExposedToWater = false,
    this.totalEffectiveKm = 0.0, DateTime? lastChangedDate,
  }) : lastChangedDate = lastChangedDate ?? DateTime.now();

  double get healthPercentage {
    double kmHealth = 100 * (1 - (totalEffectiveKm / baseLifeKm));
    double timeHealth = 100.0;
    if (maxMonths > 0) {
      final monthsUsed = DateTime.now().difference(lastChangedDate).inDays / 30;
      timeHealth = 100 * (1 - (monthsUsed / maxMonths));
    }
    double finalHealth = kmHealth < timeHealth ? kmHealth : timeHealth;
    return finalHealth.clamp(0.0, 100.0);
  }

  String get statusMessage {
    final health = healthPercentage;
    if (health > 40) return "Aman";
    if (health > 15) return "Waspada, Siapkan Dana";
    return "Kritis! Segera Ganti!";
  }
}


