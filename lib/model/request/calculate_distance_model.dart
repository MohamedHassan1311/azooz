class CalculateDistanceModel {
  final double fromLat;
  final double fromLng;

  final double toLat;
  final double toLng;

  CalculateDistanceModel({
    required this.fromLat,
    required this.fromLng,
    required this.toLat,
    required this.toLng,
  });
}

class DistanceError {
  int? code;
  String? message;
  List<Details>? details;

  DistanceError({this.code, this.message, this.details});

  DistanceError.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String? key;
  String? value;

  Details({this.key, this.value});

  Details.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}
