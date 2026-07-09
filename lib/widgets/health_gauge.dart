import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class HealthGauge extends StatelessWidget {
  final double percentage;
  final double size;

  const HealthGauge({Key? key, required this.percentage, this.size = 60.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = AppColors.statusHealthy;
    if (percentage <= 40 && percentage > 15) color = AppColors.statusWarning;
    if (percentage <= 15) color = AppColors.statusCritical;

    return SizedBox(
      width: size, height: size,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: percentage / 100),
        duration: const Duration(milliseconds: 1500),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(value: 1.0, strokeWidth: 6.0, color: AppColors.background),
              CircularProgressIndicator(value: value, strokeWidth: 6.0, color: color, backgroundColor: Colors.transparent, strokeCap: StrokeCap.round),
              Center(child: Text('${(value * 100).toInt()}%', style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: size * 0.25, fontFamily: 'SpaceGrotesk'))),
            ],
          );
        },
      ),
    );
  }
}


