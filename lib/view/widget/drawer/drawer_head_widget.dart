import 'package:azooz/common/custom_waiting_dialog.dart';
import 'package:azooz/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../common/config/assets.dart';
import '../../../common/style/colors.dart';
import '../../../common/style/dimens.dart';
import '../../../providers/profile_provider.dart';
import '../../../providers/user_provider.dart';
import '../../custom_widget/custom_cached_image_widget.dart';
import '../../custom_widget/marquee_widget.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class DrawerHeadWidget extends StatelessWidget {
  const DrawerHeadWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(
              //   height: 50,
              //   width: 100,
              //   child: logoImg,
              // ),
              // SizedBox(height: 10),
              Padding(
                padding: edgeInsetsOnly(start: 25, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: edgeInsetsOnly(end: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Palette.kWhite,
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                            // boxShadow: const [
                            //   BoxShadow(
                            //     color: kDarkGreyCards,
                            //     offset: Offset(0.0, 2),
                            //     blurRadius: 2.0,
                            //   ),
                            // ],
                            color: Palette.kWhite,
                          ),
                          child: Consumer<ProfileProvider>(
                            builder: (context, provider, child) {
                              return CachedImageCircular(
                                height: 40,
                                width: 35,
                                boxFit: BoxFit.cover,
                                imageUrl: provider.userImage,
                              );
                            },
                          ),
                        ),
                        // SizedBox(height: 4),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     const Icon(
                        //       Icons.star,
                        //       color: Palette.kRating,
                        //       size: 15,
                        //     ),
                        //     Text(
                        //       '4.9',
                        //       style: TextStyle(
                        //         color: Theme.of(context).primaryColorLight,
                        //         fontSize: 12,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 175,
                          child: MarqueeWidget(
                            child: Consumer<ProfileProvider>(
                              builder: (context, provider, child) {
                                return Text(
                                  "${LocaleKeys.hello.tr()} ${provider.userName}",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                    fontSize: 12,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: SizedBox(
                            width: 175,
                            child: MarqueeWidget(
                              child: Consumer<ProfileProvider>(
                                builder: (context, provider, child) {
                                  return Text(
                                    provider.userPhoneNumber,
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontSize: 12,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: ((context) {
                  return SmartAlertDialog(
                    title: "",
                    description: LocaleKeys.logoutMsg.tr(),
                    confirmPress: () {
                      Provider.of<UserProvider>(context, listen: false)
                          .logOut(context: context)
                          .then((value) => Navigator.of(context).pop());
                    },
                    cancelPress: () {
                      Navigator.of(context).pop();
                    },
                    confirmText: LocaleKeys.confirm.tr(),
                    cancelText: LocaleKeys.cancel.tr(),
                  );
                }),
              );
              //   alertDialogLogout(
              //   onPressed: () => routerPop(context).whenComplete(
              //     () => Provider.of<UserProvider>(context, listen: false)
              //         .logOut(context: context),
              //   ),
              //   context: context,
              // );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: RotatedBox(
                quarterTurns: 2,
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: logoutSVG,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
