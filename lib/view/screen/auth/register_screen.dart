import 'package:azooz/utils/smart_text_inputs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';

import '../../../common/config/tools.dart';
import '../../../common/style/colors.dart';
import '../../../common/style/dimens.dart';
import '../../../common/style/style.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../model/response/city_model.dart';
import '../../../model/response/gender_model.dart';
import '../../../model/response/region_model.dart';
import '../../../providers/city_region_provider.dart';
import '../../../providers/gender_provider.dart';
import '../../../providers/register_provider.dart';
import '../../../utils/dialogs.dart';
import '../../custom_widget/custom_button.dart';
import '../../custom_widget/custom_error_widget.dart';
import '../../custom_widget/custom_loading_widget.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = 'register';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late Future<GenderModel> futureGender;
  late Future<RegionModel> futureRegion;
  late Future<CityModel> futureCity;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureGender = Provider.of<GenderProvider>(context, listen: false)
        .getGenderData(context: context);
    futureRegion = Provider.of<CityRegionProvider>(context, listen: false)
        .getRegion(context: context);
    Provider.of<RegisterProvider>(context, listen: false).context = context;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  submit() {
    Tools.hideKeyboard(context);

    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        Provider.of<RegisterProvider>(context, listen: false)
            .birthDate!
            .isEmpty ||
        Provider.of<RegisterProvider>(context, listen: false).selectedGender ==
            null ||
        Provider.of<RegisterProvider>(context, listen: false).selectedCity ==
            null) {
      errorDialog(context, LocaleKeys.pleaseInputFillAllFields.tr());
    } else {
      Provider.of<RegisterProvider>(context, listen: false).putData(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return KeyboardDismisser(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: edgeInsetsOnly(top: 55, bottom: 15),
                  child: Text(
                    LocaleKeys.createAnAccount.tr(),
                    style: headline1,
                  ),
                ),
                Column(
                  children: [
                    SmartInputTextField(
                      label: "",
                      hasLabel: false,
                      fillColor: Palette.kSelectorColor,
                      textCapitalization: TextCapitalization.words,
                      controller: firstNameController,
                      hintText: LocaleKeys.firstName.tr(),
                    ),
                    const SizedBox(height: 10.0),
                    SmartInputTextField(
                      label: "",
                      hasLabel: false,
                      fillColor: Palette.kSelectorColor,
                      textCapitalization: TextCapitalization.words,
                      hintText: LocaleKeys.lastName.tr(),
                      controller: lastNameController,
                    ),
                    const SizedBox(height: 10.0),
                    SmartInputTextField(
                      label: "",
                      hasLabel: false,
                      fillColor: Palette.kSelectorColor,
                      hintText: LocaleKeys.email.tr(),
                      textInputType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                    const SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: () async {
                        context
                            .read<RegisterProvider>()
                            .openDateTimePicker(context);
                      },
                      child: Container(
                        height: 50,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Palette.activeWidgetsColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            sizedBox(width: screenHeight * 0.014),
                            const Icon(
                              Icons.event,
                              color: Palette.secondaryLight,
                            ),
                            sizedBox(width: screenHeight * 0.013),
                            Consumer<RegisterProvider>(
                              builder: (context, provider, child) {
                                return Text(
                                  provider.birthDate.toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    FutureBuilder<GenderModel>(
                      future: futureGender,
                      builder: (context, snapshot) => snapshot.hasData
                          ? Consumer<RegisterProvider>(
                              builder: (context, provider, child) {
                                return SmartDropDownField(
                                  label: "",
                                  hasLabel: false,
                                  fillColor: Palette.kSelectorColor,
                                  value: provider.selectedGender,
                                  isExpanded: true,
                                  icon: Icons.keyboard_arrow_down_outlined,
                                  placeHolder: "حدد النوع",
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
                                    LocaleKeys.type.tr(),
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
                    const SizedBox(height: 10.0),
                    FutureBuilder<RegionModel>(
                      future: futureRegion,
                      builder: (context, snapshot) => snapshot.hasData
                          ? Consumer<RegisterProvider>(
                              builder: (context, provider, child) {
                                return SmartDropDownField(
                                  label: "",
                                  hasLabel: false,
                                  value: provider.selectedRegion,
                                  placeHolder: "حدد المنطقة",
                                  fillColor: Palette.kSelectorColor,
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
                    const SizedBox(height: 10.0),
                    Provider.of<RegisterProvider>(context).isRegionSelected ==
                            true
                        ? FutureBuilder<CityModel>(
                            future: Provider.of<RegisterProvider>(context,
                                    listen: false)
                                .futureCity,
                            builder: (context, snapshot) => snapshot.hasData
                                ? Consumer<RegisterProvider>(
                                    builder: (context, provider, child) {
                                      return SmartDropDownField(
                                        label: "",
                                        hasLabel: false,
                                        value: provider.selectedCity,
                                        fillColor: Palette.kSelectorColor,
                                        icon:
                                            Icons.keyboard_arrow_down_outlined,
                                        placeHolder: "حدد المدينة",
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
                          )
                        : const SizedBox(),
                    const SizedBox(height: 10),
                    CustomButton(
                      text: LocaleKeys.next.tr(),
                      onPressed: () => submit(),
                    ),
                    const SizedBox(height: 20),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomInputTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(dynamic)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLength;
  final FocusNode? focusNode;
  final String? hintText;
  final int? maxLines;
  final String? errorText;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Color? fillColor;
  final bool? filled;
  final bool? readOnly;
  final TextAlign textAlign;
  final TextStyle? hintStyle;
  final bool? obscureText;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final Function()? onEditingComplete;
  final TextAlignVertical? textAlignVertical;
  final TextInputAction? textInputAction;
  final bool? withUnderlineBorder;
  final bool? isDense;
  final EdgeInsetsGeometry? contentPadding;
  final TextCapitalization textCapitalization;

  const CustomInputTextField({
    Key? key,
    this.controller,
    this.onChanged,
    this.validator,
    this.errorText,
    this.onEditingComplete,
    this.maxLength,
    this.autofillHints,
    this.focusNode,
    this.inputFormatters,
    this.maxLines = 1,
    this.hintText,
    this.hintStyle,
    this.prefixWidget,
    this.suffixWidget,
    this.textAlign = TextAlign.start,
    this.readOnly = false,
    this.filled = false,
    this.fillColor = Palette.kOffWhite,
    this.obscureText = false,
    this.textInputType,
    this.contentPadding = EdgeInsets.zero,
    this.textAlignVertical = TextAlignVertical.center,
    this.textInputAction = TextInputAction.done,
    this.withUnderlineBorder = false,
    this.isDense = false,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      focusNode: focusNode,
      cursorColor: Palette.kBlack,
      readOnly: readOnly!,
      controller: controller,
      autofillHints: autofillHints,
      onChanged: onChanged,
      textInputAction: textInputAction,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      keyboardType: textInputType,
      onEditingComplete: onEditingComplete,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        prefix: prefixWidget,
        suffix: suffixWidget,
        hintText: hintText,

        filled: true,
        fillColor: Palette.activeWidgetsColor,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide.none,
        ),
        // border: InputBorder.none,
      ),
      maxLength: maxLength,
      maxLines: maxLines,
      obscureText: obscureText!,
      validator: validator,
    );
  }
}

class CustomDropDownField extends StatelessWidget {
  final List<DropdownMenuItem<dynamic>>? items;
  final dynamic value;
  final Widget? hint;
  final Function(dynamic)? onChanged;
  final int? elevation;
  final double? iconSize;
  final bool? withUnderLine;
  final bool? isDense;
  final bool? isExpanded;
  final bool? alignedDropdown;
  final IconData? icon;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final Color? iconColor;
  final String? placeHolder;

  const CustomDropDownField({
    Key? key,
    required this.items,
    this.value,
    this.hint,
    required this.onChanged,
    this.prefixIcon,
    this.prefixIconColor = Colors.grey,
    this.iconColor = Colors.grey,
    this.elevation = 8,
    this.icon = Icons.arrow_drop_down,
    this.iconSize = 24.0,
    this.isDense = true,
    this.isExpanded = true,
    this.alignedDropdown = true,
    this.withUnderLine = false,
    this.placeHolder = "",
  })  : assert(items != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Palette.activeWidgetsColor,
        prefixIcon: Icon(
          prefixIcon,
          color: Palette.primaryColor,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide.none,
        ),
      ),
      elevation: elevation!,
      items: items,
      isExpanded: false,
      iconSize: iconSize!,
      icon: Icon(icon, color: iconColor),
      onChanged: onChanged,
      hint: hint,
      style: const TextStyle(
        color: Colors.black,
      ),
    );
  }
}
