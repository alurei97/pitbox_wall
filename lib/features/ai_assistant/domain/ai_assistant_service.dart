import 'package:flutter/foundation.dart';

/// Abstract interface for AI assistant services.
/// Allows swapping between different LLM providers (Gemini, Groq, local, etc.)
abstract interface class AiAssistantService {
  /// Streams an answer for the given question with conversation history.
  Stream<String> streamAnswer({
    required String question,
    required List<AiChatTurn> history,
  });

  /// Builds the season context from repositories.
  /// Exposed for testing and for local-first implementations.
  Future<String> buildSeasonContext();

  /// Answers a factual question directly from local data without LLM.
  /// Returns null if the question requires LLM reasoning.
  String? answerFromLocalData(String question);
}

/// Represents a single turn in the chat conversation.
@immutable
class AiChatTurn {
  const AiChatTurn({required this.text, required this.isUser});

  final String text;
  final bool isUser;
}

/// Exception thrown by AI assistant services.
class AiAssistantException implements Exception {
  const AiAssistantException(this.message);

  final String message;

  @override
  String toString() => message;
}
