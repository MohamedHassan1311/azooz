import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../common/routes/app_router_control.dart';
import '../../../../common/routes/app_router_import.gr.dart';
import '../../../../common/style/colors.dart';
import '../../../../common/style/dimens.dart';
import '../../../../common/style/style.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/response/all_chat_model.dart';
import '../../../../providers/chat_provider.dart';
import '../../../custom_widget/custom_cached_image_widget.dart';
import '../../../custom_widget/custom_error_widget.dart';
import '../../../custom_widget/custom_loading_widget.dart';
import '../../../custom_widget/marquee_widget.dart';

class ChatHistoryListWidget extends StatefulWidget {
  const ChatHistoryListWidget({Key? key}) : super(key: key);

  @override
  State<ChatHistoryListWidget> createState() => _ChatHistoryListWidgetState();
}

class _ChatHistoryListWidgetState extends State<ChatHistoryListWidget> {
  late Future<List<AllChat>> future;
  int page = 1;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    future = Provider.of<ChatProvider>(context, listen: false)
        .getAllChats(page: page, context: context);

    scrollController.addListener(scrollListener);
  }

  getMoreData() {
    final provider = Provider.of<ChatProvider>(context, listen: false);
    if (!provider.endPageAllChats) {
      page++;
      provider.getAllChats(page: page, context: context);
    }
  }

  scrollListener() {
    // print(
    //     ":: scrollController.position.pixels :: ${scrollController.position.pixels}");

    // print(
    //     ":: scrollController.position.maxScrollExtent :: ${scrollController.position.maxScrollExtent}");
    if (scrollController.position.pixels >
        scrollController.position.maxScrollExtent - 250) {
      getMoreData();
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    Provider.of<ChatProvider>(context, listen: false).disposeData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    log('message');
    return FutureBuilder<List<AllChat>>(
      future: Provider.of<ChatProvider>(context, listen: false)
          .getAllChats(page: page, context: context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          log('${snapshot.data!}');
        }
        return snapshot.hasData
            ? snapshot.data!.isEmpty
                ? CustomErrorWidget(message: LocaleKeys.noMessages.tr())
                : Consumer<ChatProvider>(
                    builder: (context, provider, child) {
                      return ListView.builder(
                          addAutomaticKeepAlives: false,
                          addRepaintBoundaries: false,
                          controller: scrollController,
                          itemCount: provider.listAllChats.length,
                          padding: const EdgeInsets.only(bottom: 30),
                          itemBuilder: (context, index) {
                            if (index == provider.listAllChats.length) {
                              return provider.loadingPagination
                                  ? const CustomLoadingPaginationWidget()
                                  : const SizedBox();
                            }
                            return GestureDetector(
                              onTap: () {
                                routerPush(
                                  context: context,
                                  route: ChatScreenRoute(
                                    orderID:
                                        provider.listAllChats[index].orderId,
                                    chatID: provider.listAllChats[index].id,
                                  ),
                                );

                                print(
                                    "###Chaaat order id: ${provider.listAllChats[index].orderId}");
                                print(
                                    "###Chaaat2 - chat id: ${provider.listAllChats[index].id}");
                              },
                              child: Container(
                                margin: edgeInsetsAll(8),
                                decoration: cardDecoration5(
                                    context: context, radius: 12),
                                child: Container(
                                  // padding: const EdgeInsets.only(bottom: 5),
                                  margin: edgeInsetsOnly(bottom: 10, top: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          sizedBox(width: 5),
                                          CachedImageCircular(
                                            imageUrl: provider
                                                .listAllChats[index]
                                                .otherUser
                                                ?.imageURl,
                                            width: 45,
                                            height: 55,
                                            boxFit: BoxFit.cover,
                                          ),
                                          sizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              sizedBox(
                                                width: screenSize.width * 0.72,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: MarqueeWidget(
                                                        child: Text(
                                                          provider
                                                              .listAllChats[
                                                                  index]
                                                              .otherUser!
                                                              .name
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .subtitle1,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      // mainAxisAlignment:
                                                      // MainAxisAlignment
                                                      //     .spaceEvenly,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              edgeInsetsOnly(
                                                                  start: 3.0),
                                                          child: MarqueeWidget(
                                                            child: Text(
                                                              provider
                                                                  .listAllChats[
                                                                      index]
                                                                  .createAt
                                                                  .toString(),
                                                              style:
                                                                  const TextStyle(
                                                                color: Palette
                                                                    .kAccent,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        Text(
                                                          provider
                                                                      .listAllChats[
                                                                          index]
                                                                      .orderId ==
                                                                  0
                                                              ? ""
                                                              : provider
                                                                  .listAllChats[
                                                                      index]
                                                                  .orderId
                                                                  .toString(),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // sizedBox(height: 5),
                                              sizedBox(
                                                width: screenSize.width * 0.72,
                                                child: MarqueeWidget(
                                                  child: Text(
                                                    provider.listAllChats[index]
                                                                .details ==
                                                            null
                                                        ? "صورة"
                                                        : provider
                                                            .listAllChats[index]
                                                            .details
                                                            .toString(),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                      color: Palette
                                                          .secondaryLight,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              sizedBox(height: 5),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                  )
            : snapshot.hasError
                ? const CustomErrorWidget()
                : const CustomLoadingWidget();
      },
    );
  }
}
