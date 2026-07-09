import '../models/brand_specs_model.dart';

class SeedComponents {
  static const List<ComponentBrand> engineOils = [
    ComponentBrand(
      brandName: "AHM Oil (Honda)", productName: "MPX-2 10W-30", componentType: "Oli Mesin",
      baseLifeKm: 2000.0, maxMonths: 2, materialType: "Mineral",
      educationalNote: "Oli standar pabrikan. Murah, cocok untuk harian santai. Cepat menguap jika sering macet parah.",
    ),
    ComponentBrand(
      brandName: "Yamalube", productName: "Super Sport 10W-40", componentType: "Oli Mesin",
      baseLifeKm: 3000.0, maxMonths: 3, materialType: "Semi-Sintetik",
      educationalNote: "Proteksi thermal lebih baik dari mineral. Cocok untuk mesin yang sering stop & go.",
    ),
    ComponentBrand(
      brandName: "Motul", productName: "Scooter Power LE 5W-40", componentType: "Oli Mesin",
      baseLifeKm: 4500.0, maxMonths: 6, materialType: "Full-Sintetik Ester",
      educationalNote: "Kasta tertinggi pelumasan. Sangat minim penguapan di suhu ekstrem macet total. Tarikan enteng.",
    ),
  ];

  static const List<ComponentBrand> brakePads = [
    ComponentBrand(
      brandName: "OEM Pabrikan Jepang", productName: "Kampas Rem Cakram Standar", componentType: "Kampas Rem Depan",
      baseLifeKm: 12000.0, materialType: "Non-Asbestos Organik",
      educationalNote: "Pengereman halus dan piringan cakram awet. Pakem di kondisi harian kering.",
    ),
    ComponentBrand(
      brandName: "Bendix", productName: "Bendix MD Series", componentType: "Kampas Rem Depan",
      baseLifeKm: 18000.0, materialType: "Ceramic Technology",
      educationalNote: "Sangat pakem di suhu tinggi, material keramik awet meski sering bermanuver agresif.",
    ),
  ];

  static const List<ComponentBrand> vBelts = [
    ComponentBrand(
      brandName: "OEM Honda/Yamaha", productName: "V-Belt CVT Standar", componentType: "V-Belt CVT",
      baseLifeKm: 24000.0, maxMonths: 24, materialType: "Standard Rubber",
      educationalNote: "Sesuai standar pabrik. Wajib cek keretakan fisik di 15.000 KM jika sering bawa beban berat.",
    ),
  ];

  static List<ComponentBrand> getAllBrands() {
    return [...engineOils, ...brakePads, ...vBelts];
  }
}


