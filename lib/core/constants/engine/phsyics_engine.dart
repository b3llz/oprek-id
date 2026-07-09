import '../../models/component_model.dart';

enum RidingStyle { santai, normal, agresif }
enum TrafficCondition { lancar, sedang, macet }
enum WeatherCondition { kering, hujan, banjir }
enum LoadCondition { normal, boncenganBerat }

class PhysicsEngine {
  /// Menghitung KM Efektif (Degradasi nyata) untuk satu perjalanan
  /// ODO = Odometer (Jarak tempuh nyata di speedometer)
  static double calculateEffectiveKm({
    required double kmTraveled,
    required RidingStyle ridingStyle,
    required TrafficCondition traffic,
    required WeatherCondition weather,
    required LoadCondition load,
    required bool isExposedToWater,
  }) {
    // 1. Speed Factor (Gaya Berkendara)
    // Agresif = RPM tinggi terus, gesekan naik.
    double speedFactor = 1.0;
    switch (ridingStyle) {
      case RidingStyle.santai: speedFactor = 0.9; break; // <= 40 km/h
      case RidingStyle.normal: speedFactor = 1.0; break; // 40 - 70 km/h
      case RidingStyle.agresif: speedFactor = 1.25; break; // > 70 km/h
    }

    // 2. Traffic Factor (Kemacetan)
    // Macet = Mesin nyala, ODO tidak nambah (idle lama). Panas naik, pendinginan (angin) kurang.
    // Pendekatan Arrhenius sederhana: Panas memicu oksidasi cairan & keausan logam lebih cepat.
    double trafficFactor = 1.0;
    switch (traffic) {
      case TrafficCondition.lancar: trafficFactor = 1.0; break;
      case TrafficCondition.sedang: trafficFactor = 1.2; break;
      case TrafficCondition.macet: trafficFactor = 1.5; break;
    }

    // 3. Water Factor (Cuaca & Air)
    // Hanya berlaku untuk komponen terbuka (rem, rantai/v-belt, bearing)
    double waterFactor = 1.0;
    if (isExposedToWater) {
      switch (weather) {
        case WeatherCondition.kering: waterFactor = 1.0; break;
        case WeatherCondition.hujan: waterFactor = 1.15; break;
        case WeatherCondition.banjir: waterFactor = 1.8; break; // Air kotor masuk ke bearing/CVT
      }
    }

    // 4. Load Factor (Beban)
    // Boncengan berat = beban suspensi, rem, dan torsi CVT/rantai naik drastis.
    double loadFactor = 1.0;
    switch (load) {
      case LoadCondition.normal: loadFactor = 1.0; break;
      case LoadCondition.boncenganBerat: loadFactor = 1.15; break;
    }

    // RUMUS FINAL DEGRADASI
    return kmTraveled * speedFactor * trafficFactor * waterFactor * loadFactor;
  }

  /// Update komponen dengan data perjalanan hari ini (Cek Harian)
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

    // Tambahkan KM efektif ke total komponen
    component.totalEffectiveKm += effectiveKm;
  }
}


