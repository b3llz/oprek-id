class ComponentBrand {
  final String brandName;
  final String productName;
  final String componentType;
  final double baseLifeKm;
  final int maxMonths;
  final String materialType;
  final String educationalNote;

  const ComponentBrand({
    required this.brandName, required this.productName, required this.componentType,
    required this.baseLifeKm, this.maxMonths = 0, required this.materialType,
    required this.educationalNote,
  });
}


