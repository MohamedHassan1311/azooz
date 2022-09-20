import 'package:azooz/model/request/payment_checkout_model.dart';
import 'package:azooz/model/response/order_payment_types.dart';

import '../response/payment_status_model.dart';
import '../response/payments_model.dart';
import 'package:flutter/material.dart';

import '../response/transaction_id_model.dart';

mixin PaymentMixin {
  Future<PaymentsModel> getData({
    required int? page,
    required BuildContext context,
  });

  Future<OrderPaymentTypesModel> getOrderPaymentTypes();

  Future<void> addData({
    required CardDetails paymentModel,
    required BuildContext context,
  });

  Future<void> editData({
    required CardDetails cardDetails,
    required BuildContext context,
  });

  Future<void> deleteData({
    required int? id,
    required BuildContext context,
  });

  Future<void> paymentCash({
    required int? id,
    required BuildContext context,
  });

  Future<void> paymentWallet({
    required int? id,
    required int paymentTypeId,
    required BuildContext context,
  });

  Future<TransactionIdModel> getCheckoutId({
    required PaymentCheckoutModel checkoutModel,
  });

  Future<PaymentStatusModel> getCreditStatus({
    required String transactionId,
  });
}
