import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/chat_provider.dart';
import '../../widget/home/chat/chat_history_list_widget.dart';

class ChatHistoryScreen extends StatefulWidget {
  static const routeName = 'chat_history';

  const ChatHistoryScreen({Key? key}) : super(key: key);

  @override
  State<ChatHistoryScreen> createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  @override
  void dispose() {
    context.read<ChatProvider>().disposeData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const ChatHistoryListWidget();
  }
}
