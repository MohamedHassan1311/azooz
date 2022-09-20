import '../../../../common/style/dimens.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/response/terms_model.dart';
import '../../../../model/screen_argument/terms_about_app_argument.dart';
import '../../../../providers/setting_provider.dart';
import '../../../custom_widget/custom_error_widget.dart';
import '../../../custom_widget/custom_loading_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TermsAboutAppScreen extends StatefulWidget {
  static const routeName = 'terms_about_app';

  final TermsAboutAppArgument argument;

  const TermsAboutAppScreen({Key? key, required this.argument})
      : super(key: key);

  @override
  State<TermsAboutAppScreen> createState() => _TermsAboutAppScreenState();
}

class _TermsAboutAppScreenState extends State<TermsAboutAppScreen> {
  late Future<TermsModel> future;

  @override
  void initState() {
    super.initState();

    future = Provider.of<SettingProvider>(context, listen: false)
        .getTermsAboutUs(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: widget.argument.isTerms == true
            ? Text(LocaleKeys.terms.tr())
            : Text(LocaleKeys.aboutUS.tr()),
      ),
      body: SafeArea(
        child: Padding(
          padding: edgeInsetsSymmetric(horizontal: 8),
          child: Column(
            children: [
              FutureBuilder<TermsModel>(
                future: future,
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? Expanded(
                          child: SingleChildScrollView(
                            child: Center(
                              child: Consumer<SettingProvider>(
                                builder: (context, provider, child) {
                                  final data = provider.termsModel.result;
                                  return Text.rich(
                                    TextSpan(
                                      text: widget.argument.isTerms == true
                                          ? '${data!.termsAndPolicies!.terms} ${data.termsAndPolicies!.policy}'
                                          : data!.termsAndPolicies!.aboutUs,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 20,
                                    overflow: TextOverflow.ellipsis,
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      : snapshot.hasError
                          ? const CustomErrorWidget()
                          : const CustomLoadingWidget();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
