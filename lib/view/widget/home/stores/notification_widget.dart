import 'package:azooz/view/screen/auth/fcm_notification_model.dart';
import 'package:azooz/view/screen/home/navigation_manager.dart';

import '../../../../common/config/notification_types.dart';
import '../../../../common/config/tools.dart';
import '../../../../common/style/colors.dart';
import '../../../../common/style/dimens.dart';
import '../../../../common/style/style.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/response/notification_model.dart';
import '../../../../providers/notification_provider.dart';
import '../../../custom_widget/custom_cached_image_widget.dart';
import '../../../custom_widget/custom_error_widget.dart';
import '../../../custom_widget/custom_loading_widget.dart';
import '../../../custom_widget/marquee_widget.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  late Future<NotificationModel> future;

  int page = 1;

  late final NotificationProvider provider;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    provider = Provider.of<NotificationProvider>(context, listen: false);

    future = provider.getData(page: page, context: context);

    scrollController.addListener(scrollListener);
  }

  getMoreData() {
    if (!provider.endPage) {
      if (provider.loadingPagination == false) {
        page++;
        provider.getData(page: page, context: context);
      }
    }
  }

  scrollListener() => Tools.scrollListener(
        scrollController: scrollController,
        getMoreData: getMoreData,
      );

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return provider.listNotification!.isEmpty
              ? Center(child: Text(LocaleKeys.noNotification.tr()))
              : Consumer<NotificationProvider>(
                  builder: (context, provider, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      controller: scrollController,
                      itemCount: provider.listNotification!.length + 1,
                      itemBuilder: (context, index) {
                        if (index == provider.listNotification!.length) {
                          return provider.loadingPagination
                              ? const CustomLoadingPaginationWidget()
                              : const SizedBox();
                        }
                        return GestureDetector(
                          onTap: () {
                            int? navType = provider
                                .listNotification![index].notificationType;

                            var notificationBody = FCMNotificationModel(
                              title: provider.listNotification![index].title!,
                              body: provider.listNotification![index].message!,
                              notificationType: navType.toString(),
                              orderID: provider.listNotification![index].orderId
                                  .toString(),
                              chatId: provider.listNotification![index].chatId
                                  .toString(),
                            );

                            navigateToScreen(context, notificationBody);

                            print("### I am navigation type $navType ###");
                            print(
                                "### IM navigation messagess ${provider.listNotification![index].chatId} ###");
                            var data = FCMNotificationModel(
                              title: provider.listNotification![index].title!,
                              body: provider.listNotification![index].message!,
                              notificationType: navType.toString(),
                              orderID: provider.listNotification![index].orderId
                                  .toString(),
                              chatId: provider.listNotification![index].chatId
                                  .toString(),
                            ).toJson();

                            print(
                                "### I am navigation navigation navigation list $data ###");

                            // if (navType == null) return;
                            // if (navType == 0) {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(builder: (_) {
                            //       return const NavigationManager(
                            //           selectedIndex: 0);
                            //     }),
                            //   );
                            // } else if (navType == 1) {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(builder: (_) {
                            //       return const NavigationManager(
                            //           selectedIndex: 3);
                            //     }),
                            //   );
                            // } else if (navType == 2) {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(builder: (_) {
                            //       return const NavigationManager(
                            //           selectedIndex: 2);
                            //     }),
                            //   );
                            // } else if (navType == 4) {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(builder: (_) {
                            //       return const NavigationManager(
                            //           selectedIndex: 3);
                            //     }),
                            //   );
                            // } else if (navType == 7) {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(builder: (_) {
                            //       return const NavigationManager(
                            //           selectedIndex: 2);
                            //     }),
                            //   );
                            // }
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            decoration:
                                cardDecoration5(context: context, radius: 12),
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
                                            .listNotification![index].from?.url,
                                        width: 45,
                                        height: 55,
                                        boxFit: BoxFit.cover,
                                      ),
                                      sizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: screenSize.width * 0.72,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: MarqueeWidget(
                                                    child: Text(
                                                      provider
                                                          .listNotification![
                                                              index]
                                                          .title!
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: edgeInsetsOnly(
                                                      start: 3.0),
                                                  child: MarqueeWidget(
                                                    child: Text(
                                                      provider
                                                          .listNotification![
                                                              index]
                                                          .createdAt
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: Palette.kAccent,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: screenSize.width * 0.72,
                                            child: Text(
                                              provider.listNotification![index]
                                                  .message
                                                  .toString(),
                                              maxLines: 10,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                color: Palette.secondaryLight,
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
                      },
                    );
                  },
                );
        } else {
          return snapshot.hasError
              ? const CustomErrorWidget()
              : const CustomLoadingWidget();
        }
      },
    );
  }
}

class NotificationsList extends StatelessWidget {
  const NotificationsList({
    Key? key,
    required this.scrollController,
    required this.provider,
  }) : super(key: key);

  final ScrollController scrollController;

  final NotificationProvider provider;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ListView.builder(
      shrinkWrap: true,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      controller: scrollController,
      itemCount: provider.listNotification!.length + 1,
      itemBuilder: (context, index) {
        if (index == provider.listNotification!.length) {
          return provider.loadingPagination
              ? const CustomLoadingPaginationWidget()
              : const SizedBox();
        }
        return GestureDetector(
          onTap: () {
            int? navType = provider.listNotification![index].notificationType;

            print("### I am navigation type $navType ###");
            print(
                "### IM navigation message ${provider.listNotification![index]} ###");

            if (navType == null) return;
            if (navType == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) {
                  return const NavigationManager(selectedIndex: 0);
                }),
              );
            } else if (navType == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) {
                  return const NavigationManager(selectedIndex: 3);
                }),
              );
            } else if (navType == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) {
                  return const NavigationManager(selectedIndex: 2);
                }),
              );
            } else if (navType == 7) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) {
                  return const NavigationManager(selectedIndex: 2);
                }),
              );
            }
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: cardDecoration5(context: context, radius: 12),
            child: Container(
              // padding: const EdgeInsets.only(bottom: 5),
              margin: edgeInsetsOnly(bottom: 10, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizedBox(width: 5),
                      CachedImageCircular(
                        imageUrl: provider.listNotification![index].from?.url,
                        width: 45,
                        height: 55,
                        boxFit: BoxFit.cover,
                      ),
                      sizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sizedBox(
                            width: screenSize.width * 0.72,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: MarqueeWidget(
                                    child: Text(
                                      provider.listNotification![index].title!
                                          .toString(),
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: edgeInsetsOnly(start: 3.0),
                                  child: MarqueeWidget(
                                    child: Text(
                                      provider
                                          .listNotification![index].createdAt
                                          .toString(),
                                      style: const TextStyle(
                                        color: Palette.kAccent,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // sizedBox(height: 5),
                          sizedBox(
                            width: screenSize.width * 0.72,
                            child: Text(
                              provider.listNotification![index].message
                                  .toString(),
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Palette.secondaryLight,
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
      },
    );
  }
}
