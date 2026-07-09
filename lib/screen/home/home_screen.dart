import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/health_gauge.dart';
import '../component/component_detail_screen.dart'; 
import '../daily_check/daily_check_screen.dart'; 
import '../ai_chat/ai_chat_screen.dart';

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
            const Text('Oprek.ID', style: TextStyle(color: AppColors.racingRed, fontWeight: FontWeight.bold, fontSize: 22)),
            if (motor != null)
              Text('${motor.brand} ${motor.name} • ${provider.currentOdo.toInt()} KM', style: const TextStyle(color: AppColors.electricTeal, fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_road, color: AppColors.textMain),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DailyCheckScreen())),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: components.length,
        itemBuilder: (context, index) {
          final comp = components[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ComponentDetailScreen(component: comp))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    HealthGauge(percentage: comp.healthPercentage, size: 65),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(comp.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.textMain)),
                          const SizedBox(height: 4),
                          Text(comp.statusMessage, style: TextStyle(fontSize: 13, color: comp.healthPercentage > 40 ? AppColors.statusHealthy : (comp.healthPercentage > 15 ? AppColors.statusWarning : AppColors.statusCritical))),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: AppColors.textSecondary),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.electricTeal,
        child: const Icon(Icons.smart_toy, color: AppColors.background),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AiChatScreen())),
      ),
    );
  
}


