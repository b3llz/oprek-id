import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class HealthGauge extends StatelessWidget {
  final double percentage;
  final double size;

  const HealthGauge({
    Key? key,
    required this.percentage,
    this.size = 60.0,
  }) : super(key: key);

  Color _getStatusColor() {
    if (percentage > 40) return AppColors.statusHealthy;
    if (percentage > 15) return AppColors.statusWarning;
    return AppColors.statusCritical;
  }

  @override
  Widget build(BuildContext context) {
    final color = _getStatusColor();
    
    return SizedBox(
      width: size,
      height: size,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: percentage / 100),
        duration: const Duration(milliseconds: 1500),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: 1.0,
                strokeWidth: 6.0,
                color: AppColors.background,
              ),
              CircularProgressIndicator(
                value: value,
                strokeWidth: 6.0,
                backgroundColor: Colors.transparent,
                color: color,
                strokeCap: StrokeCap.round,
              ),
              Center(
                child: Text(
                  '${(value * 100).toInt()}%',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: size * 0.25,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}


