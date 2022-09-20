class IdentityTypesModel {
  Result? result;
  String? message;

  IdentityTypesModel({this.result, this.message});

  IdentityTypesModel.fromJson(Map<String, dynamic> json) {
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
  List<IdentityTypes>? identityTypes;

  Result({this.identityTypes});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['identityTypes'] != null) {
      identityTypes = <IdentityTypes>[];
      json['identityTypes'].forEach((v) {
        identityTypes!.add(IdentityTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (identityTypes != null) {
      data['identityTypes'] = identityTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IdentityTypes {
  String? id;
  String? name;

  IdentityTypes({this.id, this.name});

  IdentityTypes.fromJson(Map<String, dynamic> json) {
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
