import '../model/response/banks_model.dart';
import '../model/response/city_model.dart';
import '../model/response/region_model.dart';
import '../service/network/api_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/error_model.dart';
import '../model/mixin/be_captain_mixin.dart';
import '../service/network/url_constants.dart';
import '../utils/dialogs.dart';
import 'be_captain/driver_types_provider.dart';
import 'city_region_provider.dart';

class BeCaptainProvider extends ChangeNotifier with BeCaptainMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  FormData? _body;
  Cities? selectedCity;
  AllBanks? selectedBank;
  int? cityID = 0;
  int? bankID = 0;
  Region? selectedRegion;
  bool? isRegionSelected = false;
  late Future<CityModel> futureCity;
  late BuildContext context;

  // ALL BE CAPTAIN DATA - IMAGES
  String? _studentImagePath;
  set setstudentImagePath(String val) {
    _studentImagePath = val;
    notifyListeners();
  }

  String? _personalImagePath;
  set setpersonalImagePath(String val) {
    _personalImagePath = val;
    notifyListeners();
  }

  String? _vLencesesFrontImagePath;
  set setvLencesesFrontImagePath(String val) {
    _vLencesesFrontImagePath = val;
    notifyListeners();
  }

  String? _vLencesesBackImagePath;
  set setvLencesesBackImagePath(String val) {
    _vLencesesBackImagePath = val;
    notifyListeners();
  }

  String? _vFormFrontImagePath;
  set setvFormFrontImagePath(String val) {
    _vFormFrontImagePath = val;
    notifyListeners();
  }

  String? _vFormBackImagePath;
  set setvFormBackImagePath(String val) {
    _vFormBackImagePath = val;
    notifyListeners();
  }

  String? _vFrontImagePath;
  set setvFrontImagePath(String val) {
    _vFrontImagePath = val;
    notifyListeners();
  }

  String? _vBackImagePath;
  set setvBackImagePath(String val) {
    _vBackImagePath = val;
    notifyListeners();
  }

  String? _vRightImagePath;
  set setvRightImagePath(String val) {
    _vRightImagePath = val;
    notifyListeners();
  }

  String? _vLeftImagePath;
  set setvLeftImagePath(String val) {
    _vLeftImagePath = val;
    notifyListeners();
  }

  String? _vInsideImagePath;
  set setvInsideImagePath(String val) {
    _vInsideImagePath = val;
    notifyListeners();
  }

  clearImagesPath() {
    _studentImagePath = null;
    _personalImagePath = null;
    _vLencesesFrontImagePath = null;
    _vLencesesBackImagePath = null;
    _vFormFrontImagePath = null;
    _vFormBackImagePath = null;
    _vFrontImagePath = null;
    _vBackImagePath = null;
    _vRightImagePath = null;
    _vLeftImagePath = null;
    _vInsideImagePath = null;
    // notifyListeners();
  }

  @override
  regionSelect(newValue) {
    selectedRegion = newValue;
    print(
        'Selected Region Name: ${selectedRegion!.name} - ID: ${selectedRegion!.id}');
    isRegionSelected = true;
    futureCity =
        Provider.of<CityRegionProvider>(context, listen: false).getCity(
      context: context,
      id: Provider.of<BeCaptainProvider>(context, listen: false)
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
  Future<void> postData({
    required String? firstName,
    required String? lastName,
    required String? email,
    required String? phone,
    required String? nationalID,
    required String? cityID,
    required String? bankID,
    required String? iban,
    required String? nationalImage,
    required String? taxNumber,
    required bool? isTax,
    required bool? isTransport,
    required String? dateOfBirthHijri,
    required String? vehicleSequenceNumber,
    required String? vehiclePlateLetterRight,
    required String? vehiclePlateLetterMiddle,
    required String? vehiclePlateLetterLeft,
    required String? vehiclePlateNumber,
    required int? driverTypeId,
    required int? carCategoryId,
    required String? vehicleTypeId,
    required String? idTypeIdentifier,
    required int? carModel,
    required String? operatingCard,
    required int? carsKindId,
    required BuildContext context,
  }) async {
    circularDialog(context);
    _body = FormData.fromMap({
      "FirstName": firstName,
      "LastName": lastName,
      "Phone": phone,
      "Email": email,
      "NationalId": nationalID,
      "CityId": cityID,
      "BankId": bankID,
      "BankAccountNumberIBAN": iban,
      "NationalImage": await MultipartFile.fromFile(nationalImage!),
      "qualificationImage": _studentImagePath != null
          ? await MultipartFile.fromFile(_studentImagePath!)
          : "",
      "Userqualification":
          context.read<DriverTypesProvider>().isStudent ? 2 : 1,
      "IsTax": taxNumber == '' ? false : true,
      "TaxNumber": taxNumber,
      "dateOfBirthHijri": dateOfBirthHijri ?? DateTime.now(),
      "DriverTypeId": driverTypeId,
      "CarCategoryId": carCategoryId,
      "CarKindId": carsKindId,
      "VehicleSequenceNumber": vehicleSequenceNumber,
      "VehiclePlateLetterRight": vehiclePlateLetterRight,
      "VehiclePlateLetterMiddle": vehiclePlateLetterMiddle,
      "VehiclePlateLetterLeft": vehiclePlateLetterLeft,
      "VehiclePlateNumber": vehiclePlateNumber,
      "vehicleTypeId": vehicleTypeId,
      "idTypeIdentifier": idTypeIdentifier,
      "carModel": carModel,
      "operatingcard": operatingCard,
      "FormFrontImage": await MultipartFile.fromFile(_vFrontImagePath!),
      "FormBackImage": await MultipartFile.fromFile(_vBackImagePath!),
      "LicenseFrontImage":
          await MultipartFile.fromFile(_vLencesesFrontImagePath!),
      "LicenseBackImage":
          await MultipartFile.fromFile(_vLencesesBackImagePath!),
      "CarFrontImage": await MultipartFile.fromFile(_vFrontImagePath!),
      "CarBackImage": await MultipartFile.fromFile(_vBackImagePath!),
      "CarInsideImage": await MultipartFile.fromFile(_vInsideImagePath!),
      "CarLeftImage": await MultipartFile.fromFile(_vLeftImagePath!),
      "CarRightImage": await MultipartFile.fromFile(_vRightImagePath!),
    });
    await _apiProvider.post(
      apiRoute: captainURL,
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
    throw UnimplementedError();
  }
}
