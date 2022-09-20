import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:easy_localization/easy_localization.dart' as localized;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'common/routes/app_router_import.gr.dart';
import 'common/routes/app_router_observer.dart';
import 'common/style/app_theme.dart';
import 'di/providers_import.dart';
import 'providers/app_provider.dart';
import 'utils/transparency_behavior_scroll.dart';

final getIt = GetIt.instance;

final getItRouter = getIt.get<AppRouter>();
final getItContext = getIt<AppRouter>().navigatorKey.currentContext;
final getItRoutePath = getIt<AppRouter>().currentPath;
const route = PageRoute<dynamic>;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MultiProvider(
        providers: ProviderSetup.providers,
        child: Consumer<AppProvider>(
          builder: (context, provider, child) {
            final router = getIt<AppRouter>();
            return MaterialApp.router(
              title: "Azooz",
              debugShowCheckedModeBanner: false,
              routerDelegate: AutoRouterDelegate(
                router,
                navigatorObservers: () => [AppRouterObserver()],
              ),
              routeInformationParser: router.defaultRouteParser(),
              routeInformationProvider: router.routeInfoProvider(),
              localizationsDelegates: [
                CountryLocalizations.delegate,
                ...context.localizationDelegates
              ],
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              builder: EasyLoading.init(builder: (context, router) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: ScrollConfiguration(
                    behavior: TransparencyBehaviorScroll(),
                    child: router!,
                  ),
                );
              }),
              theme: AppThemes.appThemeData[AppTheme.lightTheme],
            );
          },
        ),
      ),
    );
  }
}
