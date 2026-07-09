import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../core/constants/api_keys.dart';

// Model sederhana untuk pesan chat
class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class AiProvider with ChangeNotifier {
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;

  // Fungsi utama untuk ngirim pesan
  Future<void> sendMessage(String message, String motorContext) async {
    if (message.trim().isEmpty) return;

    // Tambahkan pesan user ke layar
    _messages.add(ChatMessage(text: message, isUser: true));
    _isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: ApiKeys.geminiApiKey,
        // Sistem Prompt (Mendoktrin AI agar bertingkah seperti mekanik)
        systemInstruction: Content.system(
          "Kamu adalah 'Bang Mekanik', montir bengkel motor senior di Indonesia yang sangat ahli dan teliti. "
          "Gaya bahasamu asik, ramah, pakai bahasa gaul mekanik (panggil bosku, ngab, dsb), tapi tetap profesional dan akurat secara teknis. "
          "Jangan jawab terlalu panjang seperti robot, langsung to the point. "
          "Berikut adalah data motor user saat ini yang wajib kamu jadikan acuan:\n\n$motorContext"
        ),
      );

      // Gabungkan sejarah chat agar AI ingat percakapan sebelumnya
      final chat = model.startChat(history: _messages.map((m) {
        return Content(m.isUser ? 'user' : 'model', [TextPart(m.text)]);
      }).toList());

      final response = await chat.sendMessage(Content.text(message));
      final aiResponseText = response.text ?? "Waduh bosku, kunci inggris saya ketinggalan nih. Coba tanya lagi ya.";

      _messages.add(ChatMessage(text: aiResponseText, isUser: false));
    } catch (e) {
      _messages.add(ChatMessage(text: "Waduh server bengkel lagi gangguan nih. Pastikan internet jalan dan API Key valid ya bosku. (Error: $e)", isUser: false));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}


