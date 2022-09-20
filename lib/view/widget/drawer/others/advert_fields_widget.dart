import 'dart:io';

import 'package:azooz/utils/smart_text_inputs.dart';

import '../../../../common/config/tools.dart';
import '../../../../common/style/colors.dart';
import '../../../../common/style/style.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/response/vehicle_type_model.dart';
import '../../../../model/screen_argument/add_advert_argument.dart';
import '../../../../model/screen_argument/address_argument.dart';
import '../../../../providers/advertisement_provider.dart';
import '../../../../utils/dialogs.dart';
import '../../../custom_widget/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../screen/drawer/address/address_screen.dart';
import '../../image_viewer.dart';

class AdvertFieldsWidget extends StatefulWidget {
  final AddAdvertArgument argument;

  const AdvertFieldsWidget({Key? key, required this.argument})
      : super(key: key);

  @override
  AdvertFieldsWidgetState createState() => AdvertFieldsWidgetState();
}

class AdvertFieldsWidgetState extends State<AdvertFieldsWidget> {
  // String selectedType = '';

  late Future<VehicleTypeModel> future;

  File? image;

  LatLng? position;

  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  late final AdvertisementProvider provider;
  String? imagePath = '';

  @override
  void initState() {
    super.initState();

    provider = Provider.of<AdvertisementProvider>(context, listen: false);

    // future = Provider.of<SettingProvider>(context, listen: false)
    //     .getVehicleType(context: context)
    //     .then(
    //   (value) {
    //     if (widget.argument.isNew == true) {
    //       selectedType = value.result!.vehicleType!.first.name!;
    //     }
    //     return Future.value(value);
    //   },
    // );
    if (widget.argument.isNew == false) {
      addressController.text = widget.argument.address!;
      contactNumberController.text = widget.argument.contactNumber!;
      priceController.text = widget.argument.price.toString();
      detailsController.text = widget.argument.details!;
      imagePath = widget.argument.image;
      // selectedType = widget.argument.vehicle!;
    }
  }

  pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      image = File(result!.files.first.path.toString());
      imagePath = image!.path;
      setState(() {});
    } catch (error) {
      print(error);
    }
  }

  addNewAds() async {
    Tools.hideKeyboard(context);

    if (widget.argument.isNew == true) {
      if (addressController.text.trim().isNotEmpty &&
          contactNumberController.text.trim().isNotEmpty &&
          detailsController.text.trim().isNotEmpty &&
          imagePath!.trim().isNotEmpty) {
        provider
            .addAdvertisement(
          address: addressController.text.trim(),
          contactNumber: contactNumberController.text.trim(),
          details: detailsController.text.trim(),
          favoriteLocationId: context.read<AdvertisementProvider>().locationId,
          whatsappNumber: "",
          context: context,
          imagePath: imagePath,
        )
            .then((value) {
          contactNumberController.clear();
          addressController.clear();
          detailsController.clear();
          imagePath = '';
          image = null;
        });
      } else {
        errorDialog(context, LocaleKeys.pleaseInputFillAllFields.tr());
      }
    } else {
      provider.editAdvertisement(
        id: widget.argument.id,
        address: addressController.text.trim(),
        contactNumber: contactNumberController.text.trim(),
        details: detailsController.text.trim(),
        price: double.parse(priceController.text.trim()),
        context: context,
        lat: provider.position?.latitude,
        lng: provider.position?.longitude,
        imagePath: image?.path ?? '',
      );
    }
  }

  @override
  void dispose() {
    contactNumberController.dispose();
    detailsController.dispose();
    addressController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Palette.secondaryDark,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmartInputTextField(
              label: LocaleKeys.advertisementAddress.tr(),
              hintText: LocaleKeys.advertisementAddress.tr(),
              textAlign: TextAlign.start,
              withUnderlineBorder: true,
              isDense: true,
              controller: addressController,
            ),
            SmartInputTextField(
              label: LocaleKeys.contactNumber.tr(),
              hintText: LocaleKeys.contactNumber.tr(),
              textAlign: TextAlign.start,
              withUnderlineBorder: true,
              isDense: true,
              controller: contactNumberController,
              inputFormatters: Tools.digitsOnlyFormatter(),
              textInputType: TextInputType.phone,
            ),
            SmartInputTextField(
              label: LocaleKeys.advertisementDetails.tr(),
              hintText: LocaleKeys.advertisementDetails.tr(),
              textAlign: TextAlign.start,
              withUnderlineBorder: true,
              isDense: true,
              controller: detailsController,
              maxLines: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text("حدد مدة الإعلان"),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showDatePicker(
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
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 5),
                          ).then((value) {
                            if (value != null) {
                              var formatedDate = DateFormat("yyyy-MM-dd")
                                  .format(value)
                                  .toString();

                              provider.setFrom(formatedDate);
                            }
                          });
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
                                const Icon(Icons.date_range_outlined, size: 17),
                                const SizedBox(width: 3),
                                Text(
                                  "من",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
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
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showDatePicker(
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
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 5),
                          ).then((value) {
                            if (value != null) {
                              var formatedDate = DateFormat("yyyy-MM-dd")
                                  .format(value)
                                  .toString();
                              provider.setTo(formatedDate);
                            }
                          });
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
                                const Icon(Icons.date_range, size: 17),
                                const SizedBox(width: 3),
                                Text(
                                  "إلى",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
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
                Row(
                  children: [
                    Consumer<AdvertisementProvider>(
                        builder: (context, provider, child) {
                      if (provider.fromDate == null) {
                        return const SizedBox();
                      }
                      return Expanded(
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 67, 239, 84)
                                .withOpacity(0.1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Text(provider.fromDate.toString()),
                        ),
                      );
                    }),
                    const SizedBox(width: 10),
                    Consumer<AdvertisementProvider>(
                        builder: (context, provider, child) {
                      if (provider.toDate == null) {
                        return const SizedBox();
                      }
                      return Expanded(
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 67, 144, 239)
                                .withOpacity(0.1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Text(provider.toDate.toString()),
                        ),
                      );
                    }),
                  ],
                ),

                // Consumer<AdvertisementProvider>(
                //     builder: (context, provider, child) {
                //   if (provider.fromDate == null || provider.toDate == null) {
                //     return const SizedBox();
                //   }
                //   return
                //    Row(
                //     children: [
                //       Consumer<AdvertisementProvider>(
                //           builder: (context, provider, child) {
                //         return Expanded(
                //           child: Container(
                //             height: 50,
                //             alignment: Alignment.center,
                //             padding: const EdgeInsets.symmetric(
                //               horizontal: 5,
                //               vertical: 7,
                //             ),
                //             decoration: BoxDecoration(
                //               color: const Color.fromARGB(255, 67, 239, 84)
                //                   .withOpacity(0.1),
                //               borderRadius: const BorderRadius.all(
                //                 Radius.circular(10),
                //               ),
                //             ),
                //             child: Text(provider.fromDate.toString()),
                //           ),
                //         );
                //       }),
                //       const SizedBox(width: 10),
                //       Consumer<AdvertisementProvider>(
                //           builder: (context, provider, child) {
                //         return Expanded(
                //           child: Container(
                //             height: 50,
                //             alignment: Alignment.center,
                //             padding: const EdgeInsets.symmetric(
                //               horizontal: 5,
                //               vertical: 7,
                //             ),
                //             decoration: BoxDecoration(
                //               color: const Color.fromARGB(255, 67, 144, 239)
                //                   .withOpacity(0.1),
                //               borderRadius: const BorderRadius.all(
                //                 Radius.circular(10),
                //               ),
                //             ),
                //             child: Text(provider.toDate.toString()),
                //           ),
                //         );
                //       }),
                //     ],
                //   );
                // }),

                const SizedBox(height: 10),

                const Text("إختار عنوان للإعلان"),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return const AddressScreen(
                            argument: AddressArgument(
                              newAddress: false,
                              fromOrdersDetails: false,
                              fromAdsScreen: true,
                            ),
                          );
                        },
                      ),
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
                          const Icon(Icons.location_on_outlined, size: 17),
                          const SizedBox(width: 3),
                          Text(
                            LocaleKeys.addresses.tr(),
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Ads Location details
                Consumer<AdvertisementProvider>(
                  builder: (context, address, child) {
                    if (address.selectedAdsDetails.isEmpty) {
                      return const SizedBox();
                    }
                    return Column(
                      children: [
                        const SizedBox(height: 5),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Palette.primaryColor.withOpacity(0.1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                address.selectedAdsName,
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                address.selectedAdsDetails,
                                style: const TextStyle(fontSize: 14),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    size: 17,
                                  ),
                                  const SizedBox(width: 3),
                                  Expanded(
                                    child: Text(
                                      address.selectedAdsPlace,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(LocaleKeys.addImage.tr()),
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
            const SizedBox(height: 20),
            CustomButton(
              height: 45,
              text: LocaleKeys.save.tr(),
              onPressed: addNewAds,
              width: MediaQuery.of(context).size.width * 0.90,
            ),
          ],
        ),
      ),
    );
  }
}
