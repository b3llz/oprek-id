class MotorModel {
  final String id;
  final String brand;
  final String name;
  final String type; // Matic, Manual, Kopling
  final double cc;
  final String imagePath;

  const MotorModel({
    required this.id,
    required this.brand,
    required this.name,
    required this.type,
    required this.cc,
    required this.imagePath,
  });
}


