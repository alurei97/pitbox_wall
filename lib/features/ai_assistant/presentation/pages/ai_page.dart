import 'package:flutter/material.dart';

import '../../../../core/di/di.dart';
import '../../domain/ai_assistant_service.dart';
import '../widgets/ai_header.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_message.dart';
import '../widgets/composer.dart';
import '../widgets/empty_conversation.dart';
import '../widgets/thinking_bubble.dart';

/// Pitbox AI — chat assistant.
class AiPage extends StatelessWidget {
  const AiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: _AiChatView()),
    );
  }
}

class _AiChatView extends StatefulWidget {
  const _AiChatView();

  @override
  State<_AiChatView> createState() => _AiChatViewState();
}

class _AiChatViewState extends State<_AiChatView> {
  final _composerController = TextEditingController();
  final _scrollController = ScrollController();
  final _messages = <ChatMessage>[
    const ChatMessage(
      text: 'Ask me about the current F1 season: race results, or driver stats.',
      isUser: false,
    ),
  ];

  bool _isThinking = false;
  int _requestId = 0;
  final _assistant = getIt<AiAssistantService>();

  @override
  void dispose() {
    _composerController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage([String? suggestedMessage]) async {
    final text = (suggestedMessage ?? _composerController.text).trim();
    if (text.isEmpty || _isThinking) return;

    _composerController.clear();
    final requestId = ++_requestId;
    final history = _messages
        .skip(1)
        .where((message) => message.text.isNotEmpty)
        .map((message) => AiChatTurn(text: message.text, isUser: message.isUser))
        .toList(growable: false);
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _isThinking = true;
    });
    _scrollToBottom();

    var response = '';
    try {
      await for (final chunk in _assistant.streamAnswer(question: text, history: history)) {
        if (!mounted || requestId != _requestId) return;
        response += chunk;
        setState(() {
          _isThinking = false;
          if (_messages.last.isUser) {
            _messages.add(ChatMessage(text: response, isUser: false));
          } else {
            _messages[_messages.length - 1] = ChatMessage(text: response, isUser: false);
          }
        });
        _scrollToBottom();
      }

      if (mounted && requestId == _requestId && response.isEmpty) {
        throw const AiAssistantException('The AI returned an empty response.');
      }
    } catch (error) {
      debugPrint('[AiPage] caught error: $error');
      if (!mounted || requestId != _requestId) return;
      setState(() {
        _isThinking = false;
        _messages.add(ChatMessage(text: _errorMessage(error), isUser: false));
      });
      _scrollToBottom();
    }
  }

  String _errorMessage(Object error) {
    if (error is AiAssistantException) return error.message;
    return 'I could not reach Pitbox AI right now. Check your connection and try again.';
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOut,
      );
    });
  }

  void _clearConversation() {
    _requestId++;
    setState(() {
      _messages
        ..clear()
        ..add(
          const ChatMessage(
            text: 'Ask me about the current F1 season: race results, or driver stats.',
            isUser: false,
          ),
        );
      _isThinking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        AiHeader(theme: theme, onClear: _clearConversation),

        Expanded(
          child: _messages.length == 1
              ? EmptyConversation(
                  onPromptSelected: _sendMessage,
                  controller: _scrollController,
                )
              : ListView.builder(
                  controller: _scrollController,
                  padding: const .all(16),
                  itemCount: _messages.length + (_isThinking ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (_isThinking && index == _messages.length) {
                      return const ThinkingBubble();
                    }
                    return ChatBubble(message: _messages[index]);
                  },
                ),
        ),

        Composer(
          controller: _composerController,
          enabled: !_isThinking,
          onSend: _sendMessage,
          colorScheme: colorScheme,
        ),
      ],
    );
  }
}
