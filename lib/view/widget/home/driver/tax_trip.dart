import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:azooz/common/config/notification_types.dart';
import 'package:azooz/common/routes/app_router_control.dart';
import 'package:azooz/common/routes/app_router_import.gr.dart';
import 'package:azooz/model/request/delayed_client_trip_model.dart';
import 'package:azooz/model/request/trip_price_calculate_model.dart';
import 'package:azooz/model/response/orders_types_model.dart';
import 'package:azooz/providers/client_trips/delayed_trip_date_time_provider.dart';
import 'package:azooz/providers/delayed_client_trips_provider.dart';
import 'package:azooz/utils/smart_text_inputs.dart';
import 'package:azooz/view/screen/arrive_location_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../common/config/genders.dart';
import '../../../../common/config/identity_types.dart';
import '../../../../common/config/orders_types.dart';
import '../../../../common/config/tools.dart';
import '../../../../common/payment_consts.dart';
import '../../../../common/style/colors.dart';
import '../../../../common/style/dimens.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/request/add_client_trip_model.dart';
import '../../../../model/request/payment_checkout_model.dart';
import '../../../../model/response/duration_model.dart';
import '../../../../model/response/gender_model.dart';
import '../../../../model/response/profile_model.dart';
import '../../../../model/response/vehicle_type_model.dart';
import '../../../../providers/be_captain/car_category_provider.dart';
import '../../../../providers/client_trips/trip_price_calculator_provider.dart';
import '../../../../providers/client_trips_provider.dart';
import '../../../../providers/gender_provider.dart';
import '../../../../providers/orders_provider.dart';
import '../../../../providers/payment_provider.dart';
import '../../../../providers/profile_provider.dart';
import '../../../../providers/setting_provider.dart';
import '../../../../utils/dialogs.dart';
import '../../../../utils/easy_loading_functions.dart';
import '../../../../utils/formate_date.dart';
import '../../../custom_widget/custom_button.dart';
import '../../../custom_widget/custom_cached_image_widget.dart';
import '../../../custom_widget/custom_error_widget.dart';
import '../../../custom_widget/custom_loading_widget.dart';
import '../../../custom_widget/marquee_widget.dart';
import 'package:easy_localization/easy_localization.dart' as easy_location;
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../screen/home/navigation_manager.dart';
import '../../../screen/home/orders_history_screen.dart';
import '../../../screen/payment/pay_with_apple_screen.dart';
import '../../../screen/payment/pay_with_cash_screen.dart';
import '../../../screen/payment/pay_with_mada_screen.dart';
import '../../../screen/payment/pay_with_master_screen.dart';
import '../../../screen/payment/pay_with_stcpay_screen.dart';
import '../../../screen/payment/pay_with_visa_screen.dart';
import '../../../screen/payment/pay_with_walett_screen.dart';
import '../../../screen/pick_up_location_screen.dart';
import 'car_brand_widget.dart';
import 'order_payment_type.dart';

class TaxTripWidget extends StatefulWidget {
  const TaxTripWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TaxTripWidget> createState() => _TaxTripWidgetState();
}

class _TaxTripWidgetState extends State<TaxTripWidget> {
  // String? _selectedDateAndTimeText;
  // DateTime? _selectedDateAndTime;
  int selectedTypeId = 0;
  String selectedTypeName = '';
  bool isFavLabel = false;
  List<String> driverIdList = [];
  List<String> primaryListDriver = [];
  String driverId = '';
  List<bool> check = [];
  late Future<DurationModel> futureDuration;
  late Future<VehicleTypeModel> futureVehicle;

  late ClientTripsProvider provider;
  late DelayedClientTripsProvider delayedProvider;

  String coupon = '';
  late int orderId;
  late OrdersTypesModel selectedOrderType;

  late Future<GenderModel> futureGender;

  late Future<ProfileModel> _futureProfileModel;

  @override
  void initState() {
    super.initState();
    context.read<ClientTripsProvider>().disposeData();
    context.read<DelayedTripDateTimeProvider>().clearSelectedDateAndTime();
    _futureProfileModel =
        context.read<ProfileProvider>().getData(context: context);

    Provider.of<DelayedTripDateTimeProvider>(context, listen: false)
        .clearSelectedDateAndTime();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<OrdersProvider>(context, listen: false).setOrdersTypes(
          OrdersTypesModel(name: 'trip', type: ClientOrdersTypes.trip));
    });
    futureGender = Provider.of<GenderProvider>(context, listen: false)
        .getGenderData(context: context);
    provider = Provider.of<ClientTripsProvider>(context, listen: false);

    delayedProvider =
        Provider.of<DelayedClientTripsProvider>(context, listen: false);
    futureVehicle = Provider.of<SettingProvider>(context, listen: false)
        .getVehicleType(context: context)
        .then((value) {
      selectedTypeId = value.result!.vehicleType!.first.id!;
      selectedTypeName = value.result!.vehicleType!.first.name!;
      return Future.value(value);
    });
    var currentTripType = context.read<OrdersProvider>().getOrderType;
    print("###Personal Orders Types: $currentTripType ###");
  }

  Widget CheckboxDriversList() => CheckboxListTile(
        title: const Text("Click to see a list of your favorite drivers"),
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
                      log('primaryListDriver: $primaryListDriver');
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
                          .getFavDrivers(1202),
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
  void payOrderMeshwar(PaymentCheckoutModel paymentCheckoutModel) async {
    print("## Current Payment method:: ${paymentCheckoutModel.methodType} ##");
    switch (paymentCheckoutModel.methodType!.toUpperCase()) {
      case "VISA":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PayWithVisaScreen(
              paymentCheckoutModel: paymentCheckoutModel,
            ),
          ),
        );
        break;
      case "MASTER":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PayWithMasterScreen(
              paymentCheckoutModel: paymentCheckoutModel,
            ),
          ),
        );
        break;

      case "STCPAY":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PayWithSTCPayScreen(
              paymentCheckoutModel: paymentCheckoutModel,
            ),
          ),
        );
        break;

      case "APPLEPAY":
        if (Platform.isIOS) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PayWithApplePayScreen(
                paymentCheckoutModel: paymentCheckoutModel,
              ),
            ),
          );
        }
        break;

      case "MADA":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PayWithMadaScreen(
              paymentCheckoutModel: paymentCheckoutModel,
            ),
          ),
        );
        break;
      case "WALLET":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PayWithWalletScreen(
              paymentCheckoutModel: paymentCheckoutModel,
            ),
          ),
        );
        break;

      case "CASH":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PayWithCashScreen(
              paymentCheckoutModel: paymentCheckoutModel,
            ),
          ),
        );
    }
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

  Future<void> createTaxTrip(BuildContext context) async {
    var currentTripType = context.read<OrdersProvider>().getOrderType;
    late BuildContext dialogContext;
    log('currentTripType: $currentTripType');
    log('currentTripType: ${currentTripType.type}');
    if (currentTripType.type == ClientOrdersTypes.delayedTrip) {
      showDialog(
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          dialogContext = context;
          return const CustomLoadingWidget();
        },
      );
    }
    print("### Orders Types: $currentTripType ###");
    Tools.hideKeyboard(context);

    final genderId = context.read<GenderProvider>().selectedGenderId;
    int? carCategoryId =
        context.read<CarCategoryProvider>().selectedCarCategory?.id;

    final orderPaymentType = context.read<PaymentProvider>().orderPaymentType;

    if (currentTripType.type == ClientOrdersTypes.delayedTrip) {
      if (provider.markerTO != null &&
          provider.markerFROM != null &&
          carCategoryId != null &&
          orderPaymentType != null) {
        print('### Tax Trip - Delayed:  ###');
        await delayedProvider
            .postData(
          context: context,
          delayedClientTripModel: DelayedClientTripModel(
              fromLat: provider.positionFROM.latitude,
              fromLng: provider.positionFROM.longitude,
              fromLocationDetails: provider.addressDetailsFROM,
              toLat: provider.positionTO.latitude,
              toLng: provider.positionTO.longitude,
              toLocationDetails: provider.addressDetailsTO,
              couponCode: coupon,
              orderType: ClientOrdersTypes.delayedTrip,
              message: "",
              genderId: genderId,
              delayedTripDateTime: context
                  .read<DelayedTripDateTimeProvider>()
                  .getSelectedDateTime
                  .toString(),
              carCategoryId: carCategoryId,
              requestType: RequestTypes.taxId,
              paymentTypeId: orderPaymentType.id,
              driverIds: primaryListDriver,
              isFav: isFavLabel),
        )
            .then(
          (value) {
            Navigator.of(dialogContext).pop();
            orderId = context.read<DelayedClientTripsProvider>().orderId;
            coupon = '';

            print('### Tax Trip - Delayed: -then  ###');

            String methodType = paymentMethodTypes
                .where((element) =>
                    element["id"].toString().trim() ==
                    orderPaymentType.id.toString().trim())
                .first["name"];
            PaymentCheckoutModel paymentCheckoutData = PaymentCheckoutModel(
              amount:
                  context.read<DelayedClientTripsProvider>().requiredTotalPrice,
              paymentTypeId: PayRechargeIds.payTripOrderId,
              mode: "",
              mobile: "",
              methodType: methodType,
              orderId: orderId,
            );

            payOrderMeshwar(paymentCheckoutData);
          },
        );
      } else if (provider.markerTO != null &&
          provider.markerFROM != null &&
          carCategoryId == null) {
        errorDialog(context, "يجب عليك إختيار الفئة");
      } else if (provider.markerTO != null &&
          provider.markerFROM != null &&
          carCategoryId != null &&
          orderPaymentType == null) {
        errorDialog(context, "يجب عليك إختيار طريقة الدفع");
      } else {
        errorDialog(context, LocaleKeys.pleasePickUpLocations.tr());
      }
    } else {
      if (provider.markerTO != null &&
          provider.markerFROM != null &&
          carCategoryId != null &&
          orderPaymentType != null) {
        print("## I am car category - tax trip:: $carCategoryId ##");
        print("## I am payment id - tax trip:: ${orderPaymentType.id} ##");
        print(
            "## provider.positionFROM.latitude:: ${provider.positionFROM.latitude} ##");
        print(
            "## provider.positionFROM.longitude:: ${provider.positionFROM.longitude} ##");
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
              message: "",
              genderId: context.read<GenderProvider>().selectedGenderId,
              carCategoryId: carCategoryId,
              requestType: RequestTypes.taxId,
              paymentTypeId: orderPaymentType.id,
              driverIds: primaryListDriver,
              isFav: isFavLabel),
        )
            .then(
          (value) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              context.read<OrdersProvider>().setOrderHistoryType =
                  OrderHistoryTypes.meshwar;
              context.read<OrdersProvider>().setForceToNavigateToMeshwar = true;
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) => const NavigationManager(selectedIndex: 3),
              //   ),
              // );
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (_) {
              //     return const NavigationManager(selectedIndex: 3);
              //   }),
              // );

              routerPushAndPopUntil(
                  context: context,
                  route: NavigationManagerRoute(selectedIndex: 3));
            });
            coupon = '';
          },
        );
      } else if (provider.markerTO == null || provider.markerFROM == null) {
        errorDialog(context, LocaleKeys.pleasePickUpLocations.tr());
      } else {
        errorDialog(context, LocaleKeys.pleaseInputFillAllFields.tr());
      }
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

          Consumer<ClientTripsProvider>(
            builder: (context, providerMap, child) {
              if (providerMap.markerTO != null &&
                  providerMap.markerFROM != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text("رحلة مؤجلة؟"),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .read<DelayedTripDateTimeProvider>()
                                  .openDateTimePicker(context)
                                  .then((isDateTimePicked) {
                                print(
                                    "Select Date and time for tax:: $isDateTimePicked ##end");
                                if (isDateTimePicked != null) {
                                  context.read<OrdersProvider>().setOrdersTypes(
                                        OrdersTypesModel(
                                            name: 'delayedTrip',
                                            type:
                                                ClientOrdersTypes.delayedTrip),
                                      );

                                  // context
                                  //     .read<PaymentProvider>()
                                  //     .getOrderPaymentTypes();

                                  context
                                      .read<TripPriceCalculatorProvider>()
                                      .setTripLocationDetails(
                                        context: context,
                                        tripPriceCalculate:
                                            TripPriceCalculateModel(
                                          fromLat:
                                              provider.positionFROM.latitude,
                                          fromLng:
                                              provider.positionFROM.longitude,
                                          toLat: provider.positionTO.latitude,
                                          toLng: provider.positionTO.longitude,
                                        ),
                                      );
                                  context
                                      .read<TripPriceCalculatorProvider>()
                                      .getPrice(
                                        context: context,
                                      );
                                } else {
                                  context.read<OrdersProvider>().setOrdersTypes(
                                        OrdersTypesModel(
                                          name: 'trip',
                                          type: ClientOrdersTypes.trip,
                                        ),
                                      );
                                  // context
                                  //         .read<PaymentProvider>()
                                  //         .setFutureOrderPaymentTypes =
                                  //     context
                                  //         .read<PaymentProvider>()
                                  //         .getOrderPaymentTypes();
                                }
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Palette.kSelectorColor,
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.timelapse_outlined,
                                        size: 17),
                                    const SizedBox(width: 3),
                                    Text(
                                      "حدد توقيت الرحلة",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        ...[
                          const SizedBox(width: 10),
                          Consumer<DelayedTripDateTimeProvider>(
                            builder: (context, provider, child) {
                              if (provider.selectedDateAndTime != null) {
                                return Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Palette.kGreen.withOpacity(0.1),
                                  ),
                                  child: Text(
                                    formatsTime(provider.selectedDateAndTime),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                          fontWeight: FontWeight.normal,
                                          color: Palette.kBlack,
                                        ),
                                  ),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 5),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),

          FutureBuilder<ProfileModel>(
              future: _futureProfileModel,
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? const CustomLoadingWidget()
                    : Selector<ProfileProvider, int>(
                        selector: (context, profileGender) =>
                            profileGender.getUserId!.genderID!,
                        builder: (BuildContext context, currentGender,
                            Widget? child) {
                          if (currentGender == genderFemale) {
                            {
                              return Column(
                                children: [
                                  sizedBox(height: 5),
                                  FutureBuilder<GenderModel>(
                                    future: futureGender,
                                    builder: (context, snapshot) => snapshot
                                            .hasData
                                        ? Consumer<GenderProvider>(
                                            builder:
                                                (context, provider, child) {
                                              return SmartDropDownField<
                                                  UserGender>(
                                                hasLabel: false,
                                                label: "",
                                                fillColor:
                                                    Palette.kSelectorColor,
                                                items: Provider.of<
                                                            GenderProvider>(
                                                        context,
                                                        listen: false)
                                                    .genderModel
                                                    .result!
                                                    .genders!
                                                    .map<
                                                            DropdownMenuItem<
                                                                UserGender>>(
                                                        (UserGender gender) {
                                                  return DropdownMenuItem<
                                                      UserGender>(
                                                    value: gender,
                                                    child: Text(
                                                      gender.name!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle2!
                                                          .copyWith(
                                                            color: Colors.black,
                                                          ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  if (newValue != null) {
                                                    context
                                                        .read<GenderProvider>()
                                                        .setGenderData(
                                                          context: context,
                                                          gender: newValue,
                                                        );
                                                  }

                                                  int gender = context
                                                          .read<
                                                              GenderProvider>()
                                                          .selectedGenderId ??
                                                      1;
                                                  print(
                                                      "## Meshwar gender:: $gender end");
                                                },
                                                hint: Text(
                                                  LocaleKeys.type.tr(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2,
                                                ),
                                              );
                                            },
                                          )
                                        : snapshot.hasError
                                            ? const CustomErrorWidget()
                                            : const CustomLoadingWidget(
                                                size: 30,
                                                paddingAll: 10,
                                              ),
                                  ),
                                ],
                              );
                            }
                          }
                          return const SizedBox();
                        },
                      );
              }),

          const SizedBox(height: 10),

          const CarBrandWidget(),
          const SizedBox(height: 10),
          // if (currentOrderType.type != ClientOrdersTypes.delayedTrip)
          OrderPaymentTypeWidget(
            isDelayedTrip:
                currentOrderType.type == ClientOrdersTypes.delayedTrip
                    ? true
                    : false,
          ),
          const SizedBox(height: 15),
          if (currentOrderType.type == ClientOrdersTypes.trip) ...[
            /** Checkbox Widget **/
            //CheckboxDriversList(),
            // const SizedBox(height: 10),
            CustomButton(
              width: MediaQuery.of(context).size.width * 0.94,
              text: LocaleKeys.confirm.tr(),
              onPressed: () => createTaxTrip(context),
            )
          ],

          if (currentOrderType.type == ClientOrdersTypes.delayedTrip) ...[
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                SizedBox(
                    height: 50,
                    child: Center(child: Text("سعر الرحلة المؤجلة"))),
                SizedBox(
                  height: 50,
                  child: GetDelayedTripPrice(),
                ),

                // SizedBox(
                //   height: 50,
                //   child: Consumer<TripPriceCalculatorProvider>(
                //       builder: (context, provider, child) {
                //     if (provider.tripPriceCalculateModel != null &&
                //         provider.tripPrice >= 0) {
                //       return Text(
                //         provider.tripPrice.toString(),
                //         style: Theme.of(context).textTheme.subtitle1,
                //       );
                //     } else {
                //       return const Center(
                //         child: SizedBox(
                //           width: 23,
                //           height: 23,
                //           child: Center(
                //             child: CircularProgressIndicator(
                //               strokeWidth: 2.0,
                //               valueColor:
                //                   AlwaysStoppedAnimation(Palette.primaryColor),
                //             ),
                //           ),
                //         ),
                //       );
                //     }
                //   }),
                // ),
              ],
            ),
            // const SizedBox(height: 10),
            //CheckboxDriversList(),
            Center(
              child: CustomButton(
                text: LocaleKeys.confirm.tr(),
                onPressed: () => createTaxTrip(context),
                width: MediaQuery.of(context).size.width * 0.94,
              ),
            ),
          ],

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class GetDelayedTripPrice extends StatelessWidget {
  const GetDelayedTripPrice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TripPriceCalculatorProvider>(
        builder: (context, provider, child) {
      if (provider.tripPriceCalculateModel != null && provider.tripPrice >= 0) {
        return Center(
          child: Text(
            provider.tripPrice.toString(),
            style: Theme.of(context).textTheme.subtitle1,
          ),
        );
      } else {
        return const Center(
          child: SizedBox(
            width: 23,
            height: 23,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation(Palette.primaryColor),
              ),
            ),
          ),
        );
      }
    });
  }
}
