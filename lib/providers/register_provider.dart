import 'package:azooz/common/style/colors.dart';

import '../common/config/convert_farsi_numbers.dart';
import '../common/routes/app_router_import.gr.dart';
import '../common/routes/app_router_control.dart';
import '../generated/locale_keys.g.dart';
import '../model/error_model.dart';
import '../model/mixin/profile_mixin.dart';
import '../model/response/city_model.dart';
import '../model/response/gender_model.dart';
import '../model/response/region_model.dart';
import '../utils/dialogs.dart';
import 'city_region_provider.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterProvider extends ChangeNotifier with ProfileMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  // String? date = LocaleKeys.date.tr();
  String? birthDate = LocaleKeys.birthDate.tr();
  UserGender? selectedGender;
  Cities? selectedCity;
  int? cityID = 0;
  Region? selectedRegion;
  bool? isRegionSelected = false;
  DateTime? dateTime = DateTime.now();
  FormData? _body;
  late BuildContext context;
  late Future<CityModel> futureCity;

  @override
  onSubmitDataPicker(datePicked) {
    dateTime = datePicked;
    birthDate = datePicked.toFormat("yyyy/mm/dd");
    // date = date!.substring(0, date!.indexOf(' '));
    print('Birth Day: $birthDate');
    notifyListeners();
  }

  @override
  genderSelect(newValue) {
    selectedGender = newValue;
    print(
        'Selected Gender Name: ${selectedGender!.name} - ID: ${selectedGender!.id}');
    notifyListeners();
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
      id: Provider.of<RegisterProvider>(context, listen: false)
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
  Future<void> putData({
    required String? firstName,
    required String? lastName,
    required String? email,
    required BuildContext context,
    String? imagePath,
  }) async {
    circularDialog(context);
    imagePath != null && imagePath != ''
        ? _body = FormData.fromMap({
            "FirstName": firstName,
            "LastName": lastName,
            "Email": email,
            "BirthDate": convertArabicToEng(birthDate),
            "CityID": selectedCity!.id.toString(),
            "GenderID": selectedGender!.id.toString(),
            "ImageUrl": await MultipartFile.fromFile(imagePath),
          })
        : _body = FormData.fromMap({
            "FirstName": firstName,
            "LastName": lastName,
            "Email": email,
            "BirthDate": convertArabicToEng(birthDate),
            "CityID": selectedCity!.id.toString(),
            "GenderID": selectedGender!.id.toString(),
          });
    await _apiProvider.put(
      apiRoute: profileURL,
      successResponse: (response) {
        dismissDialog(context);
        successDialogWithTimer(context).then((value) {
          routerPush(
            context: context,
            route: const AuthSuccessfulRoute(),
          );
        });
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

  openDateTimePicker(BuildContext context) async {
    var date = await showDatePicker(
      context: context,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Palette.primaryColor,
              onPrimary: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Palette.primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      currentDate: DateTime.now(),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      var dateTime = DateFormat('dd/MM/yyyy').format(date);
      birthDate = convertArabicToEng(dateTime);
      notifyListeners();
    }
    return null;
  }
}
