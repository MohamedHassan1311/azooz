import 'package:azooz/service/network/url_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/style/colors.dart';
import '../../../../model/response/order_payment_types.dart';
import '../../../../providers/payment_provider.dart';
import '../../../../utils/smart_text_inputs.dart';
import '../../../custom_widget/custom_error_widget.dart';
import '../../../custom_widget/custom_loading_widget.dart';

class OrderPaymentTypeWidget extends StatefulWidget {
  const OrderPaymentTypeWidget({
    Key? key,
    this.isDelayedTrip = false,
    this.color = Palette.kSelectorColor,
  }) : super(key: key);

  final bool isDelayedTrip;
  final Color color;

  @override
  State<OrderPaymentTypeWidget> createState() => OrderPaymentTypeWidgetState();
}

class OrderPaymentTypeWidgetState extends State<OrderPaymentTypeWidget> {
  late Future<OrderPaymentTypesModel?> _futureOrderPaymentTypes;

  @override
  void initState() {
    _futureOrderPaymentTypes =
        context.read<PaymentProvider>().getOrderPaymentTypes();

    // if (widget.isDelayedTrip) {
    //   Future.delayed(const Duration(seconds: 1), () {
    //     context.read<PaymentProvider>().clear();
    //     _futureOrderPaymentTypes =
    //         context.read<PaymentProvider>().getOrderPaymentTypes();
    //     setState(() {});
    //   });
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<OrderPaymentTypesModel?>(
      future: _futureOrderPaymentTypes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // if (widget.isDelayedTrip) {
          //   listOrderPaymentTypes =
          //       snapshot.data!.result!.paymenttypes!.where((paymentType) {
          //     return paymentType.id != 1011 && Platform.isIOS == true
          //         ? paymentType.id != 1014
          //         : false;
          //   }).toList();
          // } else {
          //   listOrderPaymentTypes = snapshot.data!.result!.paymenttypes!;
          // }
          List<PaymentTypes>? paymentTypes =
              context.read<PaymentProvider>().listOrderPaymentTypes;
          return SmartDropDownField<PaymentTypes>(
            hasLabel: false,
            label: "",
            fillColor: widget.color,
            hint: Text(
              "طريقة السداد",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            items: paymentTypes!
                .map(
                  (e) {
                    return DropdownMenuItem<PaymentTypes>(
                      value: e,
                      child: Row(
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: baseImageURL + e.logo.toString(),
                              width: 30,
                              height: 30,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Text(
                            e.name.toString(),
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                        ],
                      ),
                    );
                  },
                )
                .toSet()
                .toList(),
            onChanged: (val) {
              context.read<PaymentProvider>().setSelectedPaymentType = val;
              print("Selected Order Payment Type:: ${val.name}");
              print("Selected Order Payment Type::ID ${val.id}");
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
