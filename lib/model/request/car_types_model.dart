class CarTypesModel {
  Result? result;
  String? message;

  CarTypesModel({this.result, this.message});

  CarTypesModel.fromJson(Map<String, dynamic> json) {
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
  List<CarTypes>? cartypes;

  Result({this.cartypes});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['cartypes'] != null) {
      cartypes = <CarTypes>[];
      json['cartypes'].forEach((v) {
        cartypes!.add(CarTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cartypes != null) {
      data['cartypes'] = cartypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CarTypes {
  String? id;
  String? name;

  CarTypes({this.id, this.name});

  CarTypes.fromJson(Map<String, dynamic> json) {
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
