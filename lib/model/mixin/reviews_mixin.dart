import 'package:flutter/material.dart';

mixin ReviewsMixin {
  Future<void> getData({
    required int? page,
    required BuildContext context,
  });

  Future<void> postData({
    required BuildContext context,
  });
}

class ReviewStoreModel {
  int? orderId;
  int? storeId;
  int? rate;
  int? toRateRuleId;
  String? comment;

  ReviewStoreModel(
      {this.orderId, this.storeId, this.rate, this.toRateRuleId, this.comment});

  ReviewStoreModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    storeId = json['storeId'];
    rate = json['rate'];
    toRateRuleId = json['toRateRuleId'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['storeId'] = storeId;
    data['rate'] = rate;
    data['toRateRuleId'] = toRateRuleId;
    data['comment'] = comment;
    return data;
  }
}
