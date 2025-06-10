import 'package:flutter/material.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatBotDialog extends StatefulWidget {
  const ChatBotDialog({super.key});

  @override
  State<ChatBotDialog> createState() => _ChatBotDialogState();
}

class _ChatBotDialogState extends State<ChatBotDialog> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: KbackGroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.6,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('ChatBot',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const Divider(color: Colors.white24),
            Expanded(
              child: _error != null
                  ? Center(
                      child: Text(_error!,
                          style: const TextStyle(color: Colors.red)))
                  : ListView.builder(
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final msg = _messages[index];
                        final isUser = msg['role'] == 'user';
                        return Align(
                          alignment: isUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color:
                                  isUser ? KPrimaryColor : KDarkerPrimaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(msg['content']!,
                                style: const TextStyle(color: Colors.white)),
                          ),
                        );
                      },
                    ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: KbackGroundColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: KPrimaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: KPrimaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: KPrimaryColor, width: 2),
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: KPrimaryColor),
                  onPressed: _isLoading ? null : _sendMessage,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add({'role': 'user', 'content': text});
      _controller.clear();
      _isLoading = true;
      _error = null;
    });
    try {
      final apiKey = 'tgp_v1_-l5ep266lNzJC9T1UrRlCjgV2Q7DxnhUammN8WEpyd8';
      final url = Uri.parse('https://api.together.xyz/v1/chat/completions');
      final headers = {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        'model': 'meta-llama/Llama-4-Maverick-17B-128E-Instruct-FP8',
        'messages': [
          {
            'role': 'system',
            'content':
                'You are a helpful assistant. Only answer questions related to medical and fitness topics. If the question is not about medical or fitness, politely refuse to answer.'
          },
          {'role': 'user', 'content': text}
        ]
      });

      final response =
          await http.post(url, headers: headers, body: body).timeout(
                const Duration(seconds: 30),
                onTimeout: () => throw Exception('Request timed out'),
              );
      print('API response: \n${response.body}'); // Debug print

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String botReply = '';
        try {
          botReply = data['choices'][0]['message']['content'] ?? '';
        } catch (e) {
          botReply = '';
        }
        setState(() {
          _messages.add({
            'role': 'bot',
            'content': botReply.isNotEmpty ? botReply : 'No response from bot.'
          });
        });
      } else {
        final data = jsonDecode(response.body);
        setState(() {
          _error =
              data['error']?['message'] ?? 'API Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to get response: '
            '[31m$e[0m';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
