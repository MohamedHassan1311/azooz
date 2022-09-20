class TransactionIdModel {
  Result? result;
  String? message;

  TransactionIdModel({this.result, this.message});

  TransactionIdModel.fromJson(Map<String, dynamic> json) {
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
  String? transactionId;

  Result({this.transactionId});

  Result.fromJson(Map<String, dynamic> json) {
    transactionId = json['transactionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transactionId'] = transactionId;
    return data;
  }
}
