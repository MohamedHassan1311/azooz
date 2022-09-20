import '../../../../common/style/dimens.dart';
import '../../../../providers/address_provider.dart';
import '../../../custom_widget/custom_search_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressSearchWidget extends StatefulWidget {
  const AddressSearchWidget({Key? key}) : super(key: key);

  @override
  State<AddressSearchWidget> createState() => _AddressSearchWidgetState();
}

class _AddressSearchWidgetState extends State<AddressSearchWidget> {
  final TextEditingController _typeAheadController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _typeAheadController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: edgeInsetsSymmetric(horizontal: 15.0),
      child: CustomSearchFormWidget(
        withShadow: false,
        suggestionsCallback: (pattern) {
          return [];
        },
        withSuggestion: false,
        controller: _typeAheadController,
        validatorText: '',
        onChanged: (value) {
          Provider.of<AddressProvider>(context, listen: false)
              .filterAddress(value);
        },
        onSubmitted: (value) {
          Provider.of<AddressProvider>(context, listen: false)
              .filterAddress(value);
        },
      ),
    );
  }
}
