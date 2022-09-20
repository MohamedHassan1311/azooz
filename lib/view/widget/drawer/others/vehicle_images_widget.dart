import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../common/style/app_theme.dart';
import '../../../../common/style/colors.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../providers/be_captain_provider.dart';
import '../../custom_image_picker_widget.dart';

class VihcleImagesWidget extends StatefulWidget {
  const VihcleImagesWidget({Key? key}) : super(key: key);

  @override
  State<VihcleImagesWidget> createState() => _VihcleImagesWidgetState();
}

class _VihcleImagesWidgetState extends State<VihcleImagesWidget> {
  File? frontImageFile;
  File? backImageFile;
  File? rightImageFile;
  File? leftImageFile;
  File? insideImageFile;

  late BeCaptainProvider captainProvider;

  pickFrontImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    frontImageFile = File(result!.files.first.path.toString());
    captainProvider.setvFrontImagePath = frontImageFile!.path.toString();

    setState(() {});
  }

  pickBackImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    backImageFile = File(result!.files.first.path.toString());
    captainProvider.setvBackImagePath = backImageFile!.path.toString();
    setState(() {});
  }

  pickRightImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    rightImageFile = File(result!.files.first.path.toString());
    captainProvider.setvRightImagePath = rightImageFile!.path.toString();
    setState(() {});
  }

  pickLeftImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    leftImageFile = File(result!.files.first.path.toString());
    captainProvider.setvLeftImagePath = leftImageFile!.path.toString();
    setState(() {});
  }

  pickInsideImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    insideImageFile = File(result!.files.first.path.toString());
    captainProvider.setvInsideImagePath = insideImageFile!.path.toString();
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
            LocaleKeys.carImages.tr(),
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
              title: LocaleKeys.carFrontImage.tr(),
              imageFile: frontImageFile,
              onTap: pickFrontImage,
            ),
            CustomButtonImagePicker(
              title: LocaleKeys.carBackImage.tr(),
              imageFile: backImageFile,
              onTap: pickBackImage,
            ),
            CustomButtonImagePicker(
              title: LocaleKeys.carRightImage.tr(),
              imageFile: rightImageFile,
              onTap: pickRightImage,
            ),
            CustomButtonImagePicker(
              title: LocaleKeys.carLeftImage.tr(),
              imageFile: leftImageFile,
              onTap: pickLeftImage,
            ),
            CustomButtonImagePicker(
              title: LocaleKeys.carInsideImage.tr(),
              imageFile: insideImageFile,
              onTap: pickInsideImage,
            ),
          ],
        ),
      ),
    );
  }
}
