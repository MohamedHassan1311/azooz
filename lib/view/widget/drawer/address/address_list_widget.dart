import 'package:azooz/common/custom_waiting_dialog.dart';
import 'package:azooz/utils/dialogs.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../common/config/tools.dart';
import '../../../../common/routes/app_router_control.dart';
import '../../../../common/routes/app_router_import.gr.dart';
import '../../../../common/style/colors.dart';
import '../../../../common/style/dimens.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/request/delete_address_model.dart';
import '../../../../model/response/address_model.dart';
import '../../../../model/screen_argument/address_argument.dart';
import '../../../../providers/address_provider.dart';
import '../../../../providers/advertisement_provider.dart';
import '../../../custom_widget/custom_button.dart';
import '../../../custom_widget/custom_error_widget.dart';
import '../../../custom_widget/custom_loading_widget.dart';
import '../../../custom_widget/marquee_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AddressListWidget extends StatefulWidget {
  final AddressArgument argument;

  const AddressListWidget({Key? key, required this.argument}) : super(key: key);

  @override
  State<AddressListWidget> createState() => _AddressListWidgetState();
}

class _AddressListWidgetState extends State<AddressListWidget> {
  late Future<AddressModel> future;
  int page = 1;

  late final AddressProvider provider;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    provider = Provider.of<AddressProvider>(context, listen: false);
    provider.filteredList!.clear();
    future = provider.getAddress(page: page, context: context);
    provider.getMarkerIcon(
      context: context,
      path: 'assets/images/azooz_drop.png',
      width: 65,
    );

    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    provider.disposeData();
    super.dispose();
  }

  scrollListener() => Tools.scrollListener(
        scrollController: scrollController,
        getMoreData: getMoreData,
      );

  submitDelete(int? id) async {
    Tools.hideKeyboard(context);
    await provider.deleteAddress(
      deleteAddressModel: DeleteAddressModel(id: id),
      context: context,
    );
  }

  getMoreData() {
    if (!provider.endPage) {
      if (provider.loadingPagination == false) {
        page++;
        provider.getAddress(page: page, context: context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    print(
        "widget.argument.isAddressSelector:: ${widget.argument.isAddressSelector}");
    return Consumer<AddressProvider>(builder: (context, provider, child) {
      return FutureBuilder<AddressModel>(
          future: future,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? provider.filteredList!.isEmpty
                    ? CustomErrorWidget(message: LocaleKeys.noAddress.tr())
                    : ListView.builder(
                        controller: scrollController,
                        itemCount: provider.filteredList!.length + 1,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        itemBuilder: (context, index) {
                          if (index == provider.filteredList!.length) {
                            return provider.loadingPagination
                                ? const CustomLoadingPaginationWidget()
                                : const SizedBox();
                          }
                          return Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Palette.kWhite,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFD9D9D9),
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              borderRadius: kBorderRadius10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.place_outlined,
                                            color: Palette.kErrorRed,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              sizedBox(
                                                width: screenSize.width * 0.59,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    sizedBox(width: 5),
                                                    Expanded(
                                                      child: MarqueeWidget(
                                                        child: Text(
                                                          provider
                                                              .filteredList![
                                                                  index]
                                                              .title!,
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
                                                    sizedBox(width: 5),
                                                  ],
                                                ),
                                              ),
                                              sizedBox(
                                                width: screenSize.width * 0.59,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    sizedBox(width: 5),
                                                    Expanded(
                                                      child: MarqueeWidget(
                                                        child: Text(
                                                          provider
                                                              .filteredList![
                                                                  index]
                                                              .details!,
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
                                                    sizedBox(width: 5),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Hide the edit icon
                                    if (widget.argument.isAddressSelector)
                                      RawMaterialButton(
                                        constraints: const BoxConstraints(
                                          maxWidth: 50,
                                          maxHeight: 50,
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        shape: const CircleBorder(),
                                        onPressed: () {
                                          final addressProvider =
                                              Provider.of<AddressProvider>(
                                                      context,
                                                      listen: false)
                                                  .filteredList![index];
                                          routerPush(
                                            context: context,
                                            route: AddAddressRoute(
                                              argument: AddressArgument(
                                                id: addressProvider.id,
                                                lat: addressProvider.lat,
                                                lng: addressProvider.lng,
                                                title: addressProvider.title,
                                                details:
                                                    addressProvider.details,
                                                newAddress: false,
                                                fromOrdersDetails: false,
                                                fromAdsScreen: false,
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Icon(
                                          Icons.edit,
                                          size: 18,
                                        ),
                                      ),
                                  ],
                                ),
                                sizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Show the edit button
                                    if (widget.argument.isAddressSelector ==
                                        false) ...[
                                      Expanded(
                                        child: CustomButton(
                                          text: LocaleKeys.editAddresses.tr(),
                                          onPressed: () {
                                            final addressProvider =
                                                Provider.of<AddressProvider>(
                                                        context,
                                                        listen: false)
                                                    .filteredList![index];
                                            routerPush(
                                              context: context,
                                              route: AddAddressRoute(
                                                argument: AddressArgument(
                                                  id: addressProvider.id,
                                                  lat: addressProvider.lat,
                                                  lng: addressProvider.lng,
                                                  title: addressProvider.title,
                                                  details:
                                                      addressProvider.details,
                                                  newAddress: false,
                                                  fromOrdersDetails: false,
                                                  fromAdsScreen: false,
                                                ),
                                              ),
                                            );
                                          },
                                          height: 40,
                                          color: Palette.primaryColor,
                                        ),
                                      ),
                                    ],

                                    // Hide the delete button
                                    if (widget.argument.isAddressSelector)
                                      Expanded(
                                        child: CustomButton(
                                          text: LocaleKeys.selectAddress.tr(),
                                          onPressed: () {
                                            if (widget.argument.fromAdsScreen) {
                                              print(
                                                  "## Address Id: ${provider.filteredList![index].id}");
                                              context
                                                  .read<AdvertisementProvider>()
                                                  .selectedAdsLocation(
                                                    favoriteLocationId: provider
                                                        .filteredList![index]
                                                        .id!,
                                                    name: provider
                                                        .filteredList![index]
                                                        .title!,
                                                    details: provider
                                                        .filteredList![index]
                                                        .details!,
                                                    latLng: LatLng(
                                                      provider
                                                          .filteredList![index]
                                                          .lat!,
                                                      provider
                                                          .filteredList![index]
                                                          .lng!,
                                                    ),
                                                  )
                                                  .then((value) {
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 500), () {
                                                  Navigator.pop(context);
                                                });
                                              });
                                            } else {
                                              provider
                                                  .selectedLocation(
                                                lng: provider
                                                    .filteredList![index].lng!,
                                                lat: provider
                                                    .filteredList![index].lat!,
                                                name: provider
                                                    .filteredList![index]
                                                    .title!,
                                              )
                                                  .then((value) {
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 500), () {
                                                  Navigator.pop(context);
                                                });
                                              });
                                            }
                                          },
                                          height: 40,
                                          color: Palette.primaryColor,
                                        ),
                                      ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: CustomButton(
                                        text: LocaleKeys.delete.tr(),
                                        textColor: Palette.primaryColor,
                                        color:
                                            const Color.fromARGB(20, 0, 0, 0),
                                        height: 40,
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return SmartAlertDialog(
                                                  title: "حذف العنوان",
                                                  description:
                                                      "هل تريد حذف هذا العنوان؟",
                                                  confirmPress: () {
                                                    submitDelete(
                                                      Provider.of<AddressProvider>(
                                                              context,
                                                              listen: false)
                                                          .filteredList![index]
                                                          .id,
                                                    );
                                                    dismissDialog(context);
                                                  },
                                                  cancelPress: () {
                                                    dismissDialog(context);
                                                  },
                                                  confirmText:
                                                      LocaleKeys.yes.tr(),
                                                  cancelText:
                                                      LocaleKeys.no.tr(),
                                                );
                                              });
                                          // alertDialogConfirmAddressDelete(
                                          //   context: context,
                                          //   onPressed: () =>
                                          //       submitDelete(
                                          //     Provider.of<AddressProvider>(
                                          //             context,
                                          //             listen: false)
                                          //         .filteredList![index]
                                          //         .id,
                                          //   ),
                                          // );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      )
                : snapshot.hasError
                    ? const CustomErrorWidget()
                    : const CustomLoadingWidget();
          });
    });
  }
}
