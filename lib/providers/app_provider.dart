import 'package:flutter/foundation.dart';
import '../models/motor_model.dart';
import '../models/component_model.dart';
import '../data/seed_components.dart';

class AppProvider with ChangeNotifier {
  MotorModel? _currentMotor;
  double _currentOdo = 0.0;
  List<MotorComponent> _activeComponents = [];

  MotorModel? get currentMotor => _currentMotor;
  double get currentOdo => _currentOdo;
  List<MotorComponent> get activeComponents => _activeComponents;

  void selectMotor(MotorModel motor, double startingOdo) {
    _currentMotor = motor;
    _currentOdo = startingOdo;
    
    // Mengaktifkan sistem monitor komponen berdasarkan tipe motor nyata
    _activeComponents = [
      MotorComponent(
        id: "oli_mesin_inti", name: "Oli Mesin", category: "Mesin",
        baseLifeKm: SeedComponents.engineOils[0].baseLifeKm,
        maxMonths: SeedComponents.engineOils[0].maxMonths,
      ),
      MotorComponent(
        id: "rem_depan_inti", name: "Kampas Rem Depan", category: "Kampas Rem Depan",
        baseLifeKm: SeedComponents.brakePads[0].baseLifeKm,
        isExposedToWater: true, // Fatal kalau kena air hujan/banjir
      ),
      if (motor.type == 'Matic')
        MotorComponent(
          id: "vbelt_cvt_inti", name: "V-Belt CVT", category: "V-Belt CVT",
          baseLifeKm: SeedComponents.vBelts[0].baseLifeKm,
          maxMonths: SeedComponents.vBelts[0].maxMonths,
          isExposedToWater: true, // Box CVT matic rentan kemasukan air kalau banjir
        ),
    ];
    notifyListeners();
  }

  void updateOdoOnly(double newOdo) {
    if (newOdo > _currentOdo) {
      _currentOdo = newOdo;
      notifyListeners();
    }
  }

  void replaceComponent(String componentId, double newBaseLife, int newMaxMonths) {
    final index = _activeComponents.indexWhere((c) => c.id == componentId);
    if (index != -1) {
      final old = _activeComponents[index];
      _activeComponents[index] = MotorComponent(
        id: old.id, name: old.name, category: old.category,
        baseLifeKm: newBaseLife, maxMonths: newMaxMonths,
        isExposedToWater: old.isExposedToWater,
        totalEffectiveKm: 0.0, // Reset total km efektif ke nol (onderdil baru gress!)
        lastChangedDate: DateTime.now(),
      );
      notifyListeners();
    }
  }
}


