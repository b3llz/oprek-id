
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../providers/ai_provider.dart';
import '../../providers/app_provider.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({Key? key}) : super(key: key);

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController _textController = TextEditingController();

  // Fungsi merakit data motor untuk disuntik ke AI
  String _buildMotorContext(AppProvider appProvider) {
    final motor = appProvider.currentMotor;
    if (motor == null) return "User belum setup motor.";

    String contextInfo = "Motor User: ${motor.brand} ${motor.name} (${motor.type}, ${motor.cc}cc)\n";
    contextInfo += "Odometer Sekarang: ${appProvider.currentOdo} KM\n";
    contextInfo += "Kondisi Komponen:\n";
    
    for (var comp in appProvider.activeComponents) {
      contextInfo += "- ${comp.name}: Sisa Nyawa ${comp.healthPercentage.toInt()}% (Telah dipakai ${comp.totalEffectiveKm.toInt()} KM dari batas ${comp.baseLifeKm.toInt()} KM)\n";
    }
    return contextInfo;
  }

  void _handleSend(BuildContext context) {
    final text = _textController.text;
    if (text.trim().isEmpty) return;
    
    _textController.clear();
    
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    final aiProvider = Provider.of<AiProvider>(context, listen: false);
    
    // Kirim pesan + data motor
    aiProvider.sendMessage(text, _buildMotorContext(appProvider));
  }

  @override
  Widget build(BuildContext context) {
    final aiProvider = Provider.of<AiProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.smart_toy, color: AppColors.electricTeal),
            const SizedBox(width: 8),
            const Text('Konsultasi Bang Mekanik'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Area Daftar Chat
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: aiProvider.messages.length,
              itemBuilder: (context, index) {
                final message = aiProvider.messages[index];
                return _buildChatBubble(message, context);
              },
            ),
          ),
          
          // Indikator Loading (AI lagi ngetik)
          if (aiProvider.isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(color: AppColors.electricTeal),
            ),
            
          // Area Input Teks
          Container(
            padding: const EdgeInsets.all(12.0),
            color: AppColors.surface,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    style: const TextStyle(color: AppColors.textMain),
                    decoration: InputDecoration(
                      hintText: 'Tanya masalah motormu...',
                      hintStyle: const TextStyle(color: AppColors.textSecondary),
                      filled: true,
                      fillColor: AppColors.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    onSubmitted: (_) => _handleSend(context),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: AppColors.racingRed,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () => _handleSend(context),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(ChatMessage message, BuildContext context) {
    final isUser = message.isUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75, // Maksimal lebar 75%
        ),
        decoration: BoxDecoration(
          color: isUser ? AppColors.electricTeal.withOpacity(0.2) : AppColors.surface,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isUser ? const Radius.circular(16) : const Radius.circular(4),
            bottomRight: isUser ? const Radius.circular(4) : const Radius.circular(16),
          ),
          border: Border.all(
            color: isUser ? AppColors.electricTeal.withOpacity(0.5) : AppColors.surface,
          ),
        ),
        child: Text(
          message.text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isUser ? AppColors.electricTeal : AppColors.textMain,
          ),
        ),
      ),
    );
  }
}

