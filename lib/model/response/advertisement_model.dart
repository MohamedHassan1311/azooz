class AdvertisementModel {
  Result? result;
  String? message;

  AdvertisementModel({this.result, this.message});

  AdvertisementModel.fromJson(Map<String, dynamic> json) {
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
  List<Advertisement>? advertisement;

  Result({this.advertisement});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['advertisement'] != null) {
      advertisement = <Advertisement>[];
      json['advertisement'].forEach((v) {
        advertisement!.add(Advertisement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (advertisement != null) {
      data['advertisement'] = advertisement!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Advertisement {
  int? id;
  String? advertiseAddress;
  String? advertiseDetails;
  int? contactBy;
  String? contactNumber;
  String? from;
  String? to;
  double? price;
  String? image;
  bool? valid;
  bool? payed;
  FavoriteLocation? favoriteLocation;

  Advertisement(
      {this.id,
      this.advertiseAddress,
      this.advertiseDetails,
      this.contactBy,
      this.contactNumber,
      this.from,
      this.to,
      this.price,
      this.image,
      this.valid,
      this.payed,
      this.favoriteLocation});

  Advertisement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advertiseAddress = json['advertiseAddress'];
    advertiseDetails = json['advertiseDetails'];
    contactBy = json['contactBy'];
    contactNumber = json['contactNumber'];
    from = json['from'];
    to = json['to'];
    price = json['price'];
    image = json['image'];
    valid = json['valid'];
    payed = json['payed'];
    favoriteLocation = json['favoriteLocation'] != null
        ? FavoriteLocation.fromJson(json['favoriteLocation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['advertiseAddress'] = advertiseAddress;
    data['advertiseDetails'] = advertiseDetails;
    data['contactBy'] = contactBy;
    data['contactNumber'] = contactNumber;
    data['from'] = from;
    data['to'] = to;
    data['price'] = price;
    data['image'] = image;
    data['valid'] = valid;
    data['payed'] = payed;
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



// @immutable
// @JsonSerializable(ignoreUnannotated: false)
// class AdvertisementModel extends Equatable {
//   @JsonKey(name: 'result')
//   final Result? result;
//   @JsonKey(name: 'message')
//   final String? message;

//   const AdvertisementModel({
//     required this.result,
//     required this.message,
//   });

//   factory AdvertisementModel.fromJson(Map<String, dynamic> json) =>
//       _$AdvertisementModelFromJson(json);

//   Map<String, dynamic> toJson() => _$AdvertisementModelToJson(this);

//   @override
//   List<Object?> get props => [result, message];
// }

// @immutable
// @JsonSerializable(ignoreUnannotated: false)
// class Result extends Equatable {
//   @JsonKey(name: 'advertisement')
//   final List<Advertisement>? advertisement;

//   const Result({
//     required this.advertisement,
//   });

//   factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

//   Map<String, dynamic> toJson() => _$ResultToJson(this);

//   @override
//   List<Object?> get props => [advertisement];
// }

// @immutable
// @JsonSerializable(ignoreUnannotated: false)
// class Advertisement extends Equatable {
//   @JsonKey(name: 'id')
//   final int? id;
//   @JsonKey(name: 'advertiseAddress')
//   final String? advertiseAddress;
//   @JsonKey(name: 'advertiseDetails')
//   final String? advertiseDetails;
//   @JsonKey(name: 'contactBy')
//   final int? contactBy;
//   @JsonKey(name: 'contactNumber')
//   final String? contactNumber;
//   @JsonKey(name: 'lat')
//   final double? lat;
//   @JsonKey(name: 'lng')
//   final double? lng;
//   @JsonKey(name: 'price')
//   final double? price;
//   @JsonKey(name: 'whatsappNumber')
//   final String? whatsappNumber;
//   @JsonKey(name: 'image')
//   final String? image;
//   @JsonKey(name: 'vehicle')
//   final String? vehicle;

//   const Advertisement({
//     required this.id,
//     required this.advertiseAddress,
//     required this.advertiseDetails,
//     required this.contactBy,
//     required this.contactNumber,
//     required this.lat,
//     required this.lng,
//     required this.price,
//     required this.whatsappNumber,
//     required this.image,
//     required this.vehicle,
//   });

//   factory Advertisement.fromJson(Map<String, dynamic> json) =>
//       _$AdvertisementFromJson(json);

//   Map<String, dynamic> toJson() => _$AdvertisementToJson(this);

//   @override
//   List<Object?> get props => [
//         id,
//         advertiseAddress,
//         advertiseDetails,
//         contactBy,
//         contactNumber,
//         lat,
//         lng,
//         price,
//         whatsappNumber,
//         vehicle,
//         image,
//       ];
// }
