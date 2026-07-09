import 'package:flutter/foundation.dart';
import '../models/motor_model.dart';
import '../models/component_model.dart';
import '../data/seed_components.dart';

class AppProvider with ChangeNotifier {
  MotorModel? _currentMotor;
  double _currentOdo = 0.0;
  List<MotorComponent> _activeComponents = [];

  // Getter
  MotorModel? get currentMotor => _currentMotor;
  double get currentOdo => _currentOdo;
  List<MotorComponent> get activeComponents => _activeComponents;

  // --- AKSI PENGGUNA ---

  /// Set motor baru dan inisialisasi komponen defaultnya
  void selectMotor(MotorModel motor, double startingOdo) {
    _currentMotor = motor;
    _currentOdo = startingOdo;
    
    // Inisialisasi komponen standar (Kita pakai contoh Oli & Kampas Rem dulu)
    // Nanti bisa diextend jadi 11 sistem.
    _activeComponents = [
      MotorComponent(
        id: "oli_mesin_1",
        name: "Oli Mesin",
        category: "Mesin",
        // Ambil base life dari AHM MPX-2 sebagai standar awal
        baseLifeKm: SeedComponents.engineOils[0].baseLifeKm,
        maxMonths: SeedComponents.engineOils[0].maxMonths,
      ),
      MotorComponent(
        id: "kampas_rem_depan",
        name: "Kampas Rem Depan",
        category: "Pengereman",
        // Ambil base life dari OEM standar
        baseLifeKm: SeedComponents.brakePads[0].baseLifeKm,
        isExposedToWater: true, // Kampas rem kena cipratan air/banjir
      ),
      // Tambahkan V-Belt khusus jika motornya Matic
      if (motor.type == 'Matic')
        MotorComponent(
          id: "vbelt_1",
          name: "V-Belt CVT",
          category: "Transmisi",
          baseLifeKm: SeedComponents.vBelts[0].baseLifeKm,
          maxMonths: SeedComponents.vBelts[0].maxMonths,
        ),
    ];
    
    notifyListeners(); // Beritahu UI untuk update
  }

  /// Update ODO tanpa mengubah umur komponen (misal cuma kalibrasi)
  void updateOdoOnly(double newOdo) {
    if (newOdo > _currentOdo) {
      _currentOdo = newOdo;
      notifyListeners();
    }
  }

  /// Fungsi Ganti Komponen (User baru saja ganti oli / sparepart)
  void replaceComponent(String componentId, double newBaseLife, int newMaxMonths) {
    final index = _activeComponents.indexWhere((c) => c.id == componentId);
    if (index != -1) {
      // Kita buat ulang komponennya dengan spek baru dan nol-kan KM efektifnya
      final old = _activeComponents[index];
      _activeComponents[index] = MotorComponent(
        id: old.id,
        name: old.name,
        category: old.category,
        baseLifeKm: newBaseLife, // Spek dari merek baru
        maxMonths: newMaxMonths, // Spek dari merek baru
        isExposedToWater: old.isExposedToWater,
        totalEffectiveKm: 0.0, // Mulai dari nol lagi!
        lastChangedDate: DateTime.now(),
      );
      notifyListeners();
    }
  }
}


