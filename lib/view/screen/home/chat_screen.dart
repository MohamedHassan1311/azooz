import 'dart:developer';

import 'package:provider/provider.dart';

import '../../../common/style/colors.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../providers/chat_provider.dart';
import '../../widget/home/chat/chat_widget.dart';
import '../../widget/home/chat/driver_details_chat_widget.dart';
import '../../widget/home/chat/store_hud_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = 'chat';
  final int? orderID;
  final int? chatID;
  final bool? isStore;

  const ChatScreen({
    Key? key,
    required this.orderID,
    required this.chatID,
    this.isStore = false,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    final listOfMessages = context.read<ChatProvider>().listMessages;
    for (var element in listOfMessages) {
      print("I am chat fromMe::: ${element}");
      // print("I am chat fromMe::: ${element.fromMe}");
      // print("I am chat message::: ${element.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    log('Start Notifications ');
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    print("############# ChatScreen #############");
    print("############# orderID: ${widget.orderID} #############");
    print("############# chatID: ${widget.chatID} #############");
    return KeyboardDismisser(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            LocaleKeys.conversation.tr(),
          ),
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Column(
            // physics: const NeverScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: (widget.orderID != 0) ? 200 : 150,
                child: Column(
                  children: [
                    if (widget.orderID != 0)
                      Expanded(
                        child:
                            DriverDetailsChatHudWidget(orderID: widget.orderID),
                      ),
                    if (widget.orderID == null || widget.orderID == 0)
                      Expanded(
                        child: StoreChatHudWidget(chatId: widget.chatID!),
                      )
                  ],
                ),
              ),
              Expanded(
                child: ChatWidget(chatID: widget.chatID),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
