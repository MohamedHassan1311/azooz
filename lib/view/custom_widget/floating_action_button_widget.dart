import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../common/routes/app_router_control.dart';
import '../../common/style/colors.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  final PageRouteInfo? route;
  final bool? isRoute;
  final Function()? onPressed;

  const FloatingActionButtonWidget({
    Key? key,
    required this.route,
    this.isRoute = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Palette.primaryColor,
      onPressed: isRoute == false
          ? () => routerPush(
                context: context,
                route: route!,
              )
          : onPressed,
      child: const Icon(Icons.add),
    );
  }
}
