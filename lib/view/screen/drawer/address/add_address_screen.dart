import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../../model/screen_argument/address_argument.dart';
import '../../../widget/drawer/address/add_address_widget.dart';

class AddAddressScreen extends StatefulWidget {
  static const routeName = 'add_address';
  final AddressArgument? argument;

  const AddAddressScreen({
    Key? key,
    this.argument,
  }) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.argument!.newAddress == true
            ? Text(LocaleKeys.addAddresses.tr())
            : Text(LocaleKeys.editAddresses.tr()),
      ),
      body: SafeArea(
        child: AddAddressWidget(argument: widget.argument),
      ),
    );
  }
}
