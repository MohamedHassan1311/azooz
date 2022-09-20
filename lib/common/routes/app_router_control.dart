import 'package:flutter/material.dart';

import '../../view/screen/home/home_screen.dart';
import 'package:auto_route/auto_route.dart';

Future<T?> routerPush<T extends Object?>({
  required BuildContext context,
  required PageRouteInfo route,
}) =>
    AutoRouter.of(context).push(route);

Future<T?> routerPushAndPopUntil<T extends Object?>({
  required BuildContext context,
  required PageRouteInfo route,
}) =>
    AutoRouter.of(context).pushAndPopUntil(
      route,
      predicate: (route) => route.settings.name == HomeScreen.routeName,
    );

Future<T?> routerReplace<T extends Object?>({
  required BuildContext context,
  required PageRouteInfo route,
}) =>
    AutoRouter.of(context).replace(
      route,
    );

routerPopUntil({
  required BuildContext context,
  required PageRouteInfo route,
}) =>
    AutoRouter.of(context).popUntil(
      (route) => route.settings.name == HomeScreen.routeName,
    );

routerPopRoot({
  required BuildContext context,
  required PageRouteInfo route,
}) =>
    AutoRouter.of(context).popUntilRoot();

Future<bool> routerPop<T extends Object?>(BuildContext context, [T? result]) =>
    AutoRouter.of(context).pop(result);

Future<bool> routerPopTop<T extends Object?>(BuildContext context,
        [T? result]) =>
    AutoRouter.of(context).popTop(result);

routerPopForced<T extends Object?>(BuildContext context, [T? result]) =>
    AutoRouter.of(context).popForced(result);
