import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/ai_provider.dart';
import '../../providers/app_provider.dart';
import '../../core/constants/app_colors.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({Key? key}) : super(key: key);
  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final _textController = TextEditingController();

  String _generateMotorContext(AppProvider app) {
    final motor = app.currentMotor;
    if (motor == null) return "User belum memilih motor.";
    String s = "Motor: ${motor.brand} ${motor.name} (ODO: ${app.currentOdo.toInt()} KM).\nKomponen:\n";
    for (var c in app.activeComponents) {
      s += "- ${c.name}: Sisa Nyawa ${c.healthPercentage.toInt()}%\n";
    }
    return s;
  }

  @override
  Widget build(BuildContext context) {
    final aiProvider = Provider.of<AiProvider>(context);
    final appProvider = Provider.of<AppProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Konsultasi Bang Mekanik AI')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: aiProvider.messages.length,
              itemBuilder: (context, index) {
                final msg = aiProvider.messages[index];
                return Align(
                  alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: msg.isUser ? AppColors.electricTeal.withOpacity(0.2) : AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg.text, style: TextStyle(color: msg.isUser ? AppColors.electricTeal : AppColors.textMain)),
                  ),
                );
              },
            ),
          ),
          if (aiProvider.isLoading) const Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator(color: AppColors.electricTeal)),
          Container(
            padding: const EdgeInsets.all(8),
            color: AppColors.surface,
            child: Row(
              children: [
                Expanded(child: TextField(controller: _textController, decoration: const InputDecoration(hintText: 'Tanya masalah kirian, oli, gredek...', border: InputBorder.none))),
                IconButton(
                  icon: const Icon(Icons.send, color: AppColors.racingRed),
                  onPressed: () {
                    final ctxInfo = _generateMotorContext(appProvider);
                    aiProvider.sendMessage(_textController.text, ctxInfo);
                    _textController.clear();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


