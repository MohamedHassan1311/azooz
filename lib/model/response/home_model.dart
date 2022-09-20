class HomeModel {
  Result? result;
  String? message;

  HomeModel({this.result, this.message});

  HomeModel.fromJson(Map<String, dynamic> json) {
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
  List<Adds>? adds;
  List<Departments>? departments;
  List<SmartDepartments>? smartDepartments;
  List<Advertisement>? advertisement;

  Result(
      {this.adds, this.departments, this.smartDepartments, this.advertisement});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['adds'] != null) {
      adds = <Adds>[];
      json['adds'].forEach((v) {
        adds!.add(Adds.fromJson(v));
      });
    }
    if (json['departments'] != null) {
      departments = <Departments>[];
      json['departments'].forEach((v) {
        departments!.add(Departments.fromJson(v));
      });
    }
    if (json['smartDepartments'] != null) {
      smartDepartments = <SmartDepartments>[];
      json['smartDepartments'].forEach((v) {
        smartDepartments!.add(SmartDepartments.fromJson(v));
      });
    }
    if (json['advertisement'] != null) {
      advertisement = <Advertisement>[];
      json['advertisement'].forEach((v) {
        advertisement!.add(Advertisement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (adds != null) {
      data['adds'] = adds!.map((v) => v.toJson()).toList();
    }
    if (departments != null) {
      data['departments'] = departments!.map((v) => v.toJson()).toList();
    }
    if (smartDepartments != null) {
      data['smartDepartments'] =
          smartDepartments!.map((v) => v.toJson()).toList();
    }
    if (advertisement != null) {
      data['advertisement'] = advertisement!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Adds {
  String? imageURl;

  Adds({this.imageURl});

  Adds.fromJson(Map<String, dynamic> json) {
    imageURl = json['imageURl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageURl'] = imageURl;
    return data;
  }
}

class Departments {
  int? id;
  String? name;
  String? imageURl;

  Departments({this.id, this.name, this.imageURl});

  Departments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageURl = json['imageURl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['imageURl'] = imageURl;
    return data;
  }
}

class SmartDepartments {
  int? id;
  String? name;
  List<Stores>? stores;

  SmartDepartments({this.id, this.name, this.stores});

  SmartDepartments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['stores'] != null) {
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores!.add(Stores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (stores != null) {
      data['stores'] = stores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stores {
  int? id;
  String? name;
  double? distance;
  double? time;
  double? rate;
  String? imageURl;
  List<String>? imageURls;
  bool? freeDelivery;
  List<StoreCatogorys>? storeCatogorys;
  List<StoreCatogory>? storeCatogory;

  Stores(
      {this.id,
      this.name,
      this.distance,
      this.time,
      this.rate,
      this.imageURl,
      this.imageURls,
      this.freeDelivery,
      this.storeCatogorys,
      this.storeCatogory});

  Stores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    distance = json['distance'];
    time = json['time'];
    rate = json['rate'];
    imageURl = json['imageURl'];
    imageURls = json['imageURls'].cast<String>();
    freeDelivery = json['freeDelivery'];
    if (json['storeCatogorys'] != null) {
      storeCatogorys = <StoreCatogorys>[];
      json['storeCatogorys'].forEach((v) {
        storeCatogorys!.add(StoreCatogorys.fromJson(v));
      });
    }
    if (json['storeCatogory'] != null) {
      storeCatogory = <StoreCatogory>[];
      json['storeCatogory'].forEach((v) {
        storeCatogory!.add(StoreCatogory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['distance'] = distance;
    data['time'] = time;
    data['rate'] = rate;
    data['imageURl'] = imageURl;
    data['imageURls'] = imageURls;
    data['freeDelivery'] = freeDelivery;
    if (storeCatogorys != null) {
      data['storeCatogorys'] = storeCatogorys!.map((v) => v.toJson()).toList();
    }
    if (storeCatogory != null) {
      data['storeCatogory'] = storeCatogory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoreCatogorys {
  String? name;
  List<Products>? products;

  StoreCatogorys({this.name, this.products});

  StoreCatogorys.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  double? price;
  String? title;
  String? description;
  int? calories;

  Products({this.id, this.price, this.title, this.description, this.calories});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    title = json['title'];
    description = json['description'];
    calories = json['calories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['title'] = title;
    data['description'] = description;
    data['calories'] = calories;
    return data;
  }
}

class StoreCatogory {
  String? name;

  StoreCatogory({this.name});

  StoreCatogory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class Advertisement {
  String? url;
  String? advertiseAddress;
  String? advertiseDetails;
  String? contactNumber;
  double? lat;
  double? lng;
  FavoriteLocation? favoriteLocation;

  Advertisement(
      {this.url,
      this.advertiseAddress,
      this.advertiseDetails,
      this.contactNumber,
      this.lat,
      this.lng,
      this.favoriteLocation});

  Advertisement.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    advertiseAddress = json['advertiseAddress'];
    advertiseDetails = json['advertiseDetails'];
    contactNumber = json['contactNumber'];
    lat = json['lat'];
    lng = json['lng'];
    favoriteLocation = json['favoriteLocation'] != null
        ? FavoriteLocation.fromJson(json['favoriteLocation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['advertiseAddress'] = advertiseAddress;
    data['advertiseDetails'] = advertiseDetails;
    data['contactNumber'] = contactNumber;
    data['lat'] = lat;
    data['lng'] = lng;
    if (favoriteLocation != null) {
      data['favoriteLocation'] = favoriteLocation!.toJson();
    }
    return data;
  }
}

class FavoriteLocation {
  int? id;
  String? title;
  String? details;
  double? lat;
  double? lng;

  FavoriteLocation({this.id, this.title, this.details, this.lat, this.lng});

  FavoriteLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    details = json['details'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['details'] = details;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
