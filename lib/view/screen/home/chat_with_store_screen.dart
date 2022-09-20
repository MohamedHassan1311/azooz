import '../../../common/style/dimens.dart';
import '../../../generated/locale_keys.g.dart';
import '../../widget/home/chat/chat_widget.dart';
import '../../widget/home/chat/store_hud_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class ChatWithStoreScreen extends StatefulWidget {
  static const routeName = 'chatWithStore';
  final int? chatID;

  const ChatWithStoreScreen({Key? key, required this.chatID}) : super(key: key);

  @override
  State<ChatWithStoreScreen> createState() => _ChatWithStoreScreenState();
}

class _ChatWithStoreScreenState extends State<ChatWithStoreScreen> {
  @override
  void initState() {
    super.initState();
    print("I am from chat with store screen:: ${widget.chatID}");
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    print("############# ChatScreen #############");
    print("############# chatID: ${widget.chatID} #############");
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(title: Text(LocaleKeys.conversation.tr())),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              // physics: const NeverScrollableScrollPhysics(),
              children: [
                sizedBox(
                  height: screenHeight * 0.160,
                  child: Column(
                    children: [
                      Expanded(
                        child: StoreChatHudWidget(chatId: widget.chatID!),
                      ),
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
      ),
    );
  }
}
