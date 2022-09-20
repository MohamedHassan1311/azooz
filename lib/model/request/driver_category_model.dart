class CarCategoryModel {
  Result? result;
  String? message;

  CarCategoryModel({this.result, this.message});

  CarCategoryModel.fromJson(Map<String, dynamic> json) {
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
  List<CarCategory>? carCategory;

  Result({this.carCategory});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['carCategory'] != null) {
      carCategory = <CarCategory>[];
      json['carCategory'].forEach((v) {
        carCategory!.add(CarCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (carCategory != null) {
      data['carCategory'] = carCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CarCategory {
  int? id;
  String? name;

  CarCategory({this.id, this.name});

  CarCategory.fromJson(Map<String, dynamic> json) {
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
