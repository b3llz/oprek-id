import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/health_gauge.dart';
import '../../models/component_model.dart';
// TODO: Nanti import fitur harian di sini
// import '../daily_check/daily_check_screen.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Kita panggil mekanik utama (Provider)
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
                '${motor.brand} ${motor.name}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 12,
                  color: AppColors.electricTeal,
                ),
              ),
          ],
        ),
        actions: [
          // Tombol Cek Harian
          IconButton(
            icon: const Icon(Icons.add_road, color: AppColors.textMain),
            onPressed: () {
              // Nanti kita arahkan ke halaman input ODO & Cuaca
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fitur Cek Harian (Modul 5 lanjutan)')),
              );
            },
          )
        ],
      ),
      body: components.isEmpty
          ? Center(
              child: Text(
                'Belum ada motor yang dipilih.\nMasuk menu Setup (Modul berikutnya)',
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
        borderRadius: BorderRadius.circular(20), // Sesuai dengan AppTheme
        onTap: () {
          // Nanti buka halaman detail komponen (rekomendasi merek, dll)
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Gauge Kesehatan
              HealthGauge(
                percentage: comp.healthPercentage,
                size: 70.0,
              ),
              const SizedBox(width: 16.0),
              
              // Info Teks
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
                    // Pesan Status (Aman, Waspada, Kritis)
                    Text(
                      comp.statusMessage,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        // Warnanya ikut status juga biar jelas
                        color: comp.healthPercentage > 40 
                            ? AppColors.statusHealthy 
                            : (comp.healthPercentage > 15 ? AppColors.statusWarning : AppColors.statusCritical),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Ikon Panah Kanan
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


