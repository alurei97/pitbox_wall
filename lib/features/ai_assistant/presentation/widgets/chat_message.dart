/// Data class representing a single chat message in the AI conversation.
class ChatMessage {
  const ChatMessage({required this.text, required this.isUser});

  final String text;
  final bool isUser;
}
