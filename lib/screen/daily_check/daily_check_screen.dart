import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/engine/physics_engine.dart';
import '../../providers/app_provider.dart';

class DailyCheckScreen extends StatefulWidget {
  const DailyCheckScreen({Key? key}) : super(key: key);
  @override
  State<DailyCheckScreen> createState() => _DailyCheckScreenState();
}

class _DailyCheckScreenState extends State<DailyCheckScreen> {
  final _odoController = TextEditingController();
  RidingStyle _style = RidingStyle.normal;
  TrafficCondition _traffic = TrafficCondition.lancar;
  WeatherCondition _weather = WeatherCondition.kering;
  LoadCondition _load = LoadCondition.normal;
  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Cek Harian Presisi')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            color: AppColors.surface,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Odometer Terakhir: ${provider.currentOdo.toInt()} KM', style: const TextStyle(color: AppColors.electricTeal, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _odoController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: AppColors.textMain),
            decoration: const InputDecoration(labelText: 'Angka Odometer Sekarang (KM)', focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.racingRed))),
          ),
          const SizedBox(height: 20),
          
          _buildDropdown<TrafficCondition>('Kemacetan', _traffic, [
            const DropdownMenuItem(value: TrafficCondition.lancar, child: Text('Lancar (Normal)')),
            const DropdownMenuItem(value: TrafficCondition.sedang, child: Text('Sedang (Stop & Go)')),
            const DropdownMenuItem(value: TrafficCondition.macet, child: Text('Macet Parah (Arrhenius Thermal Stress)')),
          ], (v) => setState(() => _traffic = v!)),

          _buildDropdown<WeatherCondition>('Cuaca & Kondisi Air', _weather, [
            const DropdownMenuItem(value: WeatherCondition.kering, child: Text('Kering')),
            const DropdownMenuItem(value: WeatherCondition.hujan, child: Text('Hujan Basah')),
            const DropdownMenuItem(value: WeatherCondition.banjir, child: Text('Banjir (Degradasi Komponen Bawah 1.8x)')),
          ], (v) => setState(() => _weather = v!)),

          _buildDropdown<RidingStyle>('Gaya Mengemudi', _style, [
            const DropdownMenuItem(value: RidingStyle.santai, child: Text('Santai (Low RPM)')),
            const DropdownMenuItem(value: RidingStyle.normal, child: Text('Normal')),
            const DropdownMenuItem(value: RidingStyle.agresif, child: Text('Agresif (High RPM Gas Pol)')),
          ], (v) => setState(() => _style = v!)),

          _buildDropdown<LoadCondition>('Beban Muatan', _load, [
            const DropdownMenuItem(value: LoadCondition.normal, child: Text('Sendiri')),
            const DropdownMenuItem(value: LoadCondition.boncenganBerat, child: Text('Boncengan / Muatan Berat')),
          ], (v) => setState(() => _load = v!)),

          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.racingRed, minimumSize: const Size(double.infinity, 50)),
            onPressed: () {
              final newOdo = double.tryParse(_odoController.text) ?? 0;
              final kmToday = newOdo - provider.currentOdo;
              if (kmToday <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Angka ODO baru wajib lebih besar!'), backgroundColor: AppColors.statusCritical));
                return;
              }
              provider.updateOdoOnly(newOdo);
              for (var comp in provider.activeComponents) {
                PhysicsEngine.applyDailyLog(component: comp, kmToday: kmToday, ridingStyle: _style, traffic: _traffic, weather: _weather, load: _load);
              }
              Navigator.pop(context);
            },
            child: const Text('Simpan & Hitung Degradasi Fisika', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget _buildDropdown<T>(String label, T value, List<DropdownMenuItem<T>> items, ValueChanged<T?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        DropdownButton<T>(value: value, items: items, onChanged: onChanged, isExpanded: true, dropdownColor: AppColors.surface, style: const TextStyle(color: AppColors.textMain)),
      ],
    );
  }
}


