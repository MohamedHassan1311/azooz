import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../app.dart';
import '../model/error_model.dart';
import '../model/mixin/be_partner_mixin.dart';
import '../model/response/banks_model.dart';
import '../model/response/city_model.dart';
import '../model/response/departments_model.dart';
import '../model/response/region_model.dart';
import '../utils/dialogs.dart';
import '../view/screen/maps/get_location_api.dart';
import 'city_region_provider.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BePartnerProvider extends ChangeNotifier with BePartnerMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  FormData? _body;
  AllDepartments? selectedDepartment;
  Cities? selectedCity;
  AllBanks? selectedBank;
  int? cityID = 0;
  int? bankID = 0;
  Region? selectedRegion;
  bool? isRegionSelected = false;
  String selectedName = '';
  String selectedAddressName = '';

  LatLng? storeLocationPosition;
  late Future<CityModel> futureCity;
  late BuildContext context;

  @override
  regionSelect(newValue) {
    selectedRegion = newValue;
    print(
        'Selected Region Name: ${selectedRegion!.name} - ID: ${selectedRegion!.id}');
    isRegionSelected = true;
    futureCity =
        Provider.of<CityRegionProvider>(context, listen: false).getCity(
      context: context,
      id: Provider.of<BePartnerProvider>(context, listen: false)
          .selectedRegion
          ?.id,
    );
    notifyListeners();
  }

  @override
  citySelect(newValue) {
    selectedCity = newValue;
    cityID = selectedCity!.id;
    print(
        'Selected City Name: ${selectedCity!.name} - ID: ${selectedCity!.id}');
    notifyListeners();
  }

  @override
  bankSelect(newValue) {
    selectedBank = newValue;
    bankID = selectedBank!.id;
    print(
        'Selected Bank Name: ${selectedBank!.name} - ID: ${selectedBank!.id}');
    notifyListeners();
  }

  @override
  departmentSelect(newValue) {
    selectedDepartment = newValue;
    print(
        'Selected Department Name: ${selectedBank!.name} - ID: ${selectedBank!.id}');
    notifyListeners();
  }

  @override
  Future<void> postData({
    required String? name,
    required String? description,
    required String? email,
    required String? phone,
    required String? nationalID,
    required String? cityID,
    required String? bankID,
    required String? departmentId,
    required String? iban,
    required String? commercialRegistrationNo,
    required String? imagePath,
    required String? taxNumber,
    required BuildContext context,
  }) async {
    circularDialog(context);
    _body = FormData.fromMap({
      "Name": name,
      "Description": description,
      "Phone": phone,
      "Email": email,
      "NationalId": nationalID,
      "BankId": bankID,
      "CityId": cityID,
      "BankAccountNumberIBAN": iban,
      "CommercialRegistrationNo": commercialRegistrationNo,
      "TaxNumber": taxNumber,
      "DepartmentId": departmentId,
      "Lat": storeLocationPosition?.latitude,
      "Lng": storeLocationPosition?.longitude,
      "NationalImage": await MultipartFile.fromFile(imagePath!),
    });
    await _apiProvider.post(
      apiRoute: partnerURL,
      successResponse: (response) {
        dismissDialog(context);
        successDialogWithTimer(context);
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        dismissDialog(context);
        errorDialog(context, _errorModel.message);
        notifyListeners();
      },
      data: _body,
    );
    notifyListeners();
  }

  @override
  disposeData() {
    selectedAddressName = '';
    selectedName = '';
    storeLocationPosition = null;
  }

  Future<LatLng> getStoreLocation() async {
    selectedAddressName = '';

    print("Get Street name - init::1 $storeLocationPosition");
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    storeLocationPosition = LatLng(position.latitude, position.longitude);
    // await placemarkFromCoordinates(
    //   position.latitude,
    //   position.longitude,
    //   localeIdentifier: "ar_EG",
    // ).then((value) {
    //   selectedAddressName = value[0].street!;
    //   notifyListeners();
    // });

    await getItContext!
        .read<MapServicesProvider>()
        .getAddress(LatLng(position.latitude, position.longitude))
        .then((value) {
      selectedAddressName = value.results![0].formattedAddress!;
      notifyListeners();
    });

    print("Get Street name - init::2 $storeLocationPosition");
    notifyListeners();
    return LatLng(position.latitude, position.longitude);
  }

  void onCameraMoves(CameraPosition position) async {
    storeLocationPosition = position.target;
    notifyListeners();
  }

  Future getStreetNameOnCameraMoves() async {
    selectedAddressName = '';
    print("Get Street name::1 $storeLocationPosition");
    if (storeLocationPosition != null &&
        storeLocationPosition != const LatLng(0, 0)) {
      // await placemarkFromCoordinates(
      //   storeLocationPosition!.latitude,
      //   storeLocationPosition!.longitude,
      //   localeIdentifier: "ar_EG",
      // ).then((value) {
      //   selectedAddressName = value[0].street!;
      //   notifyListeners();
      // });

      await getItContext!
          .read<MapServicesProvider>()
          .getAddress(LatLng(storeLocationPosition!.latitude,
              storeLocationPosition!.longitude))
          .then((value) {
        selectedAddressName = value.results![0].formattedAddress!;
        notifyListeners();
      });

      print("Get Street name::2 $storeLocationPosition");
      notifyListeners();
    }
  }

  Future<bool> saveSelectedAddress() async {
    bool isSaved = false;
    if (storeLocationPosition != null &&
        storeLocationPosition != const LatLng(0, 0)) {
      // List<Placemark> placemark = await placemarkFromCoordinates(
      //   storeLocationPosition!.latitude,
      //   storeLocationPosition!.longitude,
      //   localeIdentifier: "ar_EG",
      // );
      // selectedName = placemark[0].street!;

      await getItContext!
          .read<MapServicesProvider>()
          .getAddress(LatLng(storeLocationPosition!.latitude,
              storeLocationPosition!.longitude))
          .then((value) {
        selectedName = value.results![0].formattedAddress!;
        notifyListeners();
      });

      isSaved = true;
      notifyListeners();
    }
    return isSaved;
  }
}
