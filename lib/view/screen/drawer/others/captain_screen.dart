import 'dart:io';

import 'package:azooz/common/style/colors.dart';
import 'package:azooz/view/custom_widget/custom_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../../model/response/terms_model.dart';
import '../../../../providers/setting_provider.dart';
import '../../../custom_widget/custom_error_widget.dart';
import '../../../custom_widget/custom_loading_widget.dart';
import '../../../widget/drawer/others/captain_fields_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class CaptainScreenTerms extends StatefulWidget {
  static const String routeName = 'captain';

  const CaptainScreenTerms({Key? key}) : super(key: key);

  @override
  State<CaptainScreenTerms> createState() => _CaptainScreenTermsState();
}

class _CaptainScreenTermsState extends State<CaptainScreenTerms> {
  late Future<TermsModel> future;
  bool _isAgree = false;
  bool isShowAllTerms = false;

  @override
  void initState() {
    super.initState();

    future = Provider.of<SettingProvider>(context, listen: false)
        .getTermsAboutUs(context: context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            LocaleKeys.beCaptain.tr(),
            style: const TextStyle(
              color: Colors.black,
            ),
          )),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        children: [
          Text(LocaleKeys.serviceProviderTerms.tr()),
          FutureBuilder<TermsModel>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Consumer<SettingProvider>(
                    builder: (context, provider, child) {
                      final data = provider.termsModel.result;
                      final fullTerms = data!.termsAndPolicies!.cTerms;
                      final shortTerms =
                          data.termsAndPolicies!.cTerms!.substring(0, 99);
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                text: isShowAllTerms
                                    ? "$fullTerms..."
                                    : "$shortTerms...",
                              ),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1000,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isShowAllTerms = !isShowAllTerms;
                              });
                            },
                            child: isShowAllTerms
                                ? const Text(
                                    "Show Less",
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  )
                                : const Text(
                                    "Show More",
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              } else {
                return snapshot.hasError
                    ? const CustomErrorWidget()
                    : const CustomLoadingWidget();
              }
            },
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Text(LocaleKeys.confirmAndAccept.tr()),
          Row(
            children: [
              Checkbox(
                value: _isAgree,
                onChanged: (val) {
                  if (mounted) {
                    setState(() {
                      _isAgree = val ?? false;
                    });
                  }
                },
                fillColor: MaterialStateProperty.all(
                  Palette.primaryColor,
                ),
              ),
              Text(
                LocaleKeys.acceptAzoozTerms.tr(),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: Palette.primaryColor),
              ),
            ],
          ),
          if (_isAgree) ...[
            const SizedBox(height: 10),
            CustomButton(
              width: MediaQuery.of(context).size.width * 0.94,
              text: LocaleKeys.next.tr(),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return const CaptainDataScreen();
                    },
                  ),
                );
              },
            ),
          ]
        ],
      ),
    );
  }
}

class CaptainDataScreen extends StatefulWidget {
  const CaptainDataScreen({Key? key}) : super(key: key);

  @override
  State<CaptainDataScreen> createState() => _CaptainDataScreenState();
}

class _CaptainDataScreenState extends State<CaptainDataScreen> {
  File? profileImage;

  pickDriverPic() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    profileImage = File(result!.files.first.path.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              LocaleKeys.beCaptain.tr(),
              style: const TextStyle(
                color: Colors.black,
              ),
            )),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  // Profile image
                  const SizedBox(height: 20),
                  Text(LocaleKeys.personalImage.tr()),
                  const SizedBox(height: 7),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            color: Palette.primaryColor,
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: profileImage == null
                              ? Image.asset("assets/images/azooz_logo.png")
                              : Image.file(
                                  profileImage!,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 100 / 3,
                        right: -10,
                        child: GestureDetector(
                          onTap: pickDriverPic,
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            decoration: const BoxDecoration(
                              color: Palette.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  const CaptainFieldsWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
