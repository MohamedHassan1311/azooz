class CarsKindModel {
  Result? result;
  String? message;

  CarsKindModel({this.result, this.message});

  CarsKindModel.fromJson(Map<String, dynamic> json) {
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
  List<CarsKind>? carsKind;

  Result({this.carsKind});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['carsKind'] != null) {
      carsKind = <CarsKind>[];
      json['carsKind'].forEach((v) {
        carsKind!.add(CarsKind.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (carsKind != null) {
      data['carsKind'] = carsKind!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CarsKind {
  int? id;
  String? name;

  CarsKind({this.id, this.name});

  CarsKind.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
