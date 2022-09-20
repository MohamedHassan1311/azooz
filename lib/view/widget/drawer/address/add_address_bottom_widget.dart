import 'package:azooz/utils/dialogs.dart';

import '../../../../common/config/tools.dart';
import '../../../../common/style/colors.dart';
import '../../../../common/style/dimens.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/request/add_address_model.dart';
import '../../../../model/request/edit_address_model.dart';
import '../../../../model/screen_argument/address_argument.dart';
import '../../../../providers/address_provider.dart';
import '../../../custom_widget/custom_button.dart';
import '../../../custom_widget/custom_text_field_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AddAddressBottomWidget extends StatefulWidget {
  final AddressArgument? argument;

  const AddAddressBottomWidget({Key? key, required this.argument})
      : super(key: key);

  @override
  State<AddAddressBottomWidget> createState() => _AddAddressBottomWidgetState();
}

class _AddAddressBottomWidgetState extends State<AddAddressBottomWidget> {
  final TextEditingController? controllerTitle = TextEditingController();
  final TextEditingController? controllerDetails = TextEditingController();

  resultRefresh() {
    final provider = Provider.of<AddressProvider>(context, listen: false);
    provider.disposeData();
    provider.isLoading(true);
  }

  submit() async {
    Tools.hideKeyboard(context);
    var provider = await Provider.of<AddressProvider>(context, listen: false);
    if (controllerDetails!.text.trim().isEmpty ||
        controllerTitle!.text.trim().isEmpty) {
      // errorDialog(context,  LocaleKeys.pleaseInputFillAllFields.tr());
      errorDialog(context, LocaleKeys.pleaseInputFillAllFields.tr());
    } else if (provider.hasMarker == false) {
      errorDialog(context, LocaleKeys.setMarkerOnMap.tr());
    } else {
      if (widget.argument!.newAddress == false) {
        await provider
            .editAddress(
          editAddressModel: EditAddressModel(
            lat: provider.position?.latitude ?? widget.argument!.lat,
            lng: provider.position?.longitude ?? widget.argument!.lng,
            details: controllerDetails?.text.trim() ?? widget.argument!.details,
            id: widget.argument!.id,
            title: controllerTitle?.text.trim() ?? widget.argument!.title,
          ),
          context: context,
        )
            .then((value) {
          // return resultRefresh();
        });
      } else {
        await provider
            .addAddress(
          addAddressModel: AddAddressModel(
            lat: provider.position?.latitude ?? 0,
            lng: provider.position?.longitude ?? 0,
            details: controllerDetails?.text.trim() ?? '',
            title: controllerTitle?.text.trim() ?? '',
          ),
          context: context,
        )
            .then((value) {
          // return resultRefresh();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.argument!.newAddress == false) {
      controllerDetails!.text = widget.argument!.details!;
      controllerTitle!.text = widget.argument!.title!;
    } else {
      controllerDetails!.clear();
      controllerTitle!.clear();
    }
  }

  @override
  void dispose() {
    controllerDetails?.dispose();
    controllerTitle?.dispose();
    super.dispose();
  }

  // Future<List<Placemark>> getCurrentAddress() async {
  //   final provider = Provider.of<AddressProvider>(context, listen: false);
  //   final currentPosition = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   print("### & ${provider.position}");
  //   if (provider.position == null ||
  //       provider.position == const LatLng(0.0, 0.0)) {
  //

  //     return placemarkFromCoordinates(
  //       currentPosition.latitude,
  //       currentPosition.longitude,
  //     );
  //   } else {
  //     return await placemarkFromCoordinates(
  //       provider.position!.latitude,
  //       provider.position!.longitude,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: edgeInsetsOnly(
        top: 30,
        start: 30,
        end: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Selector<AddressProvider, String>(
            selector: (p0, p1) => p1.selectedName,
            builder: (context, val, child) {
              return SizedBox(
                height: 30,
                child: Row(
                  children: [
                    const Icon(
                      Icons.place,
                      color: Palette.primaryColor,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        val.toString(),
                        maxLines: 2,
                        style: TextStyle(
                          color: Palette.primaryColor.withOpacity(0.7),
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 7),
          CustomTextFieldWidget(
            hintText: LocaleKeys.address.tr(),
            textAlign: TextAlign.start,
            withUnderlineBorder: true,
            isDense: true,
            controller: controllerTitle,
          ),
          const SizedBox(height: 10),
          CustomTextFieldWidget(
            hintText: LocaleKeys.details.tr(),
            textAlign: TextAlign.start,
            withUnderlineBorder: true,
            isDense: true,
            controller: controllerDetails,
          ),
          const SizedBox(height: 10),
          CustomButton(
            text: LocaleKeys.save.tr(),
            onPressed: submit,
            width: MediaQuery.of(context).size.width * 0.90,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
