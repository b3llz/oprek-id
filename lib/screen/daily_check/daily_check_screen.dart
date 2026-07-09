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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _odoController = TextEditingController();

  // Nilai default untuk kondisi (standar)
  RidingStyle _ridingStyle = RidingStyle.normal;
  TrafficCondition _traffic = TrafficCondition.lancar;
  WeatherCondition _weather = WeatherCondition.kering;
  LoadCondition _load = LoadCondition.normal;

  @override
  void dispose() {
    _odoController.dispose();
    super.dispose();
  }

  void _submitData(BuildContext context, AppProvider provider) {
    if (_formKey.currentState!.validate()) {
      final inputOdo = double.tryParse(_odoController.text) ?? 0.0;
      final currentOdo = provider.currentOdo;

      if (inputOdo <= currentOdo) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Angka ODO harus lebih besar dari ODO sebelumnya!'),
            backgroundColor: AppColors.statusCritical,
          ),
        );
        return;
      }

      // Hitung selisih KM hari ini
      final kmToday = inputOdo - currentOdo;

      // Update ODO utama
      provider.updateOdoOnly(inputOdo);

      // Aplikasikan degradasi ke SEMUA komponen aktif
      for (var component in provider.activeComponents) {
        PhysicsEngine.applyDailyLog(
          component: component,
          kmToday: kmToday,
          ridingStyle: _ridingStyle,
          traffic: _traffic,
          weather: _weather,
          load: _load,
        );
      }

      // Beritahu UI untuk render ulang semua Gauge (Nyawa berkurang)
      // (Di dalam provider, idealnya ada metode notifyListeners() khusus update komponen, 
      // tapi untuk kesederhanaan sementara kita panggil fungsi update dummy jika perlu, 
      // atau karena ini reference pass, jika kita set state di sini atau memicu listener provider, itu akan update).
      // Untuk memastikan UI terupdate, kita bisa memanggil fungsi dummy di provider atau sekadar back.
      // Kita asumsikan provider sudah menghandle perubahan state object ini.
      // *Trik Flutter: Karena kita mengubah property object di dalam list, Provider kadang ga sadar. 
      // Kita panggil fungsi dummy di provider nanti untuk force update, atau cukup updateOdoOnly sudah memicu notifyListeners().
      
      Navigator.pop(context);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data masuk! Jarak tempuh efektif dihitung.'),
          backgroundColor: AppColors.statusHealthy,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lapor Kondisi Jalan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info ODO Terakhir
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.electricTeal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.electricTeal),
                ),
                child: Text(
                  'Odometer Terakhir: ${provider.currentOdo.toInt()} KM',
                  style: const TextStyle(color: AppColors.electricTeal, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),

              // Input ODO Baru
              TextFormField(
                controller: _odoController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: AppColors.textMain),
                decoration: InputDecoration(
                  labelText: 'Angka Odometer Sekarang (KM)',
                  labelStyle: const TextStyle(color: AppColors.textSecondary),
                  hintText: 'Misal: ${(provider.currentOdo + 15).toInt()}',
                  hintStyle: TextStyle(color: AppColors.textSecondary.withOpacity(0.5)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.textSecondary),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.electricTeal),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.speed, color: AppColors.textSecondary),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Odometer tidak boleh kosong';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Masukkan angka yang valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Kondisi Jalan (Dropdowns)
              Text('Kondisi Riding Hari Ini', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              
              _buildDropdown<TrafficCondition>(
                label: 'Kemacetan',
                value: _traffic,
                items: const [
                  DropdownMenuItem(value: TrafficCondition.lancar, child: Text('Lancar (Normal)')),
                  DropdownMenuItem(value: TrafficCondition.sedang, child: Text('Sedang (Stop & Go tipis)')),
                  DropdownMenuItem(value: TrafficCondition.macet, child: Text('Macet Parah (Mesin panas)')),
                ],
                onChanged: (val) => setState(() => _traffic = val!),
                icon: Icons.traffic,
              ),

              _buildDropdown<WeatherCondition>(
                label: 'Cuaca / Air',
                value: _weather,
                items: const [
                  DropdownMenuItem(value: WeatherCondition.kering, child: Text('Kering (Normal)')),
                  DropdownMenuItem(value: WeatherCondition.hujan, child: Text('Hujan (Air & Pasir)')),
                  DropdownMenuItem(value: WeatherCondition.banjir, child: Text('Banjir / Terendam')),
                ],
                onChanged: (val) => setState(() => _weather = val!),
                icon: Icons.water_drop,
              ),

              _buildDropdown<RidingStyle>(
                label: 'Gaya Berkendara',
                value: _ridingStyle,
                items: const [
                  DropdownMenuItem(value: RidingStyle.santai, child: Text('Santai (< 40 km/h)')),
                  DropdownMenuItem(value: RidingStyle.normal, child: Text('Normal (Biasa)')),
                  DropdownMenuItem(value: RidingStyle.agresif, child: Text('Agresif (Gas pol, rem blong)')),
                ],
                onChanged: (val) => setState(() => _ridingStyle = val!),
                icon: Icons.motorcycle,
              ),

              _buildDropdown<LoadCondition>(
                label: 'Beban Kendaraan',
                value: _load,
                items: const [
                  DropdownMenuItem(value: LoadCondition.normal, child: Text('Sendiri (Normal)')),
                  DropdownMenuItem(value: LoadCondition.boncenganBerat, child: Text('Boncengan / Bawa Barang Berat')),
                ],
                onChanged: (val) => setState(() => _load = val!),
                icon: Icons.fitness_center,
              ),

              const SizedBox(height: 32),
              
              // Tombol Simpan
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => _submitData(context, provider),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.racingRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Simpan & Hitung Degradasi', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget helper untuk bikin dropdown seragam
  Widget _buildDropdown<T>({
    required String label,
    required T value,
    required List<DropdownMenuItem<T>> items,
    required void Function(T?) onChanged,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<T>(
        value: value,
        items: items,
        onChanged: onChanged,
        dropdownColor: AppColors.surface,
        style: const TextStyle(color: AppColors.textMain),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.textSecondary),
          prefixIcon: Icon(icon, color: AppColors.textSecondary),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.textSecondary),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.electricTeal),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}


