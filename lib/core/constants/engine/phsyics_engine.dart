import '../../models/component_model.dart';

enum RidingStyle { santai, normal, agresif }
enum TrafficCondition { lancar, sedang, macet }
enum WeatherCondition { kering, hujan, banjir }
enum LoadCondition { normal, boncenganBerat }

class PhysicsEngine {
  /// Menghitung KM Efektif dengan rumus fisika degradasi nyata
  static double calculateEffectiveKm({
    required double kmTraveled,
    required RidingStyle ridingStyle,
    required TrafficCondition traffic,
    required WeatherCondition weather,
    required LoadCondition load,
    required bool isExposedToWater,
  }) {
    // 1. Speed Factor
    double speedFactor = 1.0;
    if (ridingStyle == RidingStyle.santai) speedFactor = 0.9;
    if (ridingStyle == RidingStyle.agresif) speedFactor = 1.25;

    // 2. Traffic Factor (Pendekatan Arrhenius: mesin idle -> thermal stress naik)
    double trafficFactor = 1.0;
    if (traffic == TrafficCondition.sedang) trafficFactor = 1.2;
    if (traffic == TrafficCondition.macet) trafficFactor = 1.5;

    // 3. Water Factor (Hanya merusak komponen terbuka: rem, v-belt, rantai)
    double waterFactor = 1.0;
    if (isExposedToWater) {
      if (weather == WeatherCondition.hujan) waterFactor = 1.15;
      if (weather == WeatherCondition.banjir) waterFactor = 1.8;
    }

    // 4. Load Factor (Began berat memicu kerja CVT/kopling ekstra)
    double loadFactor = load == LoadCondition.boncenganBerat ? 1.15 : 1.0;

    return kmTraveled * speedFactor * trafficFactor * waterFactor * loadFactor;
  }

  static void applyDailyLog({
    required MotorComponent component,
    required double kmToday,
    required RidingStyle ridingStyle,
    required TrafficCondition traffic,
    required WeatherCondition weather,
    required LoadCondition load,
  }) {
    final effectiveKm = calculateEffectiveKm(
      kmTraveled: kmToday,
      ridingStyle: ridingStyle,
      traffic: traffic,
      weather: weather,
      load: load,
      isExposedToWater: component.isExposedToWater,
    );
    component.totalEffectiveKm += effectiveKm;
  }
}


