class PaymentCheckoutModel {
  double? amount;
  int? paymentTypeId;
  int? orderId;
  String? mode;
  String? mobile;
  String? methodType;

  PaymentCheckoutModel({
    required this.amount,
    this.paymentTypeId,
    this.orderId,
    required this.mode,
    required this.mobile,
    required this.methodType,
  });

  PaymentCheckoutModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    paymentTypeId = json['paymentTypeId'];
    orderId = json['orderId'];
    mode = json['mode'];
    mobile = json['mobile'];
    methodType = json['methodType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['paymentTypeId'] = paymentTypeId;
    data['orderId'] = orderId;
    data['mode'] = mode;
    data['mobile'] = mobile;
    data['methodType'] = methodType;
    return data;
  }
}
