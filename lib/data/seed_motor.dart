import '../models/motor_model.dart';

class SeedMotors {
  static const List<MotorModel> popularMotors = [
    MotorModel(
      id: "honda_beat_fi",
      brand: "Honda",
      name: "BeAT FI / eSP",
      type: "Matic",
      cc: 110.0,
      imagePath: "assets/images/motor_beat.png", // Nanti kita siapkan gambarnya
    ),
    MotorModel(
      id: "honda_vario_125",
      brand: "Honda",
      name: "Vario 125",
      type: "Matic",
      cc: 125.0,
      imagePath: "assets/images/motor_vario.png",
    ),
    MotorModel(
      id: "honda_vario_160",
      brand: "Honda",
      name: "Vario 160",
      type: "Matic",
      cc: 156.9,
      imagePath: "assets/images/motor_vario160.png",
    ),
    MotorModel(
      id: "yamaha_nmax",
      brand: "Yamaha",
      name: "NMAX 155",
      type: "Matic",
      cc: 155.0,
      imagePath: "assets/images/motor_nmax.png",
    ),
    MotorModel(
      id: "yamaha_aerox",
      brand: "Yamaha",
      name: "Aerox 155",
      type: "Matic",
      cc: 155.0,
      imagePath: "assets/images/motor_aerox.png",
    ),
    MotorModel(
      id: "honda_cb150r",
      brand: "Honda",
      name: "CB150R StreetFire",
      type: "Kopling",
      cc: 150.0,
      imagePath: "assets/images/motor_cb150.png",
    ),
     MotorModel(
      id: "yamaha_vixion",
      brand: "Yamaha",
      name: "V-Ixion",
      type: "Kopling",
      cc: 150.0,
      imagePath: "assets/images/motor_vixion.png",
    ),
  ];
}


