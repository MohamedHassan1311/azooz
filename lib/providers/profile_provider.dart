import 'dart:io';

import '../common/config/tools.dart';
import '../model/error_model.dart';
import '../model/mixin/profile_mixin.dart';
import '../model/response/profile_model.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import '../utils/delay.dart';
import '../utils/dialogs.dart';
import '../utils/easy_loading_functions.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

class ProfileProvider extends ChangeNotifier with ProfileMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  late ProfileModel _profileModel;
  FormData? _body;
  bool isEditCheck = false;

  String userName = '';
  String userImage = '';
  String userPhoneNumber = '';
  String userEmail = '';
  bool? isSaudi;
  bool? isDriver;
  bool? isStore;

  ProfileModel get getProfileData => _profileModel;
  Gender? get getUserId => _profileModel.result!.user!.gender;

  // final ImagePicker _picker = ImagePicker();
  // XFile? image;

  File? image;

  @override
  Future<ProfileModel> getData({
    required BuildContext context,
  }) async {
    await _apiProvider.get(
      apiRoute: profileURL,
      successResponse: (response) {
        _profileModel = ProfileModel.fromJson(response);
        print("####UserMode: ${_profileModel.result!.user} ###");
        userName = _profileModel.result!.user!.firstName!;
        userImage = _profileModel.result!.user!.imageURl!;
        userPhoneNumber = _profileModel.result!.user!.phoneNumber!;
        userEmail = _profileModel.result!.user!.email!;
        isSaudi = true;
        isDriver = _profileModel.result!.user!.isDriver;
        isStore = _profileModel.result!.user!.isStore;
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        dismissLoading().whenComplete(
          () => delayMilliseconds(
            250,
            () => errorDialog(context, _errorModel.message),
          ),
        );
        logger.e(response);
        notifyListeners();
      },
    );
    return _profileModel;
  }

  @override
  Future<void> editProfile({
    required String? firstName,
    required String? lastName,
    required String? email,
    required BuildContext context,
    String? imagePath,
    String? date,
    int? selectedCityID,
    int? selectedGenderID,
  }) async {
    circularDialog(context);
    imagePath != null && imagePath != ''
        ? _body = FormData.fromMap({
            "FirstName": firstName,
            "LastName": lastName,
            "Email": email,
            "BirthDate": date,
            "CityID": selectedCityID.toString(),
            "GenderID": selectedGenderID.toString(),
            "ImageUrl": await MultipartFile.fromFile(imagePath),
          })
        : _body = FormData.fromMap({
            "FirstName": firstName,
            "LastName": lastName,
            "Email": email,
            "BirthDate": date,
            "CityID": selectedCityID.toString(),
            "GenderID": selectedGenderID.toString(),
          });

    await _apiProvider.put(
      apiRoute: profileURL,
      successResponse: (response) {
        dismissDialog(context);
        successDialogWithTimer(context);
        getData(context: context);
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        dismissLoading().whenComplete(
          () => delayMilliseconds(
            250,
            () => errorDialog(context, _errorModel.message),
          ),
        );
        notifyListeners();
      },
      data: _body,
    );
    notifyListeners();
  }

  @override
  pickImage() async {
    // image = await _picker.pickImage(source: ImageSource.gallery);
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      // allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    image = File(result!.files.first.path.toString());
    notifyListeners();
  }

  @override
  editCheck({
    TextEditingController? firstNameController,
    TextEditingController? lastNameController,
    TextEditingController? emailController,
    TextEditingController? phoneController,
  }) {
    firstNameController!.text.isNotEmpty ||
            lastNameController!.text.isNotEmpty ||
            emailController!.text.isNotEmpty ||
            phoneController!.text.isNotEmpty ||
            image != null
        ? isEditCheck = true
        : isEditCheck = false;
    notifyListeners();
  }

  @override
  clearItems({
    TextEditingController? firstNameController,
    TextEditingController? lastNameController,
    TextEditingController? emailController,
    TextEditingController? phoneController,
  }) {
    image = null;
    firstNameController?.clear();
    lastNameController?.clear();
    emailController?.clear();
    phoneController?.clear();
    isEditCheck = false;
    notifyListeners();
  }

  ProfileModel get profileModel => _profileModel;
}
