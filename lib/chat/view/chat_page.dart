import 'package:chat_repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:slack_chat/chat/chat.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit(
        chatRepository: context.read<ChatRepository>(),
      )..init(),
      child: ChatView(),
    );
  }
}

class ChatView extends StatelessWidget {
  ChatView({super.key});

  final _scrollController = ScrollController();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatCubit, ChatState>(
        listenWhen: (previous, current) =>
            previous.messages != current.messages,
        listener: (context, state) async {
          await Future<void>.delayed(const Duration(milliseconds: 200));
          await _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
          );
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final message in state.messages)
                          Align(
                            alignment: message.senderId == 'client'
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              constraints: const BoxConstraints(
                                maxWidth: 200,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              margin: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: message.senderId == 'client'
                                    ? Colors.blue.shade800
                                    : Colors.blueGrey.shade300,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                message.content,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          label: Text('Message'),
                          border: OutlineInputBorder(),
                        ),
                        controller: _textController,
                        onChanged: context.read<ChatCubit>().updateText,
                        onSubmitted: (_) {
                          context.read<ChatCubit>().sendMessage();
                          _textController.clear();
                        },
                      ),
                    ),
                    const Gap(6),
                    IconButton(
                      onPressed: () {
                        context.read<ChatCubit>().sendMessage();
                        _textController.clear();
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
