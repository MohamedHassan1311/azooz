class OrderPaymentTypesModel {
  Result? result;
  String? message;

  OrderPaymentTypesModel({this.result, this.message});

  OrderPaymentTypesModel.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Result {
  List<PaymentTypes>? paymenttypes;

  Result({this.paymenttypes});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['paymenttypes'] != null) {
      paymenttypes = <PaymentTypes>[];
      json['paymenttypes'].forEach((v) {
        paymenttypes!.add(PaymentTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paymenttypes != null) {
      data['paymenttypes'] = paymenttypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentTypes {
  int? id;
  String? name;
  String? logo;

  PaymentTypes({this.id, this.name, this.logo});

  PaymentTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['logo'] = logo;
    return data;
  }
}
