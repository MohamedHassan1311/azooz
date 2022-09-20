import 'dart:collection';
import 'dart:io';

import 'package:azooz/app.dart';
import 'package:azooz/common/custom_waiting_dialog.dart';
import 'package:azooz/model/request/payment_checkout_model.dart';
import 'package:azooz/model/response/order_payment_types.dart';
import 'package:flutter/services.dart';
import 'package:hyperpay/hyperpay.dart';

import '../common/config/tools.dart';
import '../common/payment_consts.dart';
import '../model/error_model.dart';
import '../model/mixin/payment_mixin.dart';
import '../model/response/payment_status_model.dart';
import '../model/response/payments_model.dart';
import '../model/response/transaction_id_model.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import '../utils/dialogs.dart';
import '../utils/easy_loading_functions.dart';
import 'package:flutter/material.dart';

import '../utils/hyperpay_constant.dart';

class PaymentProvider extends ChangeNotifier with PaymentMixin {
  // Fields
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  late PaymentsModel _paymentsModel;
  late TransactionIdModel _transactionIdModel;
  late PaymentStatusModel _paymentStatusModel;
  late Future<OrderPaymentTypesModel?> _futureOrderPaymentTypes;
  List<CardDetails> _listPayment = [];
  OrderPaymentTypesModel? _orderPaymentTypesModel;
  PaymentTypes? _paymentTypes;
  TextEditingController _mobileController = TextEditingController();
  PaymentMethodsEnum? _initPaymentMethod;
  bool loadingPagination = false;
  bool endPage = false;
  Map paymentBody = {};
  late int _payRechargeId;
  String creditStatusResult = "";
  List<PaymentTypes>? listOrderPaymentTypes;

  // Getters
  int get payRechargeId => _payRechargeId;
  PaymentTypes? get orderPaymentType => _paymentTypes;
  TextEditingController get stcPayMobileNumber => _mobileController;
  OrderPaymentTypesModel? get orderPaymentTypesModel => _orderPaymentTypesModel;
  get futureOrderPaymentTypes => _futureOrderPaymentTypes;
  PaymentMethodsEnum? get currentPaymentMethod => _initPaymentMethod;

  // Setters
  set setPayRechargeId(int value) {
    _payRechargeId = value;
    notifyListeners();
  }

  set setFutureOrderPaymentTypes(Future<OrderPaymentTypesModel?> future) {
    _futureOrderPaymentTypes = future;
    notifyListeners();
  }

  set setStcPayMobileNumber(TextEditingController value) {
    _mobileController = value;
  }

  set setSelectedPaymentType(PaymentTypes paymentType) {
    _paymentTypes = paymentType;
    print("_paymentTypes: ${_paymentTypes.toString()}");
    notifyListeners();
  }

  set setPaymentMethod(PaymentMethodsEnum value) {
    _initPaymentMethod = value;
    notifyListeners();
  }

  @override
  Future<PaymentsModel> getData({
    required int? page,
    required BuildContext context,
  }) async {
    if (page != 1) {
      loadingPagination = true;
      notifyListeners();
    }

    if (_listPayment.isNotEmpty) {
      _listPayment.clear();
    }
    await _apiProvider
        .get(
          apiRoute: getPaymentsURL,
          queryParameters: {
            'Page': page,
          },
          successResponse: (response) {
            _paymentsModel = PaymentsModel.fromJson(response);
            if (_paymentsModel.result!.cards!.isNotEmpty) {
              _listPayment.addAll(
                LinkedHashSet<CardDetails>.from(_paymentsModel.result!.cards!)
                    .toList(),
              );
              _listPayment = Tools.removeDuplicates(_listPayment);

              notifyListeners();
            } else {
              endPage = true;
              notifyListeners();
            }
            loadingPagination = false;
            notifyListeners();
          },
          errorResponse: (response) {
            _errorModel = ErrorModel.fromJson(response);
            errorDialog(context, _errorModel.message);
            loadingPagination = false;
            notifyListeners();
          },
        )
        .then((value) => notifyListeners());

    return _paymentsModel;
  }

  @override
  Future<void> addData({
    required CardDetails paymentModel,
    required BuildContext context,
  }) async {
    circularDialog(context);
    await _apiProvider
        .post(
          apiRoute: addPaymentsURL,
          successResponse: (response) {
            dismissDialog(context);
            successDialogWithTimer(context);
            // dismissLoading().whenComplete(
            //   () => delayMilliseconds(
            //     250,
            //     () => showSuccess(
            //       durationMilliseconds: 850,
            //     ).whenComplete(() => routerPop(context)),
            //   ),
            // );
            notifyListeners();
          },
          errorResponse: (response) {
            _errorModel = ErrorModel.fromJson(response);
            errorDialog(context, _errorModel.message);
            notifyListeners();
          },
          data: paymentModel.toJsonCreate(),
        )
        .then((value) => notifyListeners());
  }

  @override
  Future<void> editData({
    required CardDetails cardDetails,
    required BuildContext context,
  }) async {
    circularDialog(context);
    await _apiProvider
        .put(
          apiRoute: editPaymentsURL,
          successResponse: (response) {
            dismissDialog(context);
            successDialogWithTimer(context)
                .then((value) => getData(page: 1, context: context));
            // dismissLoading().whenComplete(
            //   () => delayMilliseconds(
            //     250,
            //     () => showSuccess(
            //       durationMilliseconds: 850,
            //       // durationMilliseconds: 2000,
            //     ).whenComplete(
            //       () => routerPop(context).whenComplete(
            //         () {
            //           getData(page: 1, context: context);
            //         },
            //       ),
            //     ),
            //   ),
            // );
            notifyListeners();
          },
          errorResponse: (response) {
            _errorModel = ErrorModel.fromJson(response);
            errorDialog(context, _errorModel.message);
            notifyListeners();
          },
          data: cardDetails.toJsonEdit(),
        )
        .then((value) => notifyListeners());
  }

  @override
  Future<void> deleteData({
    required int? id,
    required BuildContext context,
  }) async {
    circularDialog(context);
    await _apiProvider.delete(
      apiRoute: deletePaymentsURL,
      successResponse: (response) {
        dismissDialog(context);
        successDialogWithTimer(context);
        // dismissLoading().whenComplete(
        //   () => delayMilliseconds(
        //     250,
        //     () => showSuccess(
        //       durationMilliseconds: 850,
        //     ),
        //   ),
        // );
        _listPayment.removeWhere((element) => element.id == id);
        _paymentsModel.result!.cards!.removeWhere(
          (element) => element.id == id,
        );
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        errorDialog(context, _errorModel.message);
        notifyListeners();
      },
      data: {
        'id': id,
      },
    ).then((value) => notifyListeners());
  }

  @override
  Future<void> paymentCash({
    required int? id,
    required BuildContext context,
  }) async {
    // circularDialog(context);
    paymentBody = {
      "orderId": id,
    };
    await _apiProvider.post(
      apiRoute: cashPaymentURL,
      successResponse: (response) {
        // dismissDialog(context);
        // successDialogWithTimer(context);
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        // dismissLoading();
        errorDialog(context, _errorModel.message);
        notifyListeners();
      },
      data: paymentBody,
    );
    notifyListeners();
  }

  @override
  Future<void> paymentWallet({
    required int? id,
    required int paymentTypeId,
    required BuildContext context,
  }) async {
    circularDialog(context);
    paymentBody = {
      "id": id,
      "paymentTypeId": paymentTypeId,
      // "paymentTypeId": OnPaymentProcessTypeIds.payAdsId
    };
    await _apiProvider.post(
      apiRoute: walletPaymentURL,
      successResponse: (response) {
        dismissDialog(context);
        successDialogWithTimer(context)
            .then((value) => getData(page: 1, context: context));
        notifyListeners();
      },
      errorResponse: (response) {
        dismissLoading();
        _errorModel = ErrorModel.fromJson(response);
        errorDialog(context, _errorModel.message);
        notifyListeners();
      },
      data: paymentBody,
    );
    notifyListeners();
  }

  PaymentsModel get paymentsModel => _paymentsModel;

  List<CardDetails>? get listPayment => _listPayment;

  @override
  Future<OrderPaymentTypesModel> getOrderPaymentTypes() async {
    _orderPaymentTypesModel = null;
    _paymentTypes = null;
    // notifyListeners();
    await _apiProvider.get(
      apiRoute: orderPaymentTypesURL,
      successResponse: (response) {
        _orderPaymentTypesModel = OrderPaymentTypesModel.fromJson(response);
        listOrderPaymentTypes = _orderPaymentTypesModel!.result!.paymenttypes;
        if (listOrderPaymentTypes != null) {
          listOrderPaymentTypes!.removeWhere(
            (element) => (Platform.isAndroid == true && element.id == 1014),
          );
          listOrderPaymentTypes!.toSet().toList();
        }
        // notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        errorDialog(getItContext!, _errorModel.message);
        // notifyListeners();
      },
    );
    notifyListeners();
    return _orderPaymentTypesModel!;
  }

  @override
  Future<TransactionIdModel> getCheckoutId({
    required PaymentCheckoutModel checkoutModel,
  }) async {
    logger.d("I am get checkout id:: ${checkoutModel.toJson()}^^^");
    await _apiProvider.post(
      apiRoute: checkoutURL,
      successResponse: (response) {
        _transactionIdModel = TransactionIdModel.fromJson(response);
        logger.d("Checkout id:: ${_transactionIdModel.result?.transactionId}");
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        errorDialog(getItContext!, _errorModel.message);
        notifyListeners();
      },
      data: checkoutModel.toJson(),
    );
    notifyListeners();
    return _transactionIdModel;
  }

  @override
  Future<PaymentStatusModel> getCreditStatus({required String transactionId}) async {
    print("I am from get credit status::!! : $transactionId");
    await _apiProvider.post(
      apiRoute: creditStatusURL,
      data: {"transactionId": transactionId},
      successResponse: (response) {
        _paymentStatusModel = PaymentStatusModel.fromJson(response);
        creditStatusResult = _paymentStatusModel.result!.message.toString();
        logger.d("Payment status:: ${_paymentStatusModel.result}");
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);

        creditStatusResult = _errorModel.message.toString();
        errorDialog(getItContext!, _errorModel.message);
        notifyListeners();
      },
    );

    notifyListeners();
    return _paymentStatusModel;
  }

  Future<bool> payWithMada(PaymentCheckoutModel checkoutRequest, CheckOutRequest payRequest) async {
    bool isSuccess = false;
    customWaitingDialog(getItContext!);
    var platform = const MethodChannel('Hyperpay.demo.fultter/channel');
    //TransactionIdModel checkoutid = await getCheckoutId(checkoutModel: checkoutRequest);

    print("##Checkout id::: ${payRequest.checkoutid.toString()}");

    String? transactionStatus;
    try {
      print("0000000000");
      print(payRequest.toMap());
      dismissDialog(getItContext!);
      final String result = await platform.invokeMethod('gethyperpayresponse',payRequest.toMap(),);

      print("11111111111");
      print("Transaction status: $transactionStatus");
      transactionStatus = result;
    } on PlatformException catch (e) {

      print("2222222222");
      dismissDialog(getItContext!);
      transactionStatus = "${e.message}";
    }

    print("3333333333");
    if (transactionStatus.isNotEmpty && transactionStatus == "success" ||
        transactionStatus == "SYNC") {
      await getCreditStatus(transactionId: payRequest.checkoutid!)
          .then((value) {
        if (value.result?.message == "Done" ||
            value.result?.message == "scuccess") {
          isSuccess = true;
          notifyListeners();
        } else {
          isSuccess = false;
          notifyListeners();
        }
      });
    } else {
      var resultText = transactionStatus;
      print("resultText $resultText");
      isSuccess = false;
      notifyListeners();
    }
    return isSuccess;
  }
  HyperpayPlugin? hyperpay;
  String sessionCheckoutID = '';
  Future<bool> payWithHyperPay(PaymentCheckoutModel checkoutRequest, CheckOutRequest payRequest,BrandType brandType )async{
    bool isDone = false;
    print("Start");
    hyperpay=await HyperpayPlugin.setup(config: TestConfig());
    CardInfo card = CardInfo(
      holder: payRequest.holderName.toString(),
      cardNumber: payRequest.cardNumber.toString(),
      cvv: payRequest.cvv.toString(),
      expiryMonth: payRequest.month.toString(),
      expiryYear:payRequest.year.toString(),
    );
print("Card Data"+ card.toMap().toString());

      try {
        // Start transaction
        if (sessionCheckoutID.isEmpty) {
          // Only get a new checkoutID if there is no previous session pending now

          await initPaymentSession(brandType, payRequest.amount!);
        }

        final result = await hyperpay!.pay(card);

        switch (result) {
          case PaymentStatus.init:
            print('Payment pending ⏳');
            break;
        // For the sake of the example, the 2 cases are shown explicitly
        // but in real world it's better to merge pending with successful
        // and delegate the job from there to the server, using webhooks
        // to get notified about the final status and do some action.
          case PaymentStatus.pending:
            print('Payment pending ⏳');

            break;
          case PaymentStatus.successful:
            sessionCheckoutID = '';
            print('Payment approved 🎉');
            isDone= true;
            notifyListeners();


            break;

          default:
        }
      } on HyperpayException catch (exception) {
        sessionCheckoutID = '';
        isDone= false;
        notifyListeners();

      } catch (exception) {
        print(exception);
      }

return isDone;

  }
  /// Initialize HyperPay session
  Future<void> initPaymentSession(
      BrandType brandType,
      double amount,
      ) async {
    CheckoutSettings _checkoutSettings = CheckoutSettings(
      brand: brandType,
      amount: amount,

      headers: {
        'Content-Type': 'application/json',
        "Authorization" : 'Bearer OGFjZGE0Yzk4MjYyYTAzZTAxODI3NDI0ZmRhYzVjNTd8Y1o3Y3llQVJXZQ=='
      },

    );

    hyperpay!.initSession(checkoutSetting: _checkoutSettings);
    sessionCheckoutID = await hyperpay!.getCheckoutID;
  }


  Future<bool> payWithMaster(PaymentCheckoutModel checkoutRequest, CheckOutRequest payRequest) async {

 return  await payWithHyperPay(checkoutRequest,payRequest,BrandType.mastercard);

  }

  Future<bool> payWithVisa(PaymentCheckoutModel checkoutRequest,CheckOutRequest payRequest,) async {
    late bool isSuccess;
    return  await payWithHyperPay(checkoutRequest,payRequest,BrandType.visa);

  }
  // PaymentCheckoutModel checkoutRequest,
  Future<bool> stcPayPayment(CheckOutRequest payRequest) async {
    bool isSuccess = false;
    var platform = const MethodChannel('Hyperpay.demo.fultter/channel');
    print("### Payment SDK Requsr for STCpay:  ${payRequest.toMap()}");
    //
    String? transactionStatus;

    try {
      print("Stape 1");
      notifyListeners();
      print("Stape 2");
      final String result = await platform.invokeMethod('gethyperpayresponse',payRequest.toMap(),);

      print("Stape 3");
      print("Payment result:: $result ##");

      print("Stape 4");
      transactionStatus = result;
    } on PlatformException catch (e) {
      transactionStatus = "${e.message}";

      print("Payment result:: $transactionStatus ##");
      print("Stape 5");
      notifyListeners();
      print("Stape 6");
    }

    if (transactionStatus.isNotEmpty ||
        transactionStatus == "success" ||
        transactionStatus == "SYNC") {
      //print("transactionStatus::transactionId ${checkoutid.result!.transactionId}");
      print("transactionStatus::stcPayPayment $transactionStatus");
      await getCreditStatus(transactionId: payRequest.checkoutid.toString()).then((value) {
        print("transactionStatus::stcPayPaymentvalue $value");
        if (value.result?.message == "Done" ||value.result?.message == "scuccess") {
          print("object::: ${value.result?.message}");
          isSuccess = true;
          notifyListeners();
        } else {
          isSuccess = false;
          notifyListeners();
        }
      }).catchError((error) {
        print("transactionStatus::stcPayPaymenterror $error");
        isSuccess = false;
        notifyListeners();
      });
    } else {
      var resultText = transactionStatus;
      print("resultText::stcPayPayment $resultText");
      isSuccess = false;
      notifyListeners();
    }
    isSuccess = false;
    notifyListeners();
    return isSuccess;
  }

  Future<bool> applePayPayment(PaymentCheckoutModel checkoutRequest, CheckOutRequest payRequest) async {
    bool isDone = false;
    if (sessionCheckoutID.isEmpty) {
      // Only get a new checkoutID if there is no previous session pending now
      await initPaymentSession(BrandType.applepay, payRequest.amount!);
    }

    final applePaySettings = ApplePaySettings(
      amount: payRequest.amount!,
      appleMerchantId: 'merchant.com.emaan.app',
      countryCode: 'SA',
      currencyCode: 'SAR',
    );

    try {
      await hyperpay!.payWithApplePay(applePaySettings);
    } catch (exception) {
      isDone= false;
      notifyListeners();
      print("Apple Pay exception:: $exception");
    } finally {
      isDone= false;
      notifyListeners();
    }
    print("Last done:: $isDone");
    return isDone;
  }

  clear() {
    _orderPaymentTypesModel = null;
    _paymentTypes = null;
  }
}

class CheckOutRequest {
  String? type;
  String? checkoutid;
  String? mode;
  String? brand;
  String? cardNumber;
  String? holderName;
  String? month;
  String? year;
  String? cvv;
  String? madaRegexV;
  String? madaRegexM;
  String? sTCPAY;
  double? amount;

  CheckOutRequest({
    this.type = "CustomUI",
    required this.checkoutid,
    this.mode = "LIVE",
    required this.brand,
    required this.cardNumber,
    required this.holderName,
    required this.month,
    required this.year,
    required this.cvv,
    required this.sTCPAY,
    required this.amount,
  });

  CheckOutRequest.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    checkoutid = json['checkoutid'];
    mode = json['mode'];
    brand = json['brand'];
    cardNumber = json['card_number'];
    holderName = json['holder_name'];
    month = json['month'];
    year = json['year'];
    cvv = json['cvv'];
    madaRegexV = MadaRegexV;
    madaRegexM = MadaRegexM;
    sTCPAY = json['STCPAY'];
    amount = json['amount'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['checkoutid'] = checkoutid;
    data['mode'] = mode;
    data['brand'] = brand;
    data['card_number'] = cardNumber;
    data['holder_name'] = holderName;
    data['month'] = month;
    data['year'] = year;
    data['cvv'] = cvv;
    data['MadaRegexV'] = MadaRegexV;
    data['MadaRegexM'] = MadaRegexM;
    data['STCPAY'] = sTCPAY;
    data['amount'] = amount;
    return data;
  }
}
