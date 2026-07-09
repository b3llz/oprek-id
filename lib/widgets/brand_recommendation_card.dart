import 'package:flutter/material.dart';
import '../models/brand_specs_model.dart';
import '../core/constants/app_colors.dart';

class BrandRecommendationCard extends StatelessWidget {
  final ComponentBrand brand;
  final VoidCallback onSelect;

  const BrandRecommendationCard({
    Key? key,
    required this.brand,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      // Beda warna dengan background utama supaya menonjol
      color: AppColors.background.withOpacity(0.5),
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
                  child: Text(
                    brand.brandName,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.electricTeal,
                    ),
                  ),
                ),
                // Tombol "Pakai Spek Ini"
                ElevatedButton(
                  onPressed: onSelect,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.racingRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Pilih', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Text(
              brand.productName,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8.0),
            // Chip Info: Jenis Material & Klaim Jarak
            Wrap(
              spacing: 8.0,
              children: [
                Chip(
                  label: Text(brand.materialType),
                  labelStyle: const TextStyle(fontSize: 10, color: AppColors.textMain),
                  backgroundColor: AppColors.surface,
                  visualDensity: VisualDensity.compact,
                ),
                Chip(
                  label: Text('${brand.baseLifeKm.toInt()} KM'),
                  labelStyle: const TextStyle(fontSize: 10, color: AppColors.textMain),
                  backgroundColor: AppColors.surface,
                  visualDensity: VisualDensity.compact,
                ),
                if (brand.maxMonths > 0)
                  Chip(
                    label: Text('${brand.maxMonths} Bln'),
                    labelStyle: const TextStyle(fontSize: 10, color: AppColors.textMain),
                    backgroundColor: AppColors.surface,
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
            const SizedBox(height: 12.0),
            // Catatan Mekanik
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.textSecondary.withOpacity(0.2)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline, size: 16, color: AppColors.textSecondary),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      brand.educationalNote,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



