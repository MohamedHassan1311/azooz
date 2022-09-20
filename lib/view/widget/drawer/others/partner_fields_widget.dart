import 'dart:async';
import 'dart:io';

import '../../../../common/config/tools.dart';
import '../../../../common/style/colors.dart';
import '../../../../common/style/style.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/response/departments_model.dart';
import '../../../../model/response/region_model.dart';
import '../../../../providers/banks_provider.dart';
import '../../../../providers/be_partner_provider.dart';
import '../../../../providers/city_region_provider.dart';
import '../../../../providers/department_provider.dart';
import '../../../../providers/profile_provider.dart';
import '../../../../providers/register_provider.dart';
import '../../../../utils/dialogs.dart';
import '../../../../utils/smart_text_inputs.dart';
import '../../../custom_widget/custom_error_widget.dart';
import '../../../custom_widget/custom_loading_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../model/response/banks_model.dart';
import '../../../../model/response/city_model.dart';
import '../../../custom_widget/custom_button.dart';
import '../../image_viewer.dart';
import 'be_partner/google_map_widget.dart';

class PartnerFieldsWidget extends StatefulWidget {
  const PartnerFieldsWidget({Key? key}) : super(key: key);

  @override
  _PartnerFieldsWidgetState createState() => _PartnerFieldsWidgetState();
}

class _PartnerFieldsWidgetState extends State<PartnerFieldsWidget> {
  late Future<RegionModel> futureRegion;
  late Future<BanksModel> futureBanks;
  late Future<DepartmentsModel> futureDepartments;

  File? image;
  String? imagePath = '';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nationalIDController = TextEditingController();
  final TextEditingController ibanController = TextEditingController();
  final TextEditingController taxController = TextEditingController();
  final TextEditingController commercialController = TextEditingController();

  late final BePartnerProvider partnerProvider;

  @override
  void initState() {
    super.initState();
    partnerProvider = Provider.of<BePartnerProvider>(context, listen: false);
    futureRegion = Provider.of<CityRegionProvider>(context, listen: false)
        .getRegion(context: context);
    Provider.of<RegisterProvider>(context, listen: false).context = context;
    Provider.of<BePartnerProvider>(context, listen: false).context = context;
    futureBanks = Provider.of<BanksProvider>(context, listen: false)
        .getBanks(context: context);
    futureDepartments = Provider.of<DepartmentProvider>(context, listen: false)
        .getDepartments(context: context);
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    phoneController.dispose();
    emailController.dispose();
    nationalIDController.dispose();
    ibanController.dispose();
    taxController.dispose();
    commercialController.dispose();
    Provider.of<RegisterProvider>(context, listen: false).isRegionSelected =
        false;
    super.dispose();
  }

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    image = File(result!.files.first.path.toString());
    imagePath = image!.path;
    setState(() {});
  }

  submit() {
    Tools.hideKeyboard(context);
    print('@@@ ${partnerProvider.selectedBank}');
    if (nameController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        nationalIDController.text.trim().isNotEmpty &&
        ibanController.text.trim().isNotEmpty &&
        partnerProvider.selectedCity!.id != null &&
        partnerProvider.selectedBank!.id != null &&
        partnerProvider.selectedDepartment!.id != null &&
        imagePath!.trim().isNotEmpty) {
      Provider.of<BePartnerProvider>(context, listen: false).postData(
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        email: context.read<ProfileProvider>().userEmail.trim(),
        phone: context.read<ProfileProvider>().userPhoneNumber.trim(),
        nationalID: nationalIDController.text.trim(),
        cityID: partnerProvider.selectedCity!.id.toString(),
        bankID: partnerProvider.selectedBank!.id.toString(),
        departmentId: partnerProvider.selectedDepartment!.id.toString(),
        iban: ibanController.text.trim(),
        commercialRegistrationNo: commercialController.text.trim(),
        imagePath: imagePath,
        taxNumber: taxController.text.trim(),
        context: context,
      );
    } else {
      errorDialog(context, LocaleKeys.pleaseInputFillAllFields.tr());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 239, 239, 239),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmartInputTextField(
                label: "إسم المتجر",
                hintText: "إسم المتجر",
                textAlign: TextAlign.start,
                withUnderlineBorder: true,
                isDense: true,
                controller: nameController,
                textInputType: TextInputType.name,
              ),
              SmartInputTextField(
                label: "وصف المتجر",
                hintText: "وصف المتجر",
                textAlign: TextAlign.start,
                withUnderlineBorder: true,
                isDense: true,
                maxLines: 3,
                textInputType: TextInputType.name,
                controller: descriptionController,
              ),
              Consumer<ProfileProvider>(builder: (context, provider, child) {
                return Column(
                  children: [
                    SmartInputTextField(
                      label: LocaleKeys.phone.tr(),
                      controller: phoneController,
                      // hintStyle: const TextStyle(color: Palette.primaryColor),
                      maxLines: 1,
                      isDense: true,
                      textAlignVertical: TextAlignVertical.center,
                      contentPadding: EdgeInsets.zero,
                      textInputType: TextInputType.phone,
                      readOnly: true,
                      hintText: provider.userPhoneNumber,
                    ),
                    SmartInputTextField(
                      label: LocaleKeys.phone.tr(),
                      controller: emailController,
                      maxLines: 1,
                      isDense: true,
                      textAlignVertical: TextAlignVertical.center,
                      contentPadding: EdgeInsets.zero,
                      textInputType: TextInputType.phone,
                      readOnly: true,
                      hintText: provider.userEmail,
                    ),
                  ],
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
              SmartInputTextField(
                label: LocaleKeys.iban.tr(),
                hintText: LocaleKeys.iban.tr(),
                textAlign: TextAlign.start,
                withUnderlineBorder: true,
                isDense: true,
                // textInputType: TextInputType.number,
                // inputFormatters: Tools.digitsOnlyFormatter(),
                controller: ibanController,
              ),
              SmartInputTextField(
                label: LocaleKeys.taxNumber.tr(),
                hintText: LocaleKeys.taxNumber.tr(),
                textAlign: TextAlign.start,
                withUnderlineBorder: true,
                isDense: true,
                textInputType: TextInputType.number,
                inputFormatters: Tools.digitsOnlyFormatter(),
                controller: taxController,
              ),
              SmartInputTextField(
                label: LocaleKeys.commercialRegistrationNo.tr(),
                hintText: LocaleKeys.commercialRegistrationNo.tr(),
                textAlign: TextAlign.start,
                withUnderlineBorder: true,
                isDense: true,
                textInputType: TextInputType.number,
                inputFormatters: Tools.digitsOnlyFormatter(),
                controller: commercialController,
              ),
              FutureBuilder<RegionModel>(
                future: futureRegion,
                builder: (context, snapshot) => snapshot.hasData
                    ? Consumer<BePartnerProvider>(
                        builder: (context, provider, child) {
                          return SmartDropDownField(
                            label: LocaleKeys.region.tr(),
                            value: provider.selectedRegion,
                            icon: Icons.keyboard_arrow_down_outlined,
                            items: Provider.of<CityRegionProvider>(context,
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
                              style: Theme.of(context).textTheme.subtitle2,
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
              if (Provider.of<BePartnerProvider>(context).isRegionSelected ==
                  true) ...[
                Consumer<BePartnerProvider>(
                  builder: (context, provider, child) {
                    return FutureBuilder<CityModel>(
                      future: Provider.of<CityRegionProvider>(context,
                              listen: false)
                          .getCity(
                        context: context,
                        id: provider.selectedRegion!.id,
                      ),
                      builder: (context, snapshot) => snapshot.hasData
                          ? Consumer<BePartnerProvider>(
                              builder: (context, provider, child) {
                                return SmartDropDownField(
                                  label: LocaleKeys.city.tr(),
                                  value: provider.selectedCity,
                                  icon: Icons.keyboard_arrow_down_outlined,
                                  items: Provider.of<CityRegionProvider>(
                                          context,
                                          listen: false)
                                      .cityModel
                                      .result!
                                      .cities!
                                      .map<DropdownMenuItem<Cities>>((map) {
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
                    );
                  },
                )
              ],
              FutureBuilder<BanksModel>(
                  future: futureBanks,
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? Consumer<BePartnerProvider>(
                            builder: (context, provider, child) {
                              return Consumer<BePartnerProvider>(
                                builder: (context, provider, child) {
                                  return SmartDropDownField(
                                    label: LocaleKeys.bank.tr(),
                                    value: provider.selectedBank,
                                    icon: Icons.keyboard_arrow_down_outlined,
                                    items: Provider.of<BanksProvider>(context,
                                            listen: false)
                                        .banksModel
                                        .result!
                                        .allbanks!
                                        .map<DropdownMenuItem<AllBanks>>((map) {
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
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
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
              FutureBuilder<DepartmentsModel>(
                  future: futureDepartments,
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? Consumer<BePartnerProvider>(
                            builder: (context, provider, child) {
                              return Consumer<BePartnerProvider>(
                                builder: (context, provider, child) {
                                  return SmartDropDownField(
                                    label: LocaleKeys.chooseCategory.tr(),
                                    value: provider.selectedDepartment,
                                    icon: Icons.keyboard_arrow_down_outlined,
                                    items: Provider.of<DepartmentProvider>(
                                            context,
                                            listen: false)
                                        .departmentsModel
                                        .result!
                                        .allDepartment!
                                        .map<DropdownMenuItem<AllDepartments>>(
                                            (map) {
                                      return DropdownMenuItem<AllDepartments>(
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
                                        provider.departmentSelect(newValue),
                                    hint: Text(
                                      LocaleKeys.categories.tr(),
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                    prefixIcon: Icons.category,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(LocaleKeys.nationalIMG.tr()),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: pickImage,
                          child: Container(
                            alignment: Alignment.center,
                            height: 55,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Palette.kWhite,
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.file_upload, size: 17),
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
                      if (image != null) ...[
                        const SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              print("### Picked Image - ${image!.path}");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ImageViewer(image: image!),
                                ),
                              );
                            },
                            child: Container(
                              height: 55,
                              decoration: cardDecoration5(context: context),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(image!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text("أضف عنوان المتجر من الخريطة"),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) {
                                return const CustomGoogleMap();
                              }),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 55,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Palette.kWhite,
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.place,
                                    color: Palette.primaryColor,
                                    size: 25,
                                  ),
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
                    ],
                  ),
                  const SizedBox(height: 5),
                  Selector<BePartnerProvider, String>(
                    selector: (p0, p1) => p1.selectedName,
                    builder: (context, selectedName, _) {
                      if (selectedName.isEmpty) {
                        return const SizedBox();
                      }
                      return Container(
                        height: 70.0,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Palette.primaryColor.withOpacity(0.1),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.place,
                              color: Palette.primaryColor,
                            ),
                            Text(selectedName),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: CustomButton(
            text: LocaleKeys.confirm.tr(),
            onPressed: submit,
            width: MediaQuery.of(context).size.width * 0.94,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
