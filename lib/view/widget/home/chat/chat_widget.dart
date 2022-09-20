import 'dart:async';
import 'dart:io';

import 'package:azooz/view/custom_widget/custom_error_widget.dart';

import '../../../../common/config/app_status.dart';
import '../../../../common/config/tools.dart';
import '../../../../common/style/colors.dart';
import '../../../../common/style/dimens.dart';
import '../../../../common/style/style.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/response/chat_message_model.dart';
import '../../../../providers/chat_provider.dart';
import '../../../../providers/customer_service_provider.dart';
import '../../../custom_widget/alert_dialog_widgets.dart';
import '../../../custom_widget/custom_loading_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'message_box_widget.dart';

class ChatWidget extends StatefulWidget {
  final int? chatID;
  final bool? isCustomerService;

  const ChatWidget({
    Key? key,
    this.chatID,
    this.isCustomerService = false,
  }) : super(key: key);

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget>
    with SingleTickerProviderStateMixin {
  final TextEditingController? messageController = TextEditingController();
  bool showEmoji = false;

  PaymentChoice paymentChoice = PaymentChoice.cash;
  PaymentChoice2 paymentChoice2 = PaymentChoice2.visa;

  FocusNode focusNode = FocusNode();

  Icon _emojiIcon = const Icon(
    FontAwesomeIcons.faceSmileWink,
    color: Palette.secondaryLight,
    size: 20,
  );

  int page = 1;
  late Future<List<Message>> futureListMessages;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();

    scrollController.addListener(scrollListener);

    paymentChoiceTest = PaymentChoice.cash;
    if (widget.isCustomerService == false) {
      futureListMessages =
          Provider.of<ChatProvider>(context, listen: false).getChatMessage(
        page: page,
        chatID: widget.chatID,
        context: context,
      );
      Provider.of<ChatProvider>(context, listen: false).filePicked = false;

      WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());
    } else {
      futureListMessages =
          Provider.of<CustomServiceProvider>(context, listen: false)
              .getCustomerData(context: context)
              .then(
                (value) =>
                    Provider.of<CustomServiceProvider>(context, listen: false)
                        .getChatMessage(
                  page: page,
                  context: context,
                ),
              );
      Provider.of<CustomServiceProvider>(context, listen: false).filePicked =
          false;
    }

    focusNode.addListener(
      () {
        if (focusNode.hasFocus) {
          // setState(() {
          showEmoji = false;
          _emojiIcon = const Icon(
            FontAwesomeIcons.faceSmileWink,
            color: Palette.secondaryLight,
            size: 20,
          );
          // });
        }
      },
    );
  }

  @override
  void dispose() {
    print("I am dispose method:: chat widget");
    scrollController.removeListener(scrollListener);
    scrollController.dispose();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.isCustomerService == false) {
        if (mounted) {
          Provider.of<ChatProvider>(context, listen: false).disposeData();
        }
      } else {
        if (mounted) {
          Provider.of<CustomServiceProvider>(context, listen: false)
              .disposeData();
        }
      }
    });
    super.dispose();
  }

  sendNewMessage() async {
    Tools.hideKeyboard(context);

    if (widget.isCustomerService == false &&
        messageController!.text.isNotEmpty) {
      await Provider.of<ChatProvider>(context, listen: false)
          .postData(
        textMsg: messageController?.text.trim(),
        fileMessage: '',
        type: AppStatus.mediaType['Text'],
        chatID: widget.chatID,
        context: context,
        scrollController: scrollController,
      )
          .then(
        (value) {
          // setState(() {
          scrollToBottom();
          messageController!.clear();

          // });
        },
      );
    } else if (widget.isCustomerService == true &&
        messageController!.text.isNotEmpty) {
      await Provider.of<CustomServiceProvider>(context, listen: false)
          .postData(
            textMsg: messageController?.text.trim(),
            fileMessage:
                Provider.of<CustomServiceProvider>(context, listen: false)
                            .filePicked ==
                        true
                    ? Provider.of<CustomServiceProvider>(context, listen: false)
                        .file
                        ?.path
                    : '',
            type: Provider.of<CustomServiceProvider>(context, listen: false)
                        .filePicked ==
                    true
                ? AppStatus.mediaType['Image']
                : AppStatus.mediaType['Text'],
            context: context,
          )
          .then(
            (value) => {
              scrollToBottom(),
              messageController!.clear(),
            },
          );
    }
  }

  getMoreData() {
    if (widget.isCustomerService == false) {
      print("### page: $page ###");
      if (!Provider.of<ChatProvider>(context, listen: false).endPageChat) {
        if (Provider.of<ChatProvider>(context, listen: false)
                .loadingPagination ==
            false) {
          page++;

          print("### page: $page - after ###");
          Provider.of<ChatProvider>(context, listen: false).getChatMessage(
            page: page,
            chatID: widget.chatID,
            context: context,
          );
        }
      }
    } else {
      if (!Provider.of<CustomServiceProvider>(context, listen: false)
          .endPageChat) {
        if (Provider.of<CustomServiceProvider>(context, listen: false)
                .loadingPagination ==
            false) {
          page++;
          Provider.of<CustomServiceProvider>(context, listen: false)
              .getChatMessage(
            page: page,
            context: context,
          );
        }
      }
    }
  }

  scrollListener() {
    // print(
    //     "### scrollListener - pixels:: ${scrollController.position.pixels} ###");
    // print(
    //     "### scrollListener - maxScrollExtent:: ${scrollController.position.maxScrollExtent} ###");
    if (scrollController.position.pixels >
        scrollController.position.maxScrollExtent - 500) {
      getMoreData();
    }
  }

  scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      Timer.periodic(const Duration(milliseconds: 350), scrollToBottom());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Message>>(
        future: futureListMessages,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // WidgetsBinding.instance
            //     .addPostFrameCallback((_) => scrollToBottom());
            return GestureDetector(
              onTap: () {
                Tools.hideKeyboard(context);
                if (showEmoji) {
                  // setState(() {
                  showEmoji = false;
                  _emojiIcon = const Icon(
                    FontAwesomeIcons.faceSmileWink,
                    color: Palette.secondaryLight,
                    size: 20,
                  );
                  // });
                }
              },
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    // height: 0.735,
                    child: widget.isCustomerService == false
                        ? Consumer<ChatProvider>(
                            builder: (context, provider, child) {
                              return ListView.builder(
                                reverse: true,
                                shrinkWrap: true,
                                itemCount: provider.listMessages.length + 1,
                                controller: scrollController,
                                padding: edgeInsetsOnly(
                                  bottom: 55,
                                  start: 20,
                                  end: 20,
                                ),
                                itemBuilder: (context, index) {
                                  if (index == provider.listMessages.length) {
                                    return provider.loadingPagination
                                        ? const CustomLoadingPaginationWidget()
                                        : const SizedBox();
                                  }

                                  return MessageBoxWidget(
                                    isMe: provider.listMessages[index].fromMe ??
                                        true,
                                    message:
                                        provider.listMessages[index].message,
                                    date:
                                        provider.listMessages[index].createdAt,
                                    typeID: provider.listMessages[index].typeId,
                                    withLogo: false,
                                    isRead: provider.listMessages[index].isRead,
                                  );
                                },

                                // List.generate(
                                //         list2.length,
                                //         (index) {
                                //           return MessageBoxWidget(
                                //             isMe: list2[index].isSender,
                                //             message: lis»t2[index].message,
                                //             withLogo: true,
                                //           );
                                //         },
                                //       ),
                              );
                            },
                          )
                        : Consumer<CustomServiceProvider>(
                            builder: (context, provider, child) {
                              return Column(
                                children: [
                                  const _SocialMediaWidget(),
                                  const SizedBox(height: 10),
                                  Expanded(
                                    child: ListView.builder(
                                      // reverse: true,
                                      // shrinkWrap: true,
                                      itemCount:
                                          provider.listMessages.length + 1,
                                      controller: scrollController,
                                      padding: edgeInsetsOnly(
                                        bottom: 55,
                                        start: 20,
                                        end: 20,
                                      ),
                                      itemBuilder: (context, index) {
                                        if (index ==
                                            provider.listMessages.length) {
                                          return provider.loadingPagination
                                              ? const CustomLoadingPaginationWidget()
                                              : Container(
                                                  height: 50,
                                                );
                                        }
                                        return MessageBoxWidget(
                                          isMe: provider
                                                  .listMessages[index].fromMe ??
                                              true,
                                          message: provider
                                              .listMessages[index].message,
                                          date: provider
                                              .listMessages[index].createdAt,
                                          typeID: provider
                                              .listMessages[index].typeId,
                                          withLogo: false,
                                          isRead: provider
                                              .listMessages[index].isRead,
                                        );
                                      },

                                      // List.generate(
                                      //         list2.length,
                                      //         (index) {
                                      //           return MessageBoxWidget(
                                      //             isMe: list2[index].isSender,
                                      //             message: lis»t2[index].message,
                                      //             withLogo: true,
                                      //           );
                                      //         },
                                      //       ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                  ),
                  // Positioned(
                  //   bottom: 45,
                  //   child: IconButton(
                  //       onPressed: () {
                  //         scrollToBottom();
                  //       },
                  //       icon: const Icon(
                  //         Icons.home,
                  //       )),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: Container(
                          padding: edgeInsetsOnly(start: 5),
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Palette.primaryColor,
                          ),
                          child: const Icon(
                            FontAwesomeIcons.solidPaperPlane,
                            color: Palette.kWhite,
                            size: 20,
                          ),
                        ),
                        onTap: () => sendNewMessage(),
                      ),
                      Padding(
                        padding: edgeInsetsSymmetric(vertical: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: 38,
                          decoration:
                              cardDecoration6(context: context, radius: 35),
                          child: TextFormField(
                            autocorrect: true,
                            focusNode: focusNode,
                            cursorColor: Palette.kBlack,
                            controller: messageController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 4),
                              hintText: LocaleKeys.writeMessage.tr(),
                              prefixIcon: IconButton(
                                icon: _emojiIcon,
                                onPressed: () {
                                  focusNode.unfocus();
                                  focusNode.canRequestFocus = false;
                                  // setState(
                                  //   () {
                                  showEmoji = !showEmoji;
                                  _emojiIcon = const Icon(
                                    FontAwesomeIcons.keyboard,
                                    color: Palette.secondaryLight,
                                  );
                                  //   },
                                  // );
                                },
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  widget.isCustomerService == false
                                      ? Provider.of<ChatProvider>(context,
                                              listen: false)
                                          .pickFile(context, widget.chatID!)
                                      : Provider.of<CustomServiceProvider>(
                                              context,
                                              listen: false)
                                          .pickFile();
                                },
                                child: widget.isCustomerService == false
                                    ? const Icon(
                                        FontAwesomeIcons.solidImage,
                                        color: Palette.secondaryLight,
                                        size: 20,
                                      )
                                    : Icon(
                                        Provider.of<CustomServiceProvider>(
                                                        context,
                                                        listen: false)
                                                    .filePicked ==
                                                true
                                            ? FontAwesomeIcons.checkDouble
                                            : FontAwesomeIcons.solidImage,
                                        color: Palette.secondaryLight,
                                        size: 20,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  showEmoji
                      ? sizedBox(
                          height: 0.4,
                          child: showEmojiPicker(),
                        )
                      : const SizedBox(),
                ],
              ),
            );
          } else {
            return snapshot.hasError
                ? const CustomErrorWidget()
                : const CustomLoadingWidget();
          }
        });
  }

  Widget showEmojiPicker() {
    return EmojiPicker(
      config: Config(
        columns: 7,
        emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
        verticalSpacing: 0,
        horizontalSpacing: 0,
        initCategory: Category.RECENT,
        bgColor: Palette.activeWidgetsColor,
        indicatorColor: Palette.secondaryLight,
        iconColor: Palette.kGrey400,
        iconColorSelected: Palette.secondaryLight,
        progressIndicatorColor: Palette.secondaryLight,
        backspaceColor: Palette.kAccent,
        showRecentsTab: true,
        recentsLimit: 28,
        // noRecentsText: LocaleKeys.noRecent.tr(),
        // noRecentsStyle: const TextStyle(fontSize: 20, color: Colors.black26),
        tabIndicatorAnimDuration: kTabScrollDuration,
        categoryIcons: const CategoryIcons(),
        buttonMode: ButtonMode.CUPERTINO,
      ),
      onBackspacePressed: () {
        if (showEmoji) {
          // setState(() {
          showEmoji = false;
          // });
        } else {
          showEmoji = true;
          Navigator.pop(context);
        }
      },
      onEmojiSelected: (category, emoji) {
        if (showEmoji) {
          // setState(() {
          showEmoji = false;
          // });
        } else {
          showEmoji = true;
          Navigator.pop(context);
        }
        print(emoji);
        messageController!.text = messageController!.text + emoji.emoji;
      },
    );
  }
}

class _SocialMediaWidget extends StatelessWidget {
  const _SocialMediaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Palette.kWhite,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 223, 223, 223),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            "أنت الأن تقوم بالدردشة مع: Azooz",
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: const Color.fromARGB(255, 94, 91, 105),
                ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(
                FontAwesomeIcons.facebook,
                color: Color(0xFF097EEB),
                size: 32,
              ),
              Icon(
                FontAwesomeIcons.instagram,
                color: Color(0xFFCA007F),
                size: 32,
              ),
              Icon(
                FontAwesomeIcons.twitter,
                color: Color(0xFF1D9BF0),
                size: 32,
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
