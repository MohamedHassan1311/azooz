import 'dart:async';
import 'dart:ui';

import 'package:azooz/common/style/images.dart';
import 'package:azooz/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../common/config/orders_types.dart';
import '../../../../common/style/colors.dart';
import '../../../../model/response/orders_types_model.dart';
import '../../../../providers/client_trips/delayed_trip_date_time_provider.dart';
import '../../../../providers/client_trips_provider.dart';
import '../../../../providers/orders_provider.dart';
import '../../../../utils/delay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'goods_transfer_trip.dart';
import 'personal_trip.dart';
import 'tax_trip.dart';

class DriverWidget extends StatefulWidget {
  const DriverWidget({Key? key}) : super(key: key);

  @override
  State<DriverWidget> createState() => _DriverWidgetState();
}

class _DriverWidgetState extends State<DriverWidget> {
  @override
  void initState() {
    super.initState();
    //
    Provider.of<ClientTripsProvider>(context, listen: false).getMarkerIcon(
      context: context,
      path: 'assets/images/azooz_drop.png',
      width: 65,
    );

    delayMilliseconds(1000, () {
      loadMap();
    });
  }

  Future<bool> loadMap() async {
    return Future.value(true);
  }

  final List<bool> _isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    const linearGradient = LinearGradient(
      colors: [
        Color(0xFFF1524C),
        Color(0xFFF1524C),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isSelected[0] = true;
                    _isSelected[1] = false;
                    _isSelected[2] = false;

                    context
                        .read<DelayedTripDateTimeProvider>()
                        .clearSelectedDateAndTime();
                    context.read<OrdersProvider>().setOrdersTypes(
                          OrdersTypesModel(
                            name: 'trip',
                            type: ClientOrdersTypes.trip,
                          ),
                        );
                    var currentTripType =
                        context.read<OrdersProvider>().getOrderType;
                    print("### Orders Types: $currentTripType ###");
                    setState(() {});
                  },
                  child: Container(
                    height: 70,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: _isSelected[0] == true
                          ? const Color.fromARGB(255, 239, 239, 239)
                          : Palette.primaryColor,
                      gradient: _isSelected[0] == true
                          ? linearGradient
                          : const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 244, 244, 244),
                                Color.fromARGB(255, 245, 245, 245),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: _isSelected[0] ? taxActive : taxInactive),
                        Text(
                          LocaleKeys.azoozTax.tr(),
                          style: TextStyle(
                            fontSize: 13,
                            color: _isSelected[0]
                                ? Colors.white
                                : const Color(0xFFF1574D),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _isSelected[0] = false;
                    _isSelected[1] = true;
                    _isSelected[2] = false;

                    context
                        .read<DelayedTripDateTimeProvider>()
                        .clearSelectedDateAndTime();
                    context.read<OrdersProvider>().setOrdersTypes(
                          OrdersTypesModel(
                            name: 'trip',
                            type: ClientOrdersTypes.trip,
                          ),
                        );
                    var currentTripType =
                        context.read<OrdersProvider>().getOrderType;
                    print("### Orders Types: $currentTripType ###");
                    setState(() {});
                  },
                  child: Container(
                    height: 70,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: _isSelected[1]
                          ? const Color.fromARGB(255, 239, 239, 239)
                          : Palette.primaryColor,
                      gradient: _isSelected[1]
                          ? linearGradient
                          : const LinearGradient(
                              colors: [
                                Palette.kSelectorColor,
                                Palette.kSelectorColor,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child:
                                _isSelected[1] ? riderActive : riderInactive),
                        Text(
                          LocaleKeys.azoozRide.tr(),
                          style: TextStyle(
                            fontSize: 13,
                            color: _isSelected[1]
                                ? Colors.white
                                : const Color(0xFFF1574D),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // _isSelected[0] = false;
                    // _isSelected[1] = false;
                    // _isSelected[2] = true;
                    // context.read<DelayedTripDateTimeProvider>().clearSelectedDateAndTime();
                    // context.read<OrdersProvider>().setOrdersTypes(
                    //       OrdersTypesModel(
                    //         name: 'goodsTransfer',
                    //         type: ClientOrdersTypes.goodsTransfer,
                    //       ),
                    //     );
                    // var currentTripType =context.read<OrdersProvider>().getOrderType;
                    //
                    // print("### Orders Types: $currentTripType ###");
                    // setState(() {});
                  },
                  child: Container(
                    height: 70,
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: _isSelected[2] == true
                          ? const Color.fromARGB(255, 239, 239, 239)
                          : Palette.primaryColor,
                      gradient: _isSelected[2]
                          ? linearGradient
                          : const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 244, 244, 244),
                                Color.fromARGB(255, 245, 245, 245),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Stack(
                      children: [

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child:
                                _isSelected[2] ? transInactive : transActive),
                            Text(
                              LocaleKeys.azoozTrans.tr(),
                              style: TextStyle(
                                fontSize: 13,
                                color: _isSelected[2]
                                    ? Colors.white
                                    : const Color(0xFFF1574D),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child:  Container(
                            child: soon,
                          ),
                        )

                      ],
                    )

                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (_isSelected[0]) const TaxTripWidget(),
                if (_isSelected[1]) const PersonalTripWidget(),
                if (_isSelected[2]) const GoodsTransferTripWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
