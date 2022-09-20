import '../../common/style/colors.dart';
import '../../common/style/dimens.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double height;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final bool? isOutLinedButton;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = Palette.primaryColor,
    this.textColor = Palette.kWhite,
    this.height = 50.0,
    this.width,
    this.isOutLinedButton = false,
    this.borderColor = Palette.kGrey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width ?? MediaQuery.of(context).size.width,
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                borderRadius: kBorderRadius10,
              ),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
