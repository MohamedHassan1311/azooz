import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../generated/locale_keys.g.dart';

/// pageID 1 => OrderHistory
/// PageID 2 => PaymentWays

enum Select { first, second }

ValueNotifier<bool> selectedSwitch = ValueNotifier(false);

String selectedType = '';

class AnimatedSwitcherWidget extends StatefulWidget {
  final bool? withChoices;
  final bool? withSearchAndSelect;
  final String? title1;
  final String? title2;
  final int? pageID;
  final double? top;
  final double? bottom;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final Function(dynamic)? onChangedDropDown;

  const AnimatedSwitcherWidget({
    Key? key,
    this.withChoices = true,
    this.withSearchAndSelect = true,
    required this.title1,
    required this.title2,
    required this.pageID,
    this.bottom = 3,
    this.top = 10,
    this.onSubmitted,
    this.onChanged,
    this.onChangedDropDown,
  }) : super(key: key);

  @override
  State<AnimatedSwitcherWidget> createState() => _AnimatedSwitcherWidgetState();
}

class _AnimatedSwitcherWidgetState extends State<AnimatedSwitcherWidget>
    with WidgetsBindingObserver {
  List types = [
    LocaleKeys.talabat.tr(),
    LocaleKeys.meshwar.tr(),
  ];
  Map<int, Widget> myTabs = {};

  @override
  void initState() {
    super.initState();
    selectedType = types.first;
    myTabs = <int, Widget>{
      0: Text(widget.title1.toString()),
      1: Text(widget.title2.toString()),
    };
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: widget.top!, bottom: widget.bottom!),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: screenHeight * 0.09,
            width: screenWidth * 0.7,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedSwitch.value = !selectedSwitch.value;
                  print('Selected: ${selectedSwitch.value}');
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title1!,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    widget.title2!,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
