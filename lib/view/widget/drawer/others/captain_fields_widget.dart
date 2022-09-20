import 'dart:io';

import 'package:azooz/model/request/driver_category_model.dart';
import 'package:azooz/model/response/cars_kind_model.dart';
import 'package:azooz/providers/be_captain/identity_types_provider.dart';
import 'package:flutter/services.dart';

import '../../../../common/config/convert_farsi_numbers.dart';
import '../../../../common/config/tools.dart';
import '../../../../common/style/app_theme.dart';
import '../../../../common/style/colors.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/request/car_types_model.dart';
import '../../../../model/request/driver_types_model.dart';
import '../../../../model/request/identity_types_model.dart';
import '../../../../model/response/banks_model.dart';
import '../../../../model/response/city_model.dart';
import '../../../../model/response/gender_model.dart';
import '../../../../model/response/region_model.dart';
import '../../../../providers/banks_provider.dart';
import '../../../../providers/be_captain/car_category_provider.dart';
import '../../../../providers/be_captain/driver_car_provider.dart';
import '../../../../providers/be_captain/driver_types_provider.dart';
import '../../../../providers/be_captain_provider.dart';
import '../../../../providers/city_region_provider.dart';
import '../../../../providers/gender_provider.dart';
import '../../../../providers/profile_provider.dart';
import '../../../../providers/register_provider.dart';
import '../../../../utils/dialogs.dart';
import '../../../../utils/smart_text_inputs.dart';
import '../../../custom_widget/custom_button.dart';
import '../../../custom_widget/custom_error_widget.dart';
import '../../../custom_widget/custom_loading_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../custom_image_picker_widget.dart';
import 'captain_data_widget.dart';
import 'vehicle_form_widget.dart';
import 'vehicle_images_widget.dart';
import 'vehicle_license_widget.dart';

class CaptainFieldsWidget extends StatefulWidget {
  const CaptainFieldsWidget({Key? key}) : super(key: key);

  @override
  State<CaptainFieldsWidget> createState() => _CaptainFieldsWidgetState();
}

class _CaptainFieldsWidgetState extends State<CaptainFieldsWidget> {
  late Future<RegionModel> futureRegion;
  late Future<BanksModel> futureBanks;
  late Future<GenderModel> futureGender;
  late Future<CarsKindModel?> _futureCarsKind;

  bool isTax = true;
  bool isTransport = false;

  File? studentImageFile;
  String? studentImagePath = '';

  File? nationalImage;
  String? nationalImagePath = '';

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nationalIDController = TextEditingController();
  final TextEditingController ibanController = TextEditingController();
  final TextEditingController taxController = TextEditingController();
  final TextEditingController taxNumberController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  final TextEditingController vehicleSequenceNumberController =
      TextEditingController();
  final TextEditingController vehiclePlateLetterRightController =
      TextEditingController();
  final TextEditingController vehiclePlateLetterMiddleController =
      TextEditingController();
  final TextEditingController vehiclePlateLetterLeftController =
      TextEditingController();
  final TextEditingController vehiclePlateNumberController =
      TextEditingController();
  final TextEditingController operatingCardController = TextEditingController();

  late final BeCaptainProvider captainProvider;

  String? pickedHijriBirthDate;
  String? pickedGregorianBirthDate;
  String? pickedCarModel = "";
  String? firstName;
  String? lastName;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Future<CarCategoryModel?> _carCateoryFuture;

  late Future<IdentityTypesModel?> _futureIdentityTypes;

  late Future<CarTypesModel?> _futureCarTypes;

  @override
  void initState() {
    super.initState();

    context.read<DriverTypesProvider>().resetData();
    _futureCarTypes = context.read<DriverCarProvider>().getCarTypes(901);
    _futureIdentityTypes =
        context.read<IdentityTypesProvider>().getIdentityTypes();

    futureGender = Provider.of<GenderProvider>(context, listen: false)
        .getGenderData(context: context);
    _carCateoryFuture = context.read<CarCategoryProvider>().getCarCategory();
    _futureCarsKind = context.read<DriverCarProvider>().getCarsKind();
    firstName = Provider.of<ProfileProvider>(context, listen: false)
        .profileModel
        .result!
        .user!
        .firstName;
    lastName = Provider.of<ProfileProvider>(context, listen: false)
        .profileModel
        .result!
        .user!
        .lastName;
    firstNameController = TextEditingController(text: firstName);
    lastNameController = TextEditingController(text: lastName);
    captainProvider = Provider.of<BeCaptainProvider>(context, listen: false);
    captainProvider.clearImagesPath();
    futureRegion = Provider.of<CityRegionProvider>(context, listen: false)
        .getRegion(context: context);
    Provider.of<RegisterProvider>(context, listen: false).context = context;
    Provider.of<BeCaptainProvider>(context, listen: false).context = context;
    futureBanks = Provider.of<BanksProvider>(context, listen: false)
        .getBanks(context: context);
  }

  disposeAll() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    nationalIDController.dispose();
    ibanController.dispose();
    taxController.dispose();
    taxNumberController.dispose();
    cityController.dispose();
    vehicleSequenceNumberController.dispose();
    vehiclePlateLetterRightController.dispose();
    vehiclePlateLetterMiddleController.dispose();
    vehiclePlateLetterLeftController.dispose();
    vehiclePlateNumberController.dispose();
    operatingCardController.dispose();
  }

  @override
  void dispose() {
    // Provider.of<RegisterProvider>(context, listen: false).isRegionSelected =
    //     false;
    disposeAll();
    context.read<DriverTypesProvider>().resetData();
    super.dispose();
  }

  studentImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    studentImageFile = File(result!.files.first.path.toString());
    studentImagePath = studentImageFile!.path;
    captainProvider.setstudentImagePath = studentImagePath!;
    setState(() {});
  }

  pickPesonalIDImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    nationalImage = File(result!.files.first.path.toString());
    nationalImagePath = nationalImage!.path;
    captainProvider.setpersonalImagePath = nationalImagePath!;
    setState(() {});
  }

  submitRequestAsAServiceProvider() {
    String? pickedHijriBirthDateInEng =
        convertArabicToEng(pickedHijriBirthDate);
    print("I am date in english: $pickedHijriBirthDateInEng");
    Tools.hideKeyboard(context);
    if (context.read<DriverCarProvider>().currentVehicleType!.id != null &&
        context.read<CarCategoryProvider>().selectedCarCategory!.id != null &&
        context.read<DriverTypesProvider>().selectedDriverType!.id != null &&
        context.read<DriverCarProvider>().currentCarKind!.id != null &&
        firstNameController.text.trim().isNotEmpty &&
        lastNameController.text.trim().isNotEmpty &&
        nationalIDController.text.trim().isNotEmpty &&
        ibanController.text.trim().isNotEmpty &&
        taxNumberController.text.trim().isNotEmpty &&
        vehicleSequenceNumberController.text.trim().isNotEmpty &&
        vehiclePlateLetterRightController.text.trim().isNotEmpty &&
        vehiclePlateLetterMiddleController.text.trim().isNotEmpty &&
        vehiclePlateLetterLeftController.text.trim().isNotEmpty &&
        vehiclePlateNumberController.text.trim().isNotEmpty &&
        captainProvider.selectedCity!.id != null &&
        nationalImagePath!.trim().isNotEmpty) {
      Provider.of<BeCaptainProvider>(context, listen: false).postData(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: context.read<ProfileProvider>().userEmail,
        phone: context.read<ProfileProvider>().userPhoneNumber,
        nationalID: nationalIDController.text.trim(),
        cityID: captainProvider.selectedCity!.id.toString(),
        bankID: captainProvider.selectedBank!.id.toString(),
        iban: ibanController.text.trim(),
        nationalImage: nationalImagePath,
        taxNumber: taxController.text.trim(),
        isTax: true,
        isTransport: isTransport,
        dateOfBirthHijri: pickedHijriBirthDateInEng,
        vehicleSequenceNumber: vehicleSequenceNumberController.text.trim(),
        vehiclePlateLetterRight: vehiclePlateLetterRightController.text.trim(),
        vehiclePlateLetterMiddle:
            vehiclePlateLetterMiddleController.text.trim(),
        vehiclePlateLetterLeft: vehiclePlateLetterLeftController.text.trim(),
        vehiclePlateNumber: vehiclePlateNumberController.text.trim(),
        driverTypeId:
            context.read<DriverTypesProvider>().selectedDriverType!.id,
        carCategoryId:
            context.read<CarCategoryProvider>().selectedCarCategory!.id,
        vehicleTypeId: context.read<DriverCarProvider>().currentVehicleType!.id,
        idTypeIdentifier:
            context.read<IdentityTypesProvider>().currentIdentityTypes!.id,
        carModel: context.read<CarCategoryProvider>().currentCarModel,
        operatingCard: operatingCardController.text.trim(),
        carsKindId: context.read<DriverCarProvider>().currentCarKind!.id,
        context: context,
      );
    } else {
      errorDialog(context, LocaleKeys.pleaseInputFillAllFields.tr());
    }
  }

  @override
  Widget build(BuildContext context) {
    const sizedBoxW = SizedBox(width: 10);
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CaptainDataWidget(),

            const SizedBox(height: 10),

            Theme(
              data: ThemeData().copyWith(
                dividerColor: Colors.transparent,
                textTheme: textTheme,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                child: ExpansionTile(
                  title: Text(
                    LocaleKeys.personalInfo.tr(),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  textColor: Colors.black,
                  iconColor: Palette.primaryColor,
                  backgroundColor: Palette.secondaryDark,
                  collapsedBackgroundColor: Palette.secondaryDark,
                  initiallyExpanded: false,
                  childrenPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SmartInputTextField(
                            label: LocaleKeys.firstName.tr(),
                            hintText: LocaleKeys.firstName.tr(),
                            textAlign: TextAlign.start,
                            withUnderlineBorder: false,
                            isDense: true,
                            controller: firstNameController,
                            readOnly: true,
                            textInputType: TextInputType.name,
                          ),
                        ),
                        sizedBoxW,
                        Expanded(
                          child: SmartInputTextField(
                            label: LocaleKeys.lastName.tr(),
                            hintText: LocaleKeys.lastName.tr(),
                            textAlign: TextAlign.start,
                            withUnderlineBorder: true,
                            isDense: true,
                            textInputType: TextInputType.name,
                            controller: lastNameController,
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                    Consumer<ProfileProvider>(
                        builder: (context, provider, child) {
                      return SmartInputTextField(
                        label: LocaleKeys.phoneNumber.tr(),
                        controller: phoneController,
                        // hintStyle: const TextStyle(color: Palette.primaryColor),
                        maxLines: 1,
                        isDense: true,
                        textAlignVertical: TextAlignVertical.center,
                        contentPadding: EdgeInsets.zero,
                        textInputType: TextInputType.phone,
                        readOnly: true,
                        hintText: provider.userPhoneNumber,
                      );
                    }),
                    Consumer<ProfileProvider>(
                        builder: (context, provider, child) {
                      return SmartInputTextField(
                        label: LocaleKeys.email.tr(),
                        controller: phoneController,
                        maxLines: 1,
                        isDense: true,
                        textAlignVertical: TextAlignVertical.center,
                        contentPadding: EdgeInsets.zero,
                        textInputType: TextInputType.emailAddress,
                        readOnly: true,
                        hintText: provider.userEmail,
                      );
                    }),
                    FutureBuilder<GenderModel>(
                      future: futureGender,
                      builder: (context, snapshot) => snapshot.hasData
                          ? Consumer<RegisterProvider>(
                              builder: (context, provider, child) {
                                return SmartDropDownField(
                                  label: LocaleKeys.gender.tr(),
                                  value: provider.selectedGender,
                                  isExpanded: true,
                                  icon: Icons.keyboard_arrow_down_outlined,
                                  placeHolder: LocaleKeys.gender.tr(),
                                  items: Provider.of<GenderProvider>(context,
                                          listen: false)
                                      .genderModel
                                      .result!
                                      .genders!
                                      .map<DropdownMenuItem<UserGender>>((map) {
                                    return DropdownMenuItem<UserGender>(
                                      value: map,
                                      child: Text(
                                        map.name!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                              color: Colors.black,
                                            ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (dynamic newValue) =>
                                      provider.genderSelect(newValue),
                                  hint: Text(
                                    LocaleKeys.gender.tr(),
                                    style:
                                        Theme.of(context).textTheme.subtitle2!,
                                  ),
                                  prefixIcon: Icons.person,
                                  prefixIconColor: Palette.secondaryLight,
                                  iconColor: Palette.secondaryLight,
                                  alignedDropdown: false,
                                );
                              },
                            )
                          : snapshot.hasError
                              ? const CustomErrorWidget()
                              : const CustomLoadingWidget(
                                  size: 30,
                                  paddingAll: 10,
                                ),
                    ),
                    FutureBuilder<RegionModel>(
                      future: futureRegion,
                      builder: (context, snapshot) => snapshot.hasData
                          ? Consumer<BeCaptainProvider>(
                              builder: (context, provider, child) {
                                return SmartDropDownField(
                                  label: LocaleKeys.region.tr(),
                                  value: provider.selectedRegion,
                                  icon: Icons.keyboard_arrow_down_outlined,
                                  items: Provider.of<CityRegionProvider>(
                                          context,
                                          listen: false)
                                      .regionModel
                                      .result!
                                      .regions!
                                      .map<DropdownMenuItem<Region>>((map) {
                                    return DropdownMenuItem<Region>(
                                      value: map,
                                      child: Text(
                                        map.name!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                              color: Colors.black,
                                            ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (dynamic newValue) =>
                                      provider.regionSelect(newValue),
                                  hint: Text(
                                    LocaleKeys.region.tr(),
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  prefixIcon: Icons.apartment,
                                  withUnderLine: true,
                                );
                              },
                            )
                          : snapshot.hasError
                              ? const CustomErrorWidget()
                              : const CustomLoadingWidget(
                                  size: 30,
                                  paddingAll: 10,
                                ),
                    ),
                    if (Provider.of<BeCaptainProvider>(context)
                            .isRegionSelected ==
                        true) ...[
                      Consumer<BeCaptainProvider>(
                        builder: (context, provider, child) {
                          return FutureBuilder<CityModel>(
                            future: Provider.of<CityRegionProvider>(context,
                                    listen: false)
                                .getCity(
                              context: context,
                              id: provider.selectedRegion!.id,
                            ),
                            builder: (context, snapshot) => snapshot.hasData
                                ? Consumer<BeCaptainProvider>(
                                    builder: (context, provider, child) {
                                      return SmartDropDownField(
                                        label: LocaleKeys.city.tr(),
                                        value: provider.selectedCity,
                                        icon:
                                            Icons.keyboard_arrow_down_outlined,
                                        items: Provider.of<CityRegionProvider>(
                                                context,
                                                listen: false)
                                            .cityModel
                                            .result!
                                            .cities!
                                            .map<DropdownMenuItem<Cities>>(
                                                (map) {
                                          return DropdownMenuItem<Cities>(
                                            value: map,
                                            child: Text(
                                              map.name!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                    color: Colors.black,
                                                  ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (dynamic newValue) =>
                                            provider.citySelect(newValue),
                                        hint: Text(
                                          LocaleKeys.city.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                        ),
                                        prefixIcon: Icons.apartment,
                                        withUnderLine: true,
                                      );
                                    },
                                  )
                                : snapshot.hasError
                                    ? const CustomErrorWidget()
                                    : const CustomLoadingWidget(
                                        size: 30,
                                        paddingAll: 10,
                                      ),
                          );
                        },
                      ),
                    ],
                    FutureBuilder<BanksModel>(
                        future: futureBanks,
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ? Consumer<BeCaptainProvider>(
                                  builder: (context, provider, child) {
                                    return Consumer<BeCaptainProvider>(
                                      builder: (context, provider, child) {
                                        return SmartDropDownField(
                                          label: LocaleKeys.bank.tr(),
                                          value: provider.selectedBank,
                                          icon: Icons
                                              .keyboard_arrow_down_outlined,
                                          items: Provider.of<BanksProvider>(
                                                  context,
                                                  listen: false)
                                              .banksModel
                                              .result!
                                              .allbanks!
                                              .map<DropdownMenuItem<AllBanks>>(
                                                  (map) {
                                            return DropdownMenuItem<AllBanks>(
                                              value: map,
                                              child: Text(
                                                map.name!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2!
                                                    .copyWith(
                                                      color: Colors.black,
                                                    ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (dynamic newValue) =>
                                              provider.bankSelect(newValue),
                                          hint: Text(
                                            LocaleKeys.bank.tr(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                          ),
                                          prefixIcon: Icons.account_balance,
                                          withUnderLine: true,
                                        );
                                      },
                                    );
                                  },
                                )
                              : snapshot.hasError
                                  ? const CustomErrorWidget()
                                  : const CustomLoadingWidget(size: 30);
                        }),
                    SmartInputTextField(
                      label: LocaleKeys.iban.tr(),
                      hintText: LocaleKeys.iban.tr(),
                      textAlign: TextAlign.start,
                      withUnderlineBorder: true,
                      isDense: true,
                      controller: ibanController,
                    ),
                    if (isTax)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SmartInputTextField(
                            label: LocaleKeys.taxNumber.tr(),
                            hintText: LocaleKeys.taxNumber.tr(),
                            textAlign: TextAlign.start,
                            withUnderlineBorder: true,
                            isDense: true,
                            textInputType: TextInputType.number,
                            inputFormatters: Tools.digitsOnlyFormatter(),
                            controller: taxNumberController,
                          ),
                        ],
                      ),
                    FutureBuilder<IdentityTypesModel?>(
                        future: _futureIdentityTypes,
                        builder: (context, snapshot) {
                          return !snapshot.hasData
                              ? const CustomLoadingWidget()
                              : Consumer<IdentityTypesProvider>(
                                  builder: (context, provider, child) {
                                    return SmartDropDownField(
                                      label: LocaleKeys.identityType.tr(),
                                      hint: Text(
                                        LocaleKeys.identityType.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                      items: provider.identityTypesList!.map(
                                        (identityTypes) {
                                          return DropdownMenuItem<
                                              IdentityTypes>(
                                            value: identityTypes,
                                            child: Text(
                                              identityTypes.name.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                    color: Colors.black,
                                                  ),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (val) {
                                        context
                                            .read<IdentityTypesProvider>()
                                            .setIdentityTypes = val;
                                        print('#val:@ ${val!.name}');
                                        print('#val:@ ${val!.id}');
                                      },
                                    );
                                  },
                                );
                        }),
                    SmartInputTextField(
                      label: LocaleKeys.nationalID.tr(),
                      hintText: LocaleKeys.nationalID.tr(),
                      textAlign: TextAlign.start,
                      withUnderlineBorder: true,
                      isDense: true,
                      textInputType: TextInputType.number,
                      inputFormatters: Tools.digitsOnlyFormatter(),
                      controller: nationalIDController,
                    ),
                    CustomButtonImagePicker(
                      title: LocaleKeys.nationalIMG.tr(),
                      imageFile: nationalImage,
                      onTap: pickPesonalIDImage,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(LocaleKeys.dateOfBirth.tr()),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  // bool? isDriverFromSaudi =
                                  //     context.read<ProfileProvider>().isSaudi;

                                  // IdentityTypes? identityTypes = context
                                  //     .read<IdentityTypesProvider>()
                                  //     .currentIdentityTypes;
                                  // if (identityTypes != null &&
                                  //     identityTypes.id ==
                                  //         DriverIdentityTypes.national) {
                                  await showDatePicker(
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
                                    lastDate: DateTime.now(),
                                    firstDate: DateTime(1960),
                                    initialDatePickerMode: DatePickerMode.day,
                                  ).then((value) {
                                    if (value != null) {
                                      setState(() {
                                        pickedGregorianBirthDate = null;
                                        pickedHijriBirthDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(value);
                                      });
                                    }
                                  });
                                  // } else {
                                  //   await showDatePicker(
                                  //     context: context,
                                  //                             builder: (context, child) {
                                  //   return Theme(
                                  //     data: Theme.of(context).copyWith(
                                  //       colorScheme: const ColorScheme.light(
                                  //         primary: Palette.primaryColor,
                                  //         onPrimary: Colors.black,
                                  //       ),
                                  //       textButtonTheme: TextButtonThemeData(
                                  //         style: TextButton.styleFrom(
                                  //           primary: Palette.primaryColor,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     child: child!,
                                  //   );
                                  // },
                                  //     initialDate: DateTime.now(),
                                  //     firstDate: DateTime(
                                  //       1950,
                                  //     ),
                                  //     lastDate: DateTime.now(),
                                  //     builder: (context, child) {
                                  //       return Theme(
                                  //         data: ThemeData().copyWith(
                                  //           dividerColor: Colors.transparent,
                                  //           textTheme: textTheme,
                                  //         ),
                                  //         child: child!,
                                  //       );
                                  //     },
                                  //   ).then((value) {
                                  //     if (value != null) {
                                  //       setState(() {
                                  //         pickedHijriBirthDate = null;
                                  //         pickedGregorianBirthDate =
                                  //             DateFormat('dd/MM/yyyy')
                                  //                 .format(value);
                                  //         print(
                                  //             "I am vallll: $pickedHijriBirthDate hijri");
                                  //         print(
                                  //             "I am vallll: $pickedGregorianBirthDate");
                                  //       });
                                  //     }
                                  //   });
                                  // }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 55,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Palette.kWhite,
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.add, size: 17),
                                        const SizedBox(width: 3),
                                        Text(
                                          LocaleKeys.upload.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Selector<ProfileProvider, bool?>(
                              selector: (context, user) => user.isSaudi,
                              builder: (context, isSaudi, child) {
                                if (isSaudi != null) {
                                  if (pickedHijriBirthDate != null &&
                                      pickedHijriBirthDate!.isNotEmpty) {
                                    return Row(
                                      children: [
                                        sizedBoxW,
                                        Container(
                                          height: 55,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Palette.kWhite,
                                          ),
                                          child: Center(
                                            child: Text(
                                              pickedHijriBirthDate.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else if (pickedGregorianBirthDate != null &&
                                      pickedGregorianBirthDate!.isNotEmpty) {
                                    return Row(
                                      children: [
                                        sizedBoxW,
                                        Container(
                                          height: 55,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Palette.kWhite,
                                          ),
                                          child: Center(
                                            child: Text(
                                              pickedGregorianBirthDate ?? "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Theme(
                  data: ThemeData().copyWith(
                    dividerColor: Colors.transparent,
                    textTheme: textTheme,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: ExpansionTile(
                      textColor: Colors.black,
                      iconColor: Palette.primaryColor,
                      backgroundColor: Palette.secondaryDark,
                      collapsedBackgroundColor: Palette.secondaryDark,
                      initiallyExpanded: false,
                      childrenPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      title: Text(
                        LocaleKeys.carInfo.tr(),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      children: [
                        FutureBuilder<CarsKindModel?>(
                            future: _futureCarsKind,
                            builder: (context, snapshot) {
                              return !snapshot.hasData
                                  ? const CustomLoadingWidget()
                                  : Consumer<DriverCarProvider>(
                                      builder: (context, provider, child) {
                                        if (provider.carsKind != null) {
                                          return SmartDropDownField(
                                            label: LocaleKeys.carKind.tr(),
                                            items: provider.carsKind!.map(
                                              (carKind) {
                                                return DropdownMenuItem<
                                                    CarsKind>(
                                                  value: carKind,
                                                  child: Text(
                                                    carKind.name.toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2!
                                                        .copyWith(
                                                          color: Colors.black,
                                                        ),
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                            onChanged: (val) {
                                              context
                                                  .read<DriverCarProvider>()
                                                  .setCarKindId = val;
                                              print(
                                                  '#val cars kind: ${val!.name}');
                                              print(
                                                  '#val cars kind: ${val!.id}');
                                            },
                                            hint: Text(
                                              LocaleKeys.selectCarBrand.tr(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                            ),
                                            withUnderLine: true,
                                          );
                                        }
                                        return const SizedBox();
                                      },
                                    );
                            }),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text(LocaleKeys.carModel.tr()),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                              "اختر تاريخ الموديل",
                                            ),
                                            content: Scrollable(viewportBuilder:
                                                (context, position) {
                                              return SizedBox(
                                                // Need to use container to add size constraint.
                                                width: 300,
                                                height: 300,
                                                child: YearPicker(
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(
                                                      DateTime.now().year - 15),
                                                  lastDate: DateTime.now(),
                                                  selectedDate: DateTime.now(),
                                                  currentDate: DateTime.now(),
                                                  onChanged:
                                                      (DateTime dateTime) {
                                                    pickedCarModel =
                                                        DateFormat('yyyy')
                                                            .format(dateTime);
                                                    var engNumbers =
                                                        convertArabicToEng(
                                                            pickedCarModel);
                                                    context
                                                            .read<
                                                                CarCategoryProvider>()
                                                            .setCarModel =
                                                        int.parse(engNumbers!);

                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              );
                                            }),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 55,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Palette.kWhite,
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.add, size: 17),
                                            const SizedBox(width: 3),
                                            Text(
                                              LocaleKeys.upload.tr(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Selector<CarCategoryProvider, int?>(
                                  selector: (p0, p1) => p1.currentCarModel,
                                  builder: (context, carModel, child) {
                                    if (carModel != null && carModel > 0) {
                                      return Row(
                                        children: [
                                          sizedBoxW,
                                          Container(
                                            height: 55,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Palette.kWhite,
                                            ),
                                            child: Center(
                                              child: Text(
                                                carModel.toString(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    return const SizedBox();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        SmartInputTextField(
                          label: LocaleKeys.vehicleSequenceNumber.tr(),
                          hintText: LocaleKeys.vehicleSequenceNumber.tr(),
                          textAlign: TextAlign.start,
                          withUnderlineBorder: true,
                          isDense: true,
                          controller: vehicleSequenceNumberController,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SmartInputTextField(
                                label: LocaleKeys.vehiclePlateNumber.tr(),
                                hintText: LocaleKeys.vehiclePlateNumber.tr(),
                                textAlign: TextAlign.start,
                                withUnderlineBorder: true,
                                isDense: true,
                                textInputType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r'\s'),
                                  ),
                                ],
                                controller: vehiclePlateNumberController,
                              ),
                            ),
                            sizedBoxW,
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Expanded(
                                      child: SmartInputTextField(
                                        alignment: CrossAxisAlignment.center,
                                        textAlign: TextAlign.center,
                                        label: LocaleKeys
                                            .vehiclePlateLetterRight
                                            .tr(),
                                        maxLength: 1,
                                        hintText: LocaleKeys
                                            .vehiclePlateLetterRight
                                            .tr(),
                                        controller:
                                            vehiclePlateLetterRightController,
                                      ),
                                    ),
                                    sizedBoxW,
                                    Expanded(
                                      child: SmartInputTextField(
                                        alignment: CrossAxisAlignment.center,
                                        textAlign: TextAlign.center,
                                        label: LocaleKeys
                                            .vehiclePlateLetterMiddle
                                            .tr(),
                                        maxLength: 1,
                                        hintText: LocaleKeys
                                            .vehiclePlateLetterMiddle
                                            .tr(),
                                        controller:
                                            vehiclePlateLetterMiddleController,
                                      ),
                                    ),
                                    sizedBoxW,
                                    Expanded(
                                      child: SmartInputTextField(
                                        alignment: CrossAxisAlignment.center,
                                        textAlign: TextAlign.center,
                                        label: LocaleKeys.vehiclePlateLetterLeft
                                            .tr(),
                                        maxLength: 1,
                                        hintText: LocaleKeys
                                            .vehiclePlateLetterLeft
                                            .tr(),
                                        controller:
                                            vehiclePlateLetterLeftController,
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Selector<DriverTypesProvider, DriverTypes?>(
                            selector: ((p0, p1) => p1.selectedDriverType),
                            builder: (context, provider, child) {
                              if (provider != null && provider.id != null) {
                                return FutureBuilder<CarTypesModel?>(
                                    future: _futureCarTypes,
                                    builder: (context, snapshot) {
                                      return !snapshot.hasData
                                          ? const CustomLoadingWidget()
                                          : Consumer<DriverCarProvider>(
                                              builder:
                                                  (context, provider, child) {
                                                if (provider.carTypes != null) {
                                                  return SmartDropDownField(
                                                    label:
                                                        LocaleKeys.carType.tr(),
                                                    items:
                                                        provider.carTypes!.map(
                                                      (identityTypes) {
                                                        return DropdownMenuItem<
                                                            CarTypes>(
                                                          value: identityTypes,
                                                          child: Text(
                                                            identityTypes.name
                                                                .toString(),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .subtitle2!
                                                                .copyWith(
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                          ),
                                                        );
                                                      },
                                                    ).toList(),
                                                    onChanged: (val) {
                                                      context
                                                          .read<
                                                              DriverCarProvider>()
                                                          .setVehicleType = val;
                                                      print(
                                                          '#val setVehicleType: ${val!.name}');
                                                      print(
                                                          '#val setVehicleType: ${val!.name}');
                                                    },
                                                    hint: Text(
                                                      "إختر نوع السيارة",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle2,
                                                    ),
                                                    withUnderLine: true,
                                                  );
                                                }
                                                return const SizedBox();
                                              },
                                            );
                                    });
                              }
                              return const SizedBox();
                            }),
                        Selector<DriverTypesProvider, bool>(
                          selector: (p0, p1) => p1.showOperatingCardState,
                          builder: (context, showOperatingCardState, child) {
                            if (showOperatingCardState) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SmartInputTextField(
                                    label: "بطاقة التشغيل",
                                    hintText: "بطاقة التشغيل",
                                    textAlign: TextAlign.start,
                                    withUnderlineBorder: true,
                                    isDense: true,
                                    textInputType: TextInputType.number,
                                    inputFormatters:
                                        Tools.digitsOnlyFormatter(),
                                    controller: operatingCardController,
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                        FutureBuilder<CarCategoryModel?>(
                            future: _carCateoryFuture,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Consumer<CarCategoryProvider>(
                                  builder: (context, carCategory, child) {
                                    return DropdownButtonHideUnderline(
                                      child: SmartDropDownField(
                                        label: LocaleKeys.carClass.tr(),
                                        hint: Text(
                                          LocaleKeys.carClass.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                        ),
                                        onChanged: (driverCategory) {
                                          // context.read<CarCategoryProvider>()
                                          //     .selectedCarCategory = driverCategory},
                                          // onChanged: (DriverCategory? driverCategory) {
                                          context
                                                  .read<CarCategoryProvider>()
                                                  .setCarCategory =
                                              driverCategory as CarCategory;
                                          // },
                                        },
                                        items: carCategory.listCarCategory!
                                            .map((types) {
                                          return DropdownMenuItem<CarCategory>(
                                            value: types,
                                            child: Text(
                                              types.name.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                    color: Colors.black,
                                                  ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  },
                                );
                              }
                              return const Text("");
                            }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const VihcleImagesWidget(),
                const SizedBox(height: 10),
                const VehicleLicenseWidget(),
                const SizedBox(height: 10),
                const VihcleFormWidget(),
              ],
            ),

            // SUBMIT BUTTON

            const SizedBox(height: 20),
            CustomButton(
              text: LocaleKeys.confirm.tr(),
              onPressed: submitRequestAsAServiceProvider,
              width: MediaQuery.of(context).size.width * 0.94,
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
