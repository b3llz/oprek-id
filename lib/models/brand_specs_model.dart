class ComponentBrand {
  final String brandName;       // Contoh: "Motul", "Yamalube", "Bendix"
  final String productName;     // Contoh: "Scooter LE 10W-30", "Kampas Rem MD2"
  final String componentType;   // Kategori: "Oli Mesin", "Kampas Rem Depan", "V-Belt"
  final double baseLifeKm;      // Umur dasar dalam KM menurut klaim pabrik/pengalaman
  final int maxMonths;          // Batas umur waktu (0 jika tidak ada)
  final String materialType;    // Contoh: "Semi-Sintetik", "Ceramic"
  final String educationalNote; // Catatan mekanik untuk edukasi user

  const ComponentBrand({
    required this.brandName,
    required this.productName,
    required this.componentType,
    required this.baseLifeKm,
    this.maxMonths = 0,
    required this.materialType,
    required this.educationalNote,
  });
}


