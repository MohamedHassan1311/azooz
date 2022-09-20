import 'package:easy_localization/easy_localization.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

import '../../../common/config/assets.dart';
import '../../../common/custom_waiting_dialog.dart';
import '../../../common/routes/app_router_control.dart';
import '../../../common/routes/app_router_import.gr.dart';
import '../../../common/style/colors.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../model/screen_argument/address_argument.dart';
import '../../../model/screen_argument/terms_about_app_argument.dart';
import '../../../providers/app_provider.dart';
import '../../../providers/profile_provider.dart';
import '../../../providers/user_provider.dart';
import '../../custom_widget/drawer_list_tile_widget.dart';

class DrawerItemsWidget extends StatelessWidget {
  const DrawerItemsWidget({
    Key? key,
    required this.zoomDrawerController,
  }) : super(key: key);

  final ZoomDrawerController zoomDrawerController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              DrawerListTileWidget(
                icon: editSVG,
                title: LocaleKeys.updateProfile.tr(),
                onTap: () {
                  routerPush(
                    context: context,
                    route: const EditProfileRoute(),
                  ).then((value) {
                    zoomDrawerController.toggle!();
                  });
                },
              ),
              DrawerListTileWidget(
                icon: locationMarker2SVG,
                title: LocaleKeys.addresses.tr(),
                onTap: () {
                  routerPush(
                    context: context,
                    route: AddressRoute(
                      argument: const AddressArgument(
                        newAddress: false,
                        fromOrdersDetails: false,
                        fromAdsScreen: false,
                        isAddressSelector: false,
                      ),
                    ),
                  ).then((value) {
                    zoomDrawerController.toggle!();
                  });
                },
              ),
              DrawerListTileWidget(
                icon: walletSVG,
                title: LocaleKeys.wallet.tr(),
                onTap: () {
                  routerPush(
                    context: context,
                    route: const PaymentWaysRoute(),
                  ).then((value) {
                    zoomDrawerController.toggle!();
                  });
                },
              ),
              // DrawerListTileWidget(
              //   icon: heartSVG,
              //   title: 'المـفضله',
              //   onTap: () => routerPush(
              //     context: context,
              //     route: const FavoriteRoute(),
              //   ),
              // ),
              DrawerListTileWidget(
                icon: advertSVG,
                title: LocaleKeys.myAdverts.tr(),
                onTap: () {
                  routerPush(
                    context: context,
                    route: const AdvertsRoute(),
                  ).then((value) {
                    zoomDrawerController.toggle!();
                  });
                },
              ),
              DrawerListTileWidget(
                icon: details2SVG,
                title: LocaleKeys.rates.tr(),
                onTap: () {
                  routerPush(
                    context: context,
                    route: const ReviewsRoute(),
                  ).then((value) {
                    zoomDrawerController.toggle!();
                  });
                },
              ),
              divider(),
              DrawerListTileWidget(
                icon: warningSVG,
                title: LocaleKeys.aboutUS.tr(),
                onTap: () {
                  routerPush(
                    context: context,
                    route: TermsAboutAppRoute(
                      argument: const TermsAboutAppArgument(isTerms: false),
                    ),
                  ).then((value) {
                    zoomDrawerController.toggle!();
                  });
                },
              ),
              DrawerListTileWidget(
                icon: documentSVG,
                title: LocaleKeys.terms.tr(),
                onTap: () {
                  routerPush(
                    context: context,
                    route: TermsAboutAppRoute(
                      argument: const TermsAboutAppArgument(isTerms: true),
                    ),
                  ).then((value) {
                    zoomDrawerController.toggle!();
                  });
                },
              ),
              divider(),

              Selector<ProfileProvider, bool?>(
                selector: (context, provider) => provider.isDriver,
                builder: (context, isDriver, child) {
                  if (isDriver == null || isDriver == false) {
                    return DrawerListTileWidget(
                      icon: handsSVG,
                      title: LocaleKeys.createCaptainAccount.tr(),
                      onTap: () {
                        routerPush(
                          context: context,
                          route: const CaptainRoute(),
                        ).then((value) {
                          zoomDrawerController.toggle!();
                        });
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),

              Selector<ProfileProvider, bool?>(
                selector: (context, provider) => provider.isStore,
                builder: (context, isStore, child) {
                  if (isStore == null || isStore == false) {
                    return DrawerListTileWidget(
                      icon: handsSVG,
                      title: LocaleKeys.bePartner.tr(),
                      onTap: () {
                        routerPush(
                          context: context,
                          route: const PartnerRoute(),
                        ).then((value) {
                          zoomDrawerController.toggle!();
                        });
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),

              DrawerListTileWidget(
                icon: settingSVG,
                title: LocaleKeys.setting.tr(),
                onTap: () {
                  routerPush(
                    context: context,
                    route: const SettingRoute(),
                  ).then((value) {
                    zoomDrawerController.toggle!();
                  });
                },
              ),

              DrawerListTileWidget(
                icon: const Icon(
                  FluentIcons.person_delete_16_regular,
                  size: 16,
                  color: Colors.white,
                ),
                title: LocaleKeys.deleteAccount.tr(),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return SmartAlertDialog(
                          title: "هل تريد حذف الحساب؟",
                          description:
                              "سيتم حذف الحساب وجميع البيانات المرتبطة به",
                          cancelPress: () {
                            // Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          cancelText: LocaleKeys.no.tr(),
                          confirmPress: () {
                            routerPop(context).whenComplete(
                              () => Provider.of<UserProvider>(context,
                                      listen: false)
                                  .deleteAccount(context: context),
                            );
                          },
                          confirmText: LocaleKeys.yes.tr(),
                        );
                      });

                  // onPressed: () =>
                },
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: provider.locale == 'en' ? 140 : 130,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Palette.primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                  onPressed: () {
                    routerPush(
                      context: context,
                      route: const CustomerServiceRoute(),
                    ).then((value) {
                      zoomDrawerController.toggle!();
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 15,
                        height: 15,
                        child: headsetSVG,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          LocaleKeys.technicalSupport.tr(),
                          style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget divider() => const Divider(
        thickness: 0.3,
        color: Palette.kWhite,
      );
}
