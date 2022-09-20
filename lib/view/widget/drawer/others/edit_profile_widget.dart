import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../common/config/tools.dart';
import '../../../../common/style/colors.dart';
import '../../../../common/style/dimens.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/response/profile_model.dart';
import '../../../../providers/profile_provider.dart';
import '../../../../utils/dialogs.dart';
import '../../../custom_widget/custom_background_widget.dart';
import '../../../custom_widget/custom_button.dart';
import '../../../custom_widget/custom_cached_image_widget.dart';
import '../../../custom_widget/custom_error_widget.dart';
import '../../../custom_widget/custom_loading_widget.dart';
import '../../../custom_widget/custom_text_field_widget.dart';
import '../../../custom_widget/show_up_widget.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({Key? key}) : super(key: key);

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  late Future<ProfileModel> future;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    future = Provider.of<ProfileProvider>(context, listen: false)
        .getData(context: context)
        .then((value) {
      firstNameController.text = value.result!.user!.firstName.toString();
      lastNameController.text = value.result!.user!.lastName.toString();
      emailController.text = value.result!.user!.email.toString();
      phoneController.text = value.result!.user!.phoneNumber.toString();
      return Future.value(value);
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  submit() {
    final provider = Provider.of<ProfileProvider>(context, listen: false);
    Tools.hideKeyboard(context);
    if (firstNameController.text.isEmpty &&
        lastNameController.text.isEmpty &&
        emailController.text.isEmpty &&
        provider.image == null) {
      errorDialog(context, LocaleKeys.noEditHappened.tr());
    } else {
      provider.editProfile(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        context: context,
        date: provider.profileModel.result!.user?.birthDate,
        selectedGenderID: provider.profileModel.result!.user?.gender?.genderID,
        selectedCityID: provider.profileModel.result!.user?.city?.cityId,
        imagePath: provider.image != null ? provider.image?.path : '',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProfileModel>(
      future: future,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Palette.kWhite,
                        border: Border.all(
                          color: Palette.kWhite,
                          width: 2,
                        ),
                        shape: BoxShape.circle,
                        // boxShadow: const [
                        //   BoxShadow(
                        //     color: kDarkGreyCards,
                        //     offset: Offset(0.0, 2),
                        //     blurRadius: 2.0,
                        //   ),
                        // ],
                      ),
                      child: Consumer<ProfileProvider>(
                        builder: (context, provider, child) {
                          return provider.image == null
                              ? CachedImageCircular(
                                  height: 85,
                                  width: 85,
                                  onTap: () => provider.pickImage(),
                                  boxFit: BoxFit.cover,
                                  imageUrl: provider
                                      .profileModel.result!.user?.imageURl,
                                )
                              : GestureDetector(
                                  onTap: () => provider.pickImage(),
                                  child: Container(
                                    padding: edgeInsetsAll(2),
                                    height: 85,
                                    width: 85,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: FileImage(
                                        File(provider.image!.path),
                                      ),
                                    ),
                                  ),
                                );
                        },
                      ),
                    ),
                  ),
                  sizedBox(height: 5),
                  Text(LocaleKeys.firstName.tr()),
                  CustomBackgroundWidget(
                    width: double.infinity,
                    color: Palette.activeWidgetsColor,
                    padding: 0,
                    height: 30,
                    child: Center(
                      child: Padding(
                        padding: edgeInsetsSymmetric(horizontal: 8),
                        child: Consumer<ProfileProvider>(
                            builder: (context, provider, child) {
                          return CustomTextFieldWidget(
                            controller: firstNameController,
                            hintStyle:
                                const TextStyle(color: Palette.primaryColor),
                            maxLines: 1,
                            textCapitalization: TextCapitalization.words,
                            isDense: true,
                            textAlignVertical: TextAlignVertical.center,
                            contentPadding: EdgeInsets.zero,
                          );
                        }),
                      ),
                    ),
                  ),
                  sizedBox(height: 5),
                  Text(LocaleKeys.lastName.tr()),
                  CustomBackgroundWidget(
                    width: double.infinity,
                    color: Palette.activeWidgetsColor,
                    padding: 0,
                    height: 30,
                    child: Center(
                      child: Padding(
                        padding: edgeInsetsSymmetric(horizontal: 8),
                        child: Consumer<ProfileProvider>(
                          builder: (context, provider, child) {
                            return CustomTextFieldWidget(
                              controller: lastNameController,
                              hintStyle:
                                  const TextStyle(color: Palette.primaryColor),
                              maxLines: 1,
                              textCapitalization: TextCapitalization.words,
                              isDense: true,
                              textAlignVertical: TextAlignVertical.center,
                              contentPadding: EdgeInsets.zero,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  sizedBox(height: 5),
                  Text(LocaleKeys.phoneNumber.tr()),
                  CustomBackgroundWidget(
                    width: double.infinity,
                    color: Palette.activeWidgetsColor,
                    padding: 0,
                    height: 30,
                    child: Center(
                      child: Padding(
                        padding: edgeInsetsSymmetric(horizontal: 8),
                        child: Consumer<ProfileProvider>(
                            builder: (context, provider, child) {
                          return CustomTextFieldWidget(
                            controller: phoneController,
                            hintStyle:
                                const TextStyle(color: Palette.primaryColor),
                            maxLines: 1,
                            isDense: true,
                            textAlignVertical: TextAlignVertical.center,
                            contentPadding: EdgeInsets.zero,
                            textInputType: TextInputType.phone,
                            readOnly: true,
                          );
                        }),
                      ),
                    ),
                  ),
                  sizedBox(height: 5),
                  Text(LocaleKeys.email.tr()),
                  CustomBackgroundWidget(
                    width: double.infinity,
                    color: Palette.activeWidgetsColor,
                    padding: 0,
                    height: 30,
                    child: Center(
                      child: Padding(
                        padding: edgeInsetsSymmetric(horizontal: 8),
                        child: Consumer<ProfileProvider>(
                            builder: (context, provider, child) {
                          return CustomTextFieldWidget(
                            controller: emailController,
                            hintStyle:
                                const TextStyle(color: Palette.primaryColor),
                            maxLines: 1,
                            isDense: true,
                            textAlignVertical: TextAlignVertical.center,
                            contentPadding: EdgeInsets.zero,
                          );
                        }),
                      ),
                    ),
                  ),
                  Consumer<ProfileProvider>(
                    builder: (context, provider, child) {
                      /// Still Working in it
                      // delaySeconds(
                      //   2,
                      //   () => provider.editCheck(
                      //     firstNameController: firstNameController,
                      //     lastNameController: lastNameController,
                      //     phoneController: phoneController,
                      //     emailController: emailController,
                      //   ),
                      // );
                      return provider.isEditCheck == false
                          ? Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: ShowUpWidget(
                                child: CustomButton(
                                  text: LocaleKeys.editData.tr(),
                                  textColor:
                                      Theme.of(context).primaryColorLight,
                                  onPressed: () => submit(),
                                ),
                              ),
                            )
                          : const SizedBox();
                    },
                  ),
                ],
              )
            : snapshot.hasError
                ? const CustomErrorWidget()
                : const CustomLoadingWidget();
      },
    );
  }
}
