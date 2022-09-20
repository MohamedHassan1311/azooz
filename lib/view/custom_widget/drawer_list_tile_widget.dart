import 'package:flutter/material.dart';

class DrawerListTileWidget extends StatelessWidget {
  final Widget? icon;
  final String? title;
  final double? horizontal;
  final double? vertical;
  final Function()? onTap;

  const DrawerListTileWidget({
    Key? key,
    required this.icon,
    required this.title,
    this.horizontal = 12,
    this.vertical = 6,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal!,
          vertical: vertical!,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 15,
              height: 15,
              child: icon,
            ),
            const SizedBox(width: 10),
            Text(
              title!,
              style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
