import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../core/constants/api_keys.dart';

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

  Future<void> sendMessage(String message, String motorContext) async {
    if (message.trim().isEmpty) return;
    _messages.add(ChatMessage(text: message, isUser: true));
    _isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: ApiKeys.geminiApiKey,
        systemInstruction: Content.system(
          "Kamu adalah 'Bang Mekanik', ahli mesin senior Indonesia berwawasan luas dengan pengalaman 30 tahun. "
          "Gaya bicaramu asik, pakai istilah perbengkelan lokal (bosku, kirian, peyang, slip, ngempos), "
          "tapi analisis motormu sangat tajam, solutif, dan mendalam. Berikan jawaban padat dan mantap. "
          "Gunakan konteks motor user berikut untuk mendiagnosa:\n$motorContext"
        ),
      );
      final chat = model.startChat(history: _messages.map((m) => Content(m.isUser ? 'user' : 'model', [TextPart(m.text)])).toList());
      final response = await chat.sendMessage(Content.text(message));
      _messages.add(ChatMessage(text: response.text ?? "Gagal koneksi ke bengkel AI.", isUser: false));
    } catch (e) {
      _messages.add(ChatMessage(text: "Kunci inggris mekanik AI patah nih bosku. Cek lagi konfigurasi API Key kamu. ($e)", isUser: false));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}


