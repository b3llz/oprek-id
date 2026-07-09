import '../../models/component_model.dart';

enum RidingStyle { santai, normal, agresif }
enum TrafficCondition { lancar, sedang, macet }
enum WeatherCondition { kering, hujan, banjir }
enum LoadCondition { normal, boncenganBerat }

class PhysicsEngine {
  static double calculateEffectiveKm({
    required double kmTraveled,
    required RidingStyle ridingStyle,
    required TrafficCondition traffic,
    required WeatherCondition weather,
    required LoadCondition load,
    required bool isExposedToWater,
  }) {
    double speedFactor = ridingStyle == RidingStyle.santai ? 0.9 : (ridingStyle == RidingStyle.agresif ? 1.25 : 1.0);
    double trafficFactor = traffic == TrafficCondition.lancar ? 1.0 : (traffic == TrafficCondition.sedang ? 1.2 : 1.5);
    double waterFactor = (isExposedToWater && weather == WeatherCondition.hujan) ? 1.15 : ((isExposedToWater && weather == WeatherCondition.banjir) ? 1.8 : 1.0);
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
    component.totalEffectiveKm += calculateEffectiveKm(
      kmTraveled: kmToday, ridingStyle: ridingStyle, traffic: traffic, weather: weather, load: load, isExposedToWater: component.isExposedToWater,
    );
  }
}


