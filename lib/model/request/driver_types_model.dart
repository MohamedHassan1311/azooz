class DriverTypesModel {
  Result? result;
  String? message;

  DriverTypesModel({this.result, this.message});

  DriverTypesModel.fromJson(Map<String, dynamic> json) {
    result = Result.fromJson(json['result']);
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
  List<DriverTypes>? driverTypes;

  Result({this.driverTypes});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['driverTypes'] != null) {
      driverTypes = <DriverTypes>[];
      json['driverTypes'].forEach((v) {
        driverTypes!.add(DriverTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (driverTypes != null) {
      data['driverTypes'] = driverTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DriverTypes {
  int? id;
  String? name;

  DriverTypes({this.id, this.name});

  DriverTypes.fromJson(Map<String, dynamic> json) {
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
