import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/health_gauge.dart';
import '../../models/component_model.dart';
import '../component/component_detail_screen.dart'; 
// IMPORT HALAMAN BARU
import '../daily_check/daily_check_screen.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final components = provider.activeComponents;
    final motor = provider.currentMotor;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Oprek.ID',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 22,
                color: AppColors.racingRed,
              ),
            ),
            if (motor != null)
              Text(
                '${motor.brand} ${motor.name} • ODO: ${provider.currentOdo.toInt()} KM',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 12,
                  color: AppColors.electricTeal,
                ),
              ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_road, color: AppColors.textMain),
            onPressed: () {
              // --- BUKA HALAMAN CEK HARIAN ---
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DailyCheckScreen(),
                ),
              );
            },
          )
        ],
      ),
      body: components.isEmpty
          ? Center(
              child: Text(
                'Belum ada motor yang dipilih.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: components.length,
              itemBuilder: (context, index) {
                final comp = components[index];
                return _buildComponentCard(context, comp);
              },
            ),
    );
  }

  Widget _buildComponentCard(BuildContext context, MotorComponent comp) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ComponentDetailScreen(component: comp),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Hero(
                tag: 'gauge_${comp.id}',
                child: HealthGauge(
                  percentage: comp.healthPercentage,
                  size: 70.0,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comp.name,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      comp.category,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      comp.statusMessage,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: comp.healthPercentage > 40 
                            ? AppColors.statusHealthy 
                            : (comp.healthPercentage > 15 ? AppColors.statusWarning : AppColors.statusCritical),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


