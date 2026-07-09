import '../models/brand_specs_model.dart';

class SeedComponents {
  // DATABASE OLI MESIN
  // Faktor pengali oli biasanya: Mineral (1.0), Semi-Sintetik (1.4), Full-Sintetik (2.3)
  // Tapi kita langsung masukkan baseLifeKm-nya agar lebih mudah dibaca user.
  static const List<ComponentBrand> engineOils = [
    ComponentBrand(
      brandName: "AHM Oil (Honda)",
      productName: "MPX-2 10W-30 (Mineral)",
      componentType: "Oli Mesin",
      baseLifeKm: 2000.0,
      maxMonths: 2, // 2 bulan karena mineral cepat oksidasi
      materialType: "Mineral",
      educationalNote: "Oli standar pabrik. Cocok untuk pemakaian harian santai. Cepat menguap jika sering kena macet.",
    ),
    ComponentBrand(
      brandName: "Yamalube",
      productName: "Super Sport 10W-40",
      componentType: "Oli Mesin",
      baseLifeKm: 3000.0, // Semi-sintetik bisa lebih tahan
      maxMonths: 3,
      materialType: "Semi-Sintetik",
      educationalNote: "Lebih tahan panas dari mineral. Tarikan mesin lebih responsif.",
    ),
    ComponentBrand(
      brandName: "Motul",
      productName: "Scooter Power LE 5W-40",
      componentType: "Oli Mesin",
      baseLifeKm: 4500.0, // Full-sintetik sangat awet
      maxMonths: 6,
      materialType: "Full-Sintetik (100% Ester)",
      educationalNote: "Perlindungan maksimal anti gesekan. Suhu mesin jauh lebih adem di kemacetan. Harga premium.",
    ),
  ];

  // DATABASE KAMPAS REM (Brake Pads)
  static const List<ComponentBrand> brakePads = [
    ComponentBrand(
      brandName: "OEM (Honda/Yamaha/Suzuki)",
      productName: "Kampas Rem Standar",
      componentType: "Kampas Rem",
      baseLifeKm: 12000.0, 
      maxMonths: 0, // Rem tidak basi karena waktu
      materialType: "Organik / Non-Asbestos",
      educationalNote: "Pengereman halus, piringan cakram (disc) awet. Tapi cepat habis kalau sering ngerem mendadak.",
    ),
    ComponentBrand(
      brandName: "Bendix",
      productName: "Bendix MD",
      componentType: "Kampas Rem",
      baseLifeKm: 18000.0,
      maxMonths: 0,
      materialType: "Ceramic Technology",
      educationalNote: "Pakem di suhu panas, umur panjang. Minus: agak berisik saat basah dan sedikit memakan piringan.",
    ),
  ];

  // DATABASE V-BELT (CVT)
  static const List<ComponentBrand> vBelts = [
    ComponentBrand(
      brandName: "OEM Pabrik",
      productName: "V-Belt Standar",
      componentType: "V-Belt",
      baseLifeKm: 24000.0, // Rata-rata klaim pabrikan Jepang
      maxMonths: 24, // Karet bisa getas (retak rambut) karena umur kalender
      materialType: "Rubber Standard",
      educationalNote: "Spek aman pabrikan. Wajib cek fisik (retak) di kilometer 15.000, apalagi kalau sering boncengan.",
    ),
    ComponentBrand(
      brandName: "TDR Racing",
      productName: "TDR CVT Belt",
      componentType: "V-Belt",
      baseLifeKm: 20000.0, // Racing belt kadang difokuskan ke grip, bukan umur panjang ekstrim
      maxMonths: 24,
      materialType: "Kevlar Reinforced",
      educationalNote: "Diperkuat Kevlar, anti selip saat akselerasi spontan. Cocok untuk motor oprekan kirian.",
    ),
  ];

  // Kumpulkan semua untuk dipakai di fitur "Pilih Merek" nanti
  static List<ComponentBrand> getAllBrands() {
    return [...engineOils, ...brakePads, ...vBelts];
  }
}


