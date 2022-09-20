import 'dart:io';

import 'package:azooz/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../common/style/app_theme.dart';
import '../../../../common/style/colors.dart';
import '../../../../model/request/driver_types_model.dart';
import '../../../../providers/be_captain/driver_car_provider.dart';
import '../../../../providers/be_captain/driver_types_provider.dart';
import '../../../../providers/be_captain_provider.dart';
import '../../../../utils/smart_text_inputs.dart';
import '../../../custom_widget/custom_loading_widget.dart';
import '../../custom_image_picker_widget.dart';

class CaptainDataWidget extends StatefulWidget {
  const CaptainDataWidget({Key? key}) : super(key: key);

  @override
  State<CaptainDataWidget> createState() => _CaptainDataWidgetState();
}

class _CaptainDataWidgetState extends State<CaptainDataWidget> {
  late Future<DriverTypesModel?>? _futureDriverTypes;
  late BeCaptainProvider captainProvider;
  int? selectedDriverType;

  @override
  void initState() {
    super.initState();
    _futureDriverTypes = context.read<DriverTypesProvider>().getDriverTypes();

    captainProvider = Provider.of<BeCaptainProvider>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  File? universityCardImageFile;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    universityCardImageFile = File(result!.files.first.path.toString());
    captainProvider.setstudentImagePath =
        universityCardImageFile!.path.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
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
                LocaleKeys.driverInfo.tr(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              textColor: Colors.black,
              iconColor: Palette.primaryColor,
              backgroundColor: Palette.secondaryDark,
              collapsedBackgroundColor: Palette.secondaryDark,
              initiallyExpanded: true,
              childrenPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              children: [
                FutureBuilder<DriverTypesModel?>(
                    future: _futureDriverTypes,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return Consumer<DriverTypesProvider>(
                          builder: (context, driver, child) {
                            return Column(
                              children: [
                                SmartDropDownField(
                                  label: LocaleKeys.driverType.tr(),
                                  hint: Text(
                                    LocaleKeys.driverType.tr(),
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  onChanged: (driverTypes) {
                                    print(
                                        "Selected Driver Type ID: ${driverTypes.id}");
                                    context
                                        .read<DriverTypesProvider>()
                                        .selectedDriverType = driverTypes;

                                    context
                                        .read<DriverCarProvider>()
                                        .getCarTypes(driverTypes.id);
                                    selectedDriverType = context
                                        .read<DriverTypesProvider>()
                                        .selectedDriverType!
                                        .id;
                                    switch (driverTypes.id) {
                                      case 901:
                                      case 902:
                                        context
                                            .read<DriverTypesProvider>()
                                            .setOperatingCardState = true;
                                        break;
                                      default:
                                        context
                                            .read<DriverTypesProvider>()
                                            .setOperatingCardState = false;
                                        break;
                                    }
                                  },
                                  items: driver.driverTypesList!
                                      .map((DriverTypes types) {
                                    return DropdownMenuItem<DriverTypes>(
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
                                // Student
                                const SizedBox(height: 10),

                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(LocaleKeys.areYouStudent.tr()),
                                    CupertinoSwitch(
                                      value: driver.isStudent,
                                      activeColor: Palette.primaryColor,
                                      onChanged: (val) {
                                        print("## Student:: $val ##");
                                        driver.setStudent = val;
                                        print(
                                            "## driver.isStudent:: ${driver.isStudent} ##");
                                      },
                                    ),
                                  ],
                                ),
                                const Divider(),
                                if (driver.isStudent) ...[
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    child: CustomButtonImagePicker(
                                      title: "صورة الإثبات",
                                      imageFile: universityCardImageFile,
                                      onTap: pickImage,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ]
                              ],
                            );
                          },
                        );
                      } else {
                        return const CustomLoadingWidget();
                      }
                    })),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
