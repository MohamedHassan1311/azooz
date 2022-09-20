import 'package:flutter/material.dart';

import '../response/offers_model.dart';

mixin OffersMixin {
  dynamic getOffers({
    required BuildContext context,
    required int? orderID,
    required int? page,
  });
  dynamic acceptOffer({
    required BuildContext context,
    required int offerID,
    required int orderID,
  });
  dynamic rejectOffer(
      {required BuildContext context,
      required int offerID,
      required DriverOffers item});
}
