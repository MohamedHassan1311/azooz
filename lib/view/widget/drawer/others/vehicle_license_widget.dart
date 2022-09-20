import 'dart:io';

import 'package:azooz/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../common/style/app_theme.dart';
import '../../../../common/style/colors.dart';
import '../../../../providers/be_captain_provider.dart';
import '../../custom_image_picker_widget.dart';

class VehicleLicenseWidget extends StatefulWidget {
  const VehicleLicenseWidget({Key? key}) : super(key: key);

  @override
  State<VehicleLicenseWidget> createState() => _VehicleLicenseWidgetState();
}

class _VehicleLicenseWidgetState extends State<VehicleLicenseWidget> {
  File? frontImageFile;
  File? backImageFile;
  late BeCaptainProvider captainProvider;

  pickFrontImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    frontImageFile = File(result!.files.first.path.toString());
    captainProvider.setvLencesesFrontImagePath =
        frontImageFile!.path.toString();
    setState(() {});
  }

  pickBackImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    backImageFile = File(result!.files.first.path.toString());
    captainProvider.setvLencesesBackImagePath = backImageFile!.path.toString();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    captainProvider = Provider.of<BeCaptainProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
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
            LocaleKeys.licenseImages.tr(),
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
            CustomButtonImagePicker(
              title: LocaleKeys.licenseFrontImage.tr(),
              imageFile: frontImageFile,
              onTap: pickFrontImage,
            ),
            CustomButtonImagePicker(
              title: LocaleKeys.licenseBackImage.tr(),
              imageFile: backImageFile,
              onTap: pickBackImage,
            ),
          ],
        ),
      ),
    );
  }
}
