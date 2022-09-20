class CalculatedDistanceResultModel {
  Result? result;
  String? message;

  CalculatedDistanceResultModel({this.result, this.message});

  CalculatedDistanceResultModel.fromJson(Map<String, dynamic> json) {
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
  bool? status;
  double? distance;

  Result({this.status, this.distance});

  Result.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['distance'] = distance;
    return data;
  }
}
