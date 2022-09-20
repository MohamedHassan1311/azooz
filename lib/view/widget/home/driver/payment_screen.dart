import 'package:azooz/common/routes/app_router_control.dart';
import 'package:azooz/common/routes/app_router_import.gr.dart';
import 'package:azooz/generated/locale_keys.g.dart';
import 'package:azooz/view/custom_widget/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../providers/delayed_client_trips_provider.dart';
import '../../../../providers/payment_provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    Key? key,
    required this.requiredAmount,
    required this.orderId,
  }) : super(key: key);

  final double requiredAmount;
  final int orderId;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text("دفع الرحلة المؤجلة"),
        titleTextStyle: const TextStyle(
          color: Colors.black54,
          fontSize: 18,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          const Text("تفاصيل الرحلة"),
          ...List.generate(
            1,
            (index) {
              return const CustomMeshwarCard();
            },
          ).toList(),
          Container(
            height: 3,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              // borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Color.fromARGB(35, 96, 125, 139),
              // gradient: LinearGradient(
              //   colors: [
              //     Color.fromARGB(190, 76, 175, 79),
              //     Color.fromARGB(190, 33, 150, 243),
              //   ],
              // ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('المبلغ المطلوب للدفع'),
              Text(
                widget.requiredAmount.toString(),
                style: const TextStyle(
                  fontSize: 28,
                  color: Color.fromARGB(255, 76, 175, 80),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.50,
            child: CustomButton(
              text: LocaleKeys.confirmPayment.tr(),
              onPressed: () {
                context
                    .read<PaymentProvider>()
                    .paymentCash(id: widget.orderId, context: context)
                    .then(
                  (value) {
                    routerPush(
                      context: context,
                      route: PaymentScreenRoute(
                        id: widget.orderId,
                        paymentTypeId: 1,
                        amount: widget.requiredAmount,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomMeshwarCard extends StatelessWidget {
  const CustomMeshwarCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightSize = 75.0;
    return Consumer<DelayedClientTripsProvider>(
      builder: (context, value, child) {
        final trip = value.tripDetails;
        return SizedBox(
          height: 120,
          child: Card(
            color: const Color.fromARGB(255, 240, 242, 242),
            elevation: 0.0,
            margin: const EdgeInsets.symmetric(vertical: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // first section
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      // DateFormat('dd/MM/yyyy')
                                      //     .format(trip.delayedTripDateTime),
                                      trip.delayedTripDateTime,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      trip.delayedTripDateTime,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(170, 0, 0, 0),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // const SizedBox(width: 10),
                              // second section
                              Expanded(
                                flex: 3,
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: 14,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        clipBehavior: Clip.none,
                                        children: [
                                          Container(
                                            width: 4.5,
                                            height: heightSize,
                                            decoration: const BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(50),
                                                bottom: Radius.circular(50),
                                              ),
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xFF664BD5),
                                                  Color(0xFF77B6FF),
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            child: Container(
                                              width: 9,
                                              height: 9,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xFF664BD5),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            child: Container(
                                              width: 9,
                                              height: 9,
                                              decoration: const BoxDecoration(
                                                // shape: BoxShape.circle,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(3)),
                                                color: Color(0xFF77B6FF),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // const SizedBox(width: 14),
                                    Expanded(
                                      flex: 5,
                                      child: SizedBox(
                                        height: heightSize,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              trip.fromLocationDetails,
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              trip.toLocationDetails,
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // third section

                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Text(
                                'رقم الرحلة',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Selector<DelayedClientTripsProvider, int>(
                                selector: (context, delayedTrip) {
                                  return delayedTrip.orderId;
                                },
                                builder: (context, value, widget) {
                                  if (value > 0) {
                                    return Text(
                                      value.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    );
                                  }
                                  return const Text("");
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // bottom section
                  // Flexible(
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 10.0,
                  //       vertical: 5.0,
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(
                  //           'مشوار (أشخاص)',
                  //           style: Theme.of(context).textTheme.subtitle1,
                  //         ),
                  //         Text(
                  //           'طريقة السداد: بالفيزا',
                  //           style: Theme.of(context).textTheme.subtitle1,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
