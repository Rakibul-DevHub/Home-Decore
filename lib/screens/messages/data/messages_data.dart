import 'package:flutter/material.dart';

import '../../../theme/kolek_colors.dart';

abstract final class MessagesData {
  static const sectionLabel = 'MESSAGES';
  static const folderTitle = 'All Messages';
  static const avatarAsset = 'assets/images/demo_user.png';
  static const onlineColor = Color(0xFF22C55E);

  static final List<MessageThread> threads = [
    MessageThread(
      id: '1',
      name: 'Khairul Vau',
      preview: 'Is the linen blazer still available?',
      timeLabel: '2m',
      unreadCount: 3,
      avatarAsset: avatarAsset,
      isOnline: true,
      typingName: 'Nur',
      messages: const [
        ChatMessage(
          id: 'm1',
          text:
              'Is the linen blazer still available?\nWould love to grab it',
          timeLabel: '10:23 AM',
          isMine: false,
        ),
        ChatMessage(
          id: 'm2',
          text: 'Yes it is! Just listed it today',
          timeLabel: '10:24 AM',
          isMine: true,
        ),
      ],
      draft:
          'Is the linen blazer still available? Would love to grab it',
    ),
    ...List.generate(
      6,
      (index) => MessageThread(
        id: '${index + 2}',
        name: 'Courtney Henry',
        preview: 'Is the liner blazer still available?',
        timeLabel: '2m',
        unreadCount: 3,
        avatarAsset: avatarAsset,
        isOnline: false,
        messages: const [
          ChatMessage(
            id: 'c1',
            text: 'Is the liner blazer still available?',
            timeLabel: '10:20 AM',
            isMine: false,
          ),
          ChatMessage(
            id: 'c2',
            text: 'Let me check and get back to you.',
            timeLabel: '10:21 AM',
            isMine: true,
          ),
        ],
      ),
    ),
  ];
}

final class MessageThread {
  const MessageThread({
    required this.id,
    required this.name,
    required this.preview,
    required this.timeLabel,
    required this.unreadCount,
    required this.avatarAsset,
    required this.messages,
    this.isOnline = false,
    this.typingName,
    this.draft = '',
  });

  final String id;
  final String name;
  final String preview;
  final String timeLabel;
  final int unreadCount;
  final String avatarAsset;
  final bool isOnline;
  final String? typingName;
  final List<ChatMessage> messages;
  final String draft;
}

final class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.text,
    required this.timeLabel,
    required this.isMine,
  });

  final String id;
  final String text;
  final String timeLabel;
  final bool isMine;

  Color get bubbleColor =>
      isMine ? KolekColors.blue600 : const Color(0xFF1A1A1A);
}
