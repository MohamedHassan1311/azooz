import 'dart:developer';

import 'package:azooz/common/config/notification_types.dart';
import 'package:azooz/common/routes/app_router_import.gr.dart';
import 'package:provider/provider.dart';

import '../common/routes/app_router_control.dart';
import '../model/error_model.dart';
import '../model/mixin/offers_mixin.dart';
import '../model/response/offers_model.dart';
import '../utils/dialogs.dart';
import 'chat_provider.dart';
import 'orders_provider.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import 'package:flutter/material.dart';

class OffersProvider extends ChangeNotifier with OffersMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  DriverOffersModel? _offersModel;

  Future refresh(BuildContext context, int orderId) async {
    _offersModel = null;
    Future.delayed(const Duration(milliseconds: 300), () {
      getOffers(context: context, orderID: orderId, page: 1);
      notifyListeners();
    });
    notifyListeners();
  }

  @override
  Future<DriverOffersModel> getOffers({
    required BuildContext context,
    required int? orderID,
    required int? page,
  }) async {
    await _apiProvider.get(
      apiRoute: offersURL,
      queryParameters: {
        'OrderId': orderID,
        'page': page,
      },
      successResponse: (response) {
        _offersModel = DriverOffersModel.fromJson(response);
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        errorDialog(context, _errorModel.message);
        notifyListeners();
      },
    );
    notifyListeners();

    return _offersModel!;
  }

  @override
  Future<void> acceptOffer({
    required BuildContext context,
    required int offerID,
    required int orderID,
  }) async {
    circularDialog(context);
    Map body = {
      'offerId': offerID,
    };
    await _apiProvider.put(
      apiRoute: acceptOfferURL,
      successResponse: (response) {
        dismissDialog(context);
        successDialogWithTimer(context).then((value) {
          context
              .read<ChatProvider>()
              .getChat(orderID: orderID, context: context)
              .then((chatModel) {
            if (chatModel?.result != null) {
              context.read<OrdersProvider>().getCurrentOrders(
                  context: context, page: 1, isTripsOrders: false);
              routerReplace(
                context: context,
                route: ChatScreenRoute(
                  orderID: orderID,
                  chatID: chatModel?.result!.chat!.id,
                ),
              );
            }
          });
        });
        notifyListeners();
      },
      errorResponse: (response) {
        print("I am error from offers:: $response");
        _errorModel = ErrorModel.fromJson(response);
        errorDialog(context, _errorModel.message);
        notifyListeners();
      },
      data: body,
    );
    notifyListeners();
  }

  @override
  Future<void> rejectOffer(
      {required BuildContext context,
      required int? offerID,
      required DriverOffers item}) async {
    circularDialog(context);
    Map body = {
      'offerId': offerID,
    };
    await _apiProvider.put(
      apiRoute: rejectOfferURL,
      successResponse: (response) {
        dismissDialog(context);
        offersModel!.result!.offers!.remove(item);
        context.read<OrdersProvider>().refreshOrders(context: context, page: 1);
        Navigator.pop(context);
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        errorDialog(context, _errorModel.message);
        notifyListeners();
      },
      data: body,
    );
    notifyListeners();
  }

  DriverOffersModel? get offersModel => _offersModel;
  Future<void> setOffersModel(DriverOffersModel? value) async {
    _offersModel = value;
    // notifyListeners();
  }
}
