import 'package:flutter/material.dart';
import '../models/brand_specs_model.dart';
import '../core/constants/app_colors.dart';

class BrandRecommendationCard extends StatelessWidget {
  final ComponentBrand brand;
  final VoidCallback onSelect;

  const BrandRecommendationCard({Key? key, required this.brand, required this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      margin: const EdgeInsets.only(bottom: 14.0),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.electricTeal, width: 0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(brand.brandName, style: const TextStyle(color: AppColors.electricTeal, fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.racingRed, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                  onPressed: onSelect,
                  child: const Text('Pilih', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Text(brand.productName, style: const TextStyle(color: AppColors.textMain, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: [
                Chip(label: Text(brand.materialType, style: const TextStyle(fontSize: 10)), backgroundColor: AppColors.background),
                Chip(label: Text('${brand.baseLifeKm.toInt()} KM', style: const TextStyle(fontSize: 10)), backgroundColor: AppColors.background),
              ],
            ),
            const SizedBox(height: 10),
            Text(brand.educationalNote, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }
}


