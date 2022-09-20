import 'dart:developer';

import 'package:azooz/model/response/orders_types_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart' as intl;
import '../../../../common/config/identity_types.dart';
import '../../../../common/config/orders_types.dart';
import '../../../../common/config/tools.dart';
import '../../../../common/routes/app_router_control.dart';
import '../../../../common/style/colors.dart';
import '../../../../common/style/dimens.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/request/add_client_trip_model.dart';
import '../../../../model/response/duration_model.dart';
import '../../../../model/response/gender_model.dart';
import '../../../../model/response/vehicle_type_model.dart';
import '../../../../providers/be_captain/car_category_provider.dart';
import '../../../../providers/client_trips_provider.dart';
import '../../../../providers/gender_provider.dart';
import '../../../../providers/orders_provider.dart';
import '../../../../providers/payment_provider.dart';
import '../../../../providers/setting_provider.dart';
import '../../../../utils/dialogs.dart';
import '../../../../utils/easy_loading_functions.dart';
import '../../../custom_widget/custom_button.dart';
import '../../../custom_widget/custom_cached_image_widget.dart';
import '../../../custom_widget/custom_error_widget.dart';
import '../../../custom_widget/custom_loading_widget.dart';
import '../../../custom_widget/marquee_widget.dart';
import 'package:easy_localization/easy_localization.dart' as easy_location;
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../screen/arrive_location_screen.dart';
import '../../../screen/home/navigation_manager.dart';
import '../../../screen/home/orders_history_screen.dart';
import '../../../screen/pick_up_location_screen.dart';

import 'dart:async';

import 'package:azooz/utils/smart_text_inputs.dart';
import 'package:azooz/view/screen/arrive_location_screen.dart';

import 'order_payment_type.dart';

class GoodsTransferTripWidget extends StatefulWidget {
  const GoodsTransferTripWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<GoodsTransferTripWidget> createState() =>
      _GoodsTransferTripWidgetState();
}

class _GoodsTransferTripWidgetState extends State<GoodsTransferTripWidget> {
  int selectedTypeId = 0;
  String selectedTypeName = '';
  late TextEditingController _userNoteController;

  late Future<DurationModel> futureDuration;
  late Future<VehicleTypeModel> futureVehicle;

  late ClientTripsProvider provider;
  bool isFavLabel = false;
  List<String> driverIdList = [];
  List<String> primaryListDriver = [];
  String driverId = '';
  List<bool> check = [];
  String coupon = '';

  late OrdersTypesModel selectedOrderType;

  late Future<GenderModel> futureGender;
  Widget CheckboxDriversList() => CheckboxListTile(
        title: const Text("@fghfgClick to see a list of your favorite drivers"),
        value: isFavLabel,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (value) {
          showDialog<void>(
            context: context,
            barrierDismissible: true,
            builder: (context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actionsPadding: EdgeInsets.zero,
              buttonPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.zero,
              titlePadding: edgeInsetsOnly(bottom: 15),
              contentPadding: edgeInsetsAll(10.0),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      check.clear();
                      driverIdList.clear();
                      primaryListDriver.clear();
                      routerPop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                  Center(
                    child: Text(
                      LocaleKeys.driverInfo.tr(),
                      style: const TextStyle(
                        color: Palette.secondaryLight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FutureBuilder(
                      future: Provider.of<ClientTripsProvider>(context,
                              listen: false)
                          .getFavDrivers(1204),
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? (snapshot.data as List).isNotEmpty
                                ? SizedBox(
                                    height: 300.0,
                                    width: 300.0,
                                    child: Consumer<ClientTripsProvider>(
                                      builder: (context, provider, child) {
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              provider.taxiDrivers.length,
                                          itemBuilder: (context, index) {
                                            log('index: $index');
                                            check.clear();
                                            driverIdList.clear();
                                            primaryListDriver.clear();
                                            
                                            check.add(false);
                                            return GestureDetector(
                                              onTap: () => setState(() {
                                                driverId =
                                                    '${provider.taxiDrivers[index]['id']}';
                                                setState(() {
                                                  isFavLabel = true;
                                                });
                                                if (check[index] == false) {
                                                  setState(() {
                                                    check[index] = true;
                                                  });
                                                  driverIdList.add(driverId);
                                                }
                                                // routerPop(context);
                                                log('driverId: $driverId');
                                                log('driverIdList: $driverIdList');
                                                log('check: $check');
                                              }),
                                              child: Row(
                                                children: [
                                                  sizedBox(
                                                    height: 55,
                                                    width: 55,
                                                    child:
                                                        CachedImageBorderRadius(
                                                      imageUrl:
                                                          provider.taxiDrivers[
                                                              index]['image'],
                                                      width: 55,
                                                    ),
                                                  ),
                                                  sizedBox(width: 30),
                                                  Expanded(
                                                      child: Text(
                                                          '${provider.taxiDrivers[index]['name']}')),
                                                  check[index] == true
                                                      ? const Icon(
                                                          Icons
                                                              .assignment_turned_in_rounded,
                                                          color: Colors.green,
                                                        )
                                                      : const SizedBox()
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  )
                                : const SizedBox(
                                    height: 300.0,
                                    width: 300.0,
                                    child: Center(
                                        child: Text('Your list is empty',
                                            style: TextStyle(
                                                color: Colors.black))),
                                  )
                            : SizedBox(
                                height: 300.0,
                                width: 300.0,
                                child: snapshot.hasError
                                    ? const CustomErrorWidget()
                                    : const CustomLoadingWidget());
                      }),
                  CustomButton(
                      text: 'Done',
                      onPressed: () {
                        primaryListDriver = driverIdList;
                        routerPop(context);
                      })
                ],
              ),
            ),
          );
        },
      );

  @override
  void didChangeDependencies() {
    Future.delayed(Duration.zero, () {
      if (mounted) {
        context.read<OrdersProvider>().setOrdersTypes(
              OrdersTypesModel(
                name: 'goodsTransfer',
                type: ClientOrdersTypes.goodsTransfer,
              ),
            );
      }
    });

    super.didChangeDependencies();
  }

  double size = 0;

  @override
  void initState() {
    super.initState();

    _userNoteController = TextEditingController();
    context.read<ClientTripsProvider>().disposeData();
    futureGender = Provider.of<GenderProvider>(context, listen: false)
        .getGenderData(context: context);
    provider = Provider.of<ClientTripsProvider>(context, listen: false);
    futureVehicle = Provider.of<SettingProvider>(context, listen: false)
        .getVehicleType(context: context)
        .then((value) {
      selectedTypeId = value.result!.vehicleType!.first.id!;
      selectedTypeName = value.result!.vehicleType!.first.name!;
      return Future.value(value);
    });
    var currentTripType = context.read<OrdersProvider>().getOrderType;
    print("###Goods Orders Types: $currentTripType ###");
  }

  checkCoupon() async {
    Tools.hideKeyboard(context);
    final providerOrder = Provider.of<OrdersProvider>(context, listen: false);
    if (provider.controller.text.isNotEmpty) {
      providerOrder
          .couponCheck(
            context: context,
            code: provider.controller.text.trim(),
          )
          .then(
            (value) => coupon = provider.controller.text.trim(),
          );
    } else {
      showInfo(msg: LocaleKeys.enterCoupon.tr());
    }
  }

  String formatsTime(DateTime? dateTime) {
    if (dateTime != null) {
      return intl.DateFormat('dd/MM/yyyy - hh:mm a').format(dateTime);
    } else {
      return intl.DateFormat('dd/MM/yyyy - hh:mm a').format(DateTime.now());
    }
  }

  Future<void> createNewGoodsTrip(BuildContext context) async {
    var currentTripType = context.read<OrdersProvider>().getOrderType;
    print("###!! Orders Types: $currentTripType ###");
    Tools.hideKeyboard(context);

    int? carCategoryId =
        context.read<CarCategoryProvider>().selectedCarCategory?.id;

    int? orderPaymentType =
        context.read<PaymentProvider>().orderPaymentType?.id;
    if (provider.markerTO != null &&
        provider.markerFROM != null &&
        _userNoteController.text.isNotEmpty &&
        orderPaymentType != null) {
      provider
          .postData(
        context: context,
        clientTripData: ClientTripModel(
            fromLat: provider.positionFROM.latitude,
            fromLng: provider.positionFROM.longitude,
            fromLocationDetails: provider.addressDetailsFROM,
            toLat: provider.positionTO.latitude,
            toLng: provider.positionTO.longitude,
            toLocationDetails: provider.addressDetailsTO,
            couponCode: coupon,
            orderType: context.read<OrdersProvider>().getOrderType.type,
            message: _userNoteController.text.trim(),
            carCategoryId: carCategoryId,
            requestType: RequestTypes.goodsTransId,
            genderId: context.read<GenderProvider>().selectedGenderId,
            paymentTypeId: orderPaymentType,
            driverIds: primaryListDriver,
            isFav: isFavLabel),
      )
          .then(
        (value) {
          coupon = '';
          _userNoteController.clear();
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            context.read<OrdersProvider>().setOrderHistoryType =
                OrderHistoryTypes.meshwar;
            context.read<OrdersProvider>().setForceToNavigateToMeshwar = true;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const NavigationManager(selectedIndex: 3),
              ),
            );
          });
        },
      );
    } else if (provider.markerTO != null &&
        provider.markerFROM != null &&
        _userNoteController.text.isEmpty) {
      errorDialog(context, "رجاءًا أكتب ملاحظة");
    } else {
      errorDialog(context, LocaleKeys.pleasePickUpLocations.tr());
    }
  }

  @override
  void dispose() {
    provider.disposeData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OrdersTypesModel currentOrderType =
        context.watch<OrdersProvider>().getOrderType;
    return SingleChildScrollView(
      // padding: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      // controller: scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(height: 14),
          Text(LocaleKeys.pickUpPoint.tr()),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: const BoxDecoration(
                    color: Palette.kSelectorColor,
                    borderRadius: kBorderRadius10,
                  ),
                  child: MarqueeWidget(
                    child: Consumer<ClientTripsProvider>(
                      builder: (context, provider, child) {
                        return Center(
                          child: Text(
                            provider.addressDetailsFROM.trim().isNotEmpty
                                ? provider.addressDetailsFROM
                                : LocaleKeys.address.tr(),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const PickUpLocationScreen();
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Palette.kGreen.withOpacity(0.1),
                      borderRadius: kBorderRadius10,
                    ),
                    child: Center(
                      child: Text(
                        LocaleKeys.location.tr(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          Consumer<ClientTripsProvider>(builder: (context, provider, child) {
            return provider.markerFROM != null &&
                    provider.positionFROM != const LatLng(0, 0)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(LocaleKeys.arrivePoint.tr()),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: const BoxDecoration(
                                color: Palette.kSelectorColor,
                                borderRadius: kBorderRadius10,
                              ),
                              child: MarqueeWidget(
                                child: Consumer<ClientTripsProvider>(
                                  builder: (context, provider, child) {
                                    return MarqueeWidget(
                                      child: Center(
                                        child: Text(
                                          provider.addressDetailsTO
                                                  .trim()
                                                  .isNotEmpty
                                              ? provider.addressDetailsTO
                                              : LocaleKeys.address.tr(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.push(context, MaterialPageRoute(
                                //   builder: (context) {
                                //     return const ArrivePointScreen();
                                //   },
                                // ));
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const ArriveLocationScreen();
                                }));
                              },
                              child: Container(
                                height: 50,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Palette.kGreen.withOpacity(0.1),
                                  borderRadius: kBorderRadius10,
                                ),
                                child: Center(
                                  child: Text(
                                    LocaleKeys.location.tr(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                    ],
                  )
                : const SizedBox();
          }),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Consumer<ClientTripsProvider>(
                  builder: (context, provider, child) {
                    return SmartInputTextField(
                      label: "",
                      hasLabel: false,
                      fillColor: Palette.kSelectorColor,
                      hintText: LocaleKeys.promoCode.tr(),
                      controller: provider.controller,
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 50,
                child: OutlinedButton(
                  onPressed: checkCoupon,
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 0)),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (_) => Palette.primaryColor),
                    shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                      (_) => RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      LocaleKeys.verify.tr(),
                      style: const TextStyle(
                        color: Palette.kWhite,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          const OrderPaymentTypeWidget(),
          Column(
            children: [
              const SizedBox(height: 10),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  LocaleKeys.note.tr(),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 5),
              SmartInputTextField(
                label: "",
                hasLabel: false,
                fillColor: Palette.kSelectorColor,
                controller: _userNoteController,
                maxLines: 3,
              ),
            ],
          ),
          sizedBox(height: 5),
         // CheckboxDriversList(),
          const SizedBox(height: 15),
          if (currentOrderType.type == ClientOrdersTypes.trip)
            CustomButton(
              text: LocaleKeys.confirm.tr(),
              onPressed: () => createNewGoodsTrip(context),
            ),

          Center(
            child: CustomButton(
              text: LocaleKeys.confirm.tr(),
              onPressed: () => createNewGoodsTrip(context),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
