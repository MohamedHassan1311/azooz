import 'package:flutter/material.dart';

import '../../../../common/config/assets.dart';
import '../../../../common/style/colors.dart';
import '../../../custom_widget/custom_background_widget.dart';
import '../../../custom_widget/marquee_widget.dart';
import '../../../custom_widget/vertical_divider_widget.dart';

class PaymentItemWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function()? onPressedEdit;
  final Function()? onPressedDelete;

  const PaymentItemWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    this.onPressedEdit,
    this.onPressedDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBackgroundWidget(
      color: Palette.activeWidgetsColor,
      marginTop: 12,
      padding: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: mastercardSVG,
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MarqueeWidget(
                          child: Text(
                            title,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        MarqueeWidget(
                          child: Text(
                            // "${subtitle.substring(14, 16)}*************${subtitle.substring(0, 3)}",
                            "${subtitle.substring(0, 3)} ***************",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const VerticalDividerCutsWidget(
                height: 45,
                width: 5,
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: onPressedDelete,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                    ),
                    child: const Icon(
                      Icons.delete,
                      color: Palette.errorColor,
                      size: 20,
                    ),
                  ),
                  TextButton(
                    onPressed: onPressedEdit,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Palette.secondaryLight,
                      size: 20,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
