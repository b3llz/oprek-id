
import 'package:flutter/foundation.dart';

// Kita pakai class biasa dulu, nanti di Modul 4 kita ubah jadi Hive object
// supaya bisa disimpan offline tanpa internet.
class MotorComponent {
  final String id;
  final String name; // Contoh: "Oli Mesin", "V-Belt", "Kampas Rem"
  final String category; // Cairan, Mesin, CVT, Kaki-kaki, dll
  final double baseLifeKm; // Umur maksimal berdasar spek pabrik/merek (contoh: 2000 km)
  final int maxMonths; // Batas umur waktu (khusus cairan seperti oli/minyak rem)
  final bool isExposedToWater; // Apakah komponen ini kena air kalau hujan/banjir?
  
  double totalEffectiveKm; // Total akumulasi KM degradasi
  DateTime lastChangedDate; // Tanggal terakhir diganti

  MotorComponent({
    required this.id,
    required this.name,
    required this.category,
    required this.baseLifeKm,
    this.maxMonths = 0, // 0 berarti tidak terpengaruh waktu kalender (contoh: spion)
    this.isExposedToWater = false,
    this.totalEffectiveKm = 0.0,
    DateTime? lastChangedDate,
  }) : lastChangedDate = lastChangedDate ?? DateTime.now();

  // Menghitung sisa umur dalam persen (0 - 100%)
  double get healthPercentage {
    // 1. Cek degradasi berdasarkan jarak tempuh efektif
    double kmHealth = 100 * (1 - (totalEffectiveKm / baseLifeKm));
    
    // 2. Cek degradasi kalender (waktu) khusus cairan (Oksidasi/Higroskopis)
    double timeHealth = 100.0;
    if (maxMonths > 0) {
      final monthsUsed = DateTime.now().difference(lastChangedDate).inDays / 30;
      timeHealth = 100 * (1 - (monthsUsed / maxMonths));
    }

    // Ambil nilai terburuk antara jarak tempuh atau waktu
    double finalHealth = kmHealth < timeHealth ? kmHealth : timeHealth;
    
    // Pastikan nilai tidak kurang dari 0 atau lebih dari 100
    return finalHealth.clamp(0.0, 100.0);
  }

  // Cek status untuk UI
  String get statusMessage {
    final health = healthPercentage;
    if (health > 40) return "Aman";
    if (health > 15) return "Waspada, Siapkan Dana";
    return "Kritis! Segera Ganti!";
  }
}

