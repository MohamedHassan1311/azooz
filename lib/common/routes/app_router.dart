part of 'app_router_import.dart';

// flutter pub run build_runner watch --delete-conflicting-outputs
// OR (build => run once & watch => auto-run)
// flutter pub run build_runner build --delete-conflicting-outputs

@CustomAutoRouter(
  transitionsBuilder: TransitionsBuilders.slideRightWithFade,
  durationInMilliseconds: 350,
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: LoginScreen.routeName,
      page: LoginScreen,
      initial: true,
      name: 'LoginScreenRoute',
    ),
    AutoRoute(
      path: OTPScreen.routeName,
      page: OTPScreen,
      name: 'OTPRoute',
    ),
    AutoRoute(
      path: RegisterScreen.routeName,
      page: RegisterScreen,
      name: 'RegisterRoute',
    ),
    AutoRoute(
      path: AuthSuccessfulScreen.routeName,
      page: AuthSuccessfulScreen,
      name: 'AuthSuccessfulRoute',
    ),
    AutoRoute(
      path: HomeScreen.routeName,
      page: HomeScreen,
      name: 'HomeRoute',
    ),
    AutoRoute(
      path: DriverScreen.routeName,
      page: DriverScreen,
      name: 'DriverRoute',
    ),
    AutoRoute(
      path: OrdersHistoryScreen.routeName,
      page: OrdersHistoryScreen,
      name: 'OrdersRoute',
    ),
    AutoRoute(
      path: ChatHistoryScreen.routeName,
      page: ChatHistoryScreen,
      name: 'MessageRoute',
    ),
    // AutoRoute(
    //   path: ProfileScreen.routeName,
    //   page: ProfileScreen,
    //   name: 'ProfileRoute',
    // ),
    AutoRoute(
      path: StoresScreen.routeName,
      page: StoresScreen,
      name: 'StoresRoute',
    ),
    AutoRoute(
      path: StoreScreen.routeName,
      page: StoreScreen,
      name: 'StoreScreenRoute',
    ),
    AutoRoute(
      path: CategoriesScreen.routeName,
      page: CategoriesScreen,
      name: 'CategoriesRoute',
    ),
    AutoRoute(
      path: MakeOrderScreen.routeName,
      page: MakeOrderScreen,
      name: 'MakeOrderRoute',
    ),
    AutoRoute(
      path: DeliveryDetailsScreen.routeName,
      page: DeliveryDetailsScreen,
      name: 'DeliveryDetailsRoute',
    ),
    AutoRoute(
      path: OrderSuccessfulScreen.routeName,
      page: OrderSuccessfulScreen,
      name: 'OrderSuccessfulRoute',
    ),
    AutoRoute(
      path: ChatScreen.routeName,
      page: ChatScreen,
      name: 'ChatScreenRoute',
    ),
    AutoRoute(
      path: OffersScreen.routeName,
      page: OffersScreen,
      name: 'OffersRoute',
    ),
    AutoRoute(
      path: OrderDetailsScreen.routeName,
      page: OrderDetailsScreen,
      name: 'OrderDetailsRoute',
    ),
    AutoRoute(
      path: OrderConfirmScreen.routeName,
      page: OrderConfirmScreen,
      name: 'OrderConfirmRoute',
    ),
    AutoRoute(
      path: AddressScreen.routeName,
      page: AddressScreen,
      name: 'AddressRoute',
    ),
    AutoRoute(
      path: AddAddressScreen.routeName,
      page: AddAddressScreen,
      name: 'AddAddressRoute',
    ),
    AutoRoute(
      path: PaymentWaysScreen.routeName,
      page: PaymentWaysScreen,
      name: 'PaymentWaysRoute',
    ),
    AutoRoute(
      path: AddPaymentWayScreen.routeName,
      page: AddPaymentWayScreen,
      name: 'AddPaymentWayRoute',
    ),
    AutoRoute(
      path: EditCardDataScreen.routeName,
      page: EditCardDataScreen,
      name: 'EditCardDataRoute',
    ),
    AutoRoute(
      path: PartnerScreen.routeName,
      page: PartnerScreen,
      name: 'PartnerRoute',
    ),
    AutoRoute(
      path: AdvertsScreen.routeName,
      page: AdvertsScreen,
      name: 'AdvertsRoute',
    ),
    AutoRoute(
      path: AddAdvertScreen.routeName,
      page: AddAdvertScreen,
      name: 'AddAdvertRoute',
    ),
    AutoRoute(
      path: CustomerServiceScreen.routeName,
      page: CustomerServiceScreen,
      name: 'CustomerServiceRoute',
    ),
    AutoRoute(
      path: AcceptConditionScreen.routeName,
      page: AcceptConditionScreen,
      name: 'AcceptConditionRoute',
    ),
    AutoRoute(
      path: EditProfileScreen.routeName,
      page: EditProfileScreen,
      name: 'EditProfileRoute',
    ),
    AutoRoute(
      path: NotificationScreen.routeName,
      page: NotificationScreen,
      name: 'NotificationRoute',
    ),
    AutoRoute(
      path: ReviewsScreen.routeName,
      page: ReviewsScreen,
      name: 'ReviewsRoute',
    ),
    AutoRoute(
      path: TermsAboutAppScreen.routeName,
      page: TermsAboutAppScreen,
      name: 'TermsAboutAppRoute',
    ),
    AutoRoute(
      path: SettingsScreen.routeName,
      page: SettingsScreen,
      name: 'SettingRoute',
    ),
    AutoRoute(
      path: LocationOnMapScreen.routeName,
      page: LocationOnMapScreen,
      name: 'LocationOnMapRoute',
    ),
    AutoRoute(
      path: CaptainScreenTerms.routeName,
      page: CaptainScreenTerms,
      name: 'CaptainRoute',
    ),
    AutoRoute(
      path: CategoriesHomeScreen.routeName,
      page: CategoriesHomeScreen,
      name: 'CategoriesHomeRoute',
    ),
    AutoRoute(
      path: DepartmentsHomeScreen.routeName,
      page: DepartmentsHomeScreen,
      name: 'DepartmentsHomeRoute',
    ),
    AutoRoute(
      path: AdsHomeScreen.routeName,
      page: AdsHomeScreen,
      name: 'AdsHomeRoute',
    ),
    AutoRoute(
      path: NavigationManager.routeName,
      page: NavigationManager,
      name: 'NavigationManagerRoute',
    ),
    AutoRoute(
      path: PaymentScreen.routeName,
      page: PaymentScreen,
      name: 'PaymentScreenRoute',
    ),
    AutoRoute(
      path: SplashScreen.routeName,
      page: SplashScreen,
      name: 'SplashScreenRoute',
    ),
    AutoRoute(
      path: TripDetailsScreen.routeName,
      page: TripDetailsScreen,
      name: 'TripDetailsScreenRoute',
    ),
    AutoRoute(
      path: OrderConfirmationScreen.routeName,
      page: OrderConfirmationScreen,
      name: 'OrderConfirmationScreenRoute',
    ),
  ],
)
class $AppRouter {}
