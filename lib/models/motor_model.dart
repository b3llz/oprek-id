class MotorModel {
  final String id;
  final String brand; // Honda, Yamaha, Suzuki, dll
  final String name; // Beat, NMAX, Aerox, dll
  final String type; // Matic, Manual, Kopling
  final double cc; // Kapasitas mesin
  final String imagePath; // Path gambar dari assets nanti

  const MotorModel({
    required this.id,
    required this.brand,
    required this.name,
    required this.type,
    required this.cc,
    required this.imagePath,
  });
}


