// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i42;
import 'package:flutter/material.dart' as _i43;

import '../../model/response/login_model.dart' as _i44;
import '../../model/screen_argument/add_advert_argument.dart' as _i52;
import '../../model/screen_argument/add_payment_ways_argument.dart' as _i51;
import '../../model/screen_argument/address_argument.dart' as _i50;
import '../../model/screen_argument/categories_argument.dart' as _i46;
import '../../model/screen_argument/make_order_argument.dart' as _i47;
import '../../model/screen_argument/order_confirm_argument.dart' as _i49;
import '../../model/screen_argument/order_details_argument.dart' as _i48;
import '../../model/screen_argument/store_argument.dart' as _i45;
import '../../model/screen_argument/terms_about_app_argument.dart' as _i53;
import '../../view/screen/auth/auth_successful_screen.dart' as _i4;
import '../../view/screen/auth/login_screen.dart' as _i1;
import '../../view/screen/auth/otp_screen.dart' as _i2;
import '../../view/screen/auth/register_screen.dart' as _i3;
import '../../view/screen/drawer/address/add_address_screen.dart' as _i20;
import '../../view/screen/drawer/address/address_screen.dart' as _i19;
import '../../view/screen/drawer/others/accept_condition_screen.dart' as _i28;
import '../../view/screen/drawer/others/add_advert_screen.dart' as _i26;
import '../../view/screen/drawer/others/adverts_screen.dart' as _i25;
import '../../view/screen/drawer/others/captain_screen.dart' as _i35;
import '../../view/screen/drawer/others/customer_service_screen.dart' as _i27;
import '../../view/screen/drawer/others/edit_profile_screen.dart' as _i29;
import '../../view/screen/drawer/others/partner_screen.dart' as _i24;
import '../../view/screen/drawer/others/reviews_screen.dart' as _i31;
import '../../view/screen/drawer/others/setting_screen.dart' as _i33;
import '../../view/screen/drawer/others/terms_about_app_screen.dart' as _i32;
import '../../view/screen/drawer/payment/add_payment_way_screen.dart' as _i22;
import '../../view/screen/drawer/payment/edit_card_data_screen.dart' as _i23;
import '../../view/screen/drawer/payment/payment_ways_screen.dart' as _i21;
import '../../view/screen/home/ads_home_screen.dart' as _i38;
import '../../view/screen/home/categories_home_screen.dart' as _i36;
import '../../view/screen/home/chat_history_screen.dart' as _i8;
import '../../view/screen/home/chat_screen.dart' as _i15;
import '../../view/screen/home/departments_home_screen.dart' as _i37;
import '../../view/screen/home/driver_screen.dart' as _i6;
import '../../view/screen/home/home_screen.dart' as _i5;
import '../../view/screen/home/navigation_manager.dart' as _i39;
import '../../view/screen/home/notification_screen.dart' as _i30;
import '../../view/screen/home/orders_history_screen.dart' as _i7;
import '../../view/screen/home/stores_screen.dart' as _i9;
import '../../view/screen/location_on_map_screen.dart' as _i34;
import '../../view/screen/order/delivery_details_screen.dart' as _i13;
import '../../view/screen/order/make_order_screen.dart' as _i12;
import '../../view/screen/order/offers_screen.dart' as _i16;
import '../../view/screen/order/order_confirm_screen.dart' as _i18;
import '../../view/screen/order/order_details_screen.dart' as _i17;
import '../../view/screen/order/order_successful_screen.dart' as _i14;
import '../../view/screen/payment/payment_screen.dart' as _i40;
import '../../view/screen/splash_screen.dart' as _i41;
import '../../view/screen/vendor/categories_screen.dart' as _i11;
import '../../view/screen/vendor/store_screen.dart' as _i10;

class AppRouter extends _i42.RootStackRouter {
  AppRouter([_i43.GlobalKey<_i43.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i42.PageFactory> pagesMap = {
    LoginScreenRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.LoginScreen(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    OTPRoute.name: (routeData) {
      final args =
          routeData.argsAs<OTPRouteArgs>(orElse: () => const OTPRouteArgs());
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: _i2.OTPScreen(key: args.key, loginModel: args.loginModel),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    RegisterRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i3.RegisterScreen(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    AuthSuccessfulRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i4.AuthSuccessfulScreen(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    HomeRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i5.HomeScreen(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    DriverRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i6.DriverScreen(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    OrdersRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i7.OrdersHistoryScreen(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    MessageRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i8.ChatHistoryScreen(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    StoresRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i9.StoresScreen(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    StoreScreenRoute.name: (routeData) {
      final args = routeData.argsAs<StoreScreenRouteArgs>(
          orElse: () => const StoreScreenRouteArgs());
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: _i10.StoreScreen(key: args.key, argument: args.argument),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    CategoriesRoute.name: (routeData) {
      final args = routeData.argsAs<CategoriesRouteArgs>();
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: _i11.CategoriesScreen(key: args.key, argument: args.argument),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    MakeOrderRoute.name: (routeData) {
      final args = routeData.argsAs<MakeOrderRouteArgs>();
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: _i12.MakeOrderScreen(key: args.key, argument: args.argument),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    DeliveryDetailsRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i13.DeliveryDetailsScreen(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    OrderSuccessfulRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i14.OrderSuccessfulScreen(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    ChatScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ChatScreenRouteArgs>();
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: _i15.ChatScreen(
              key: args.key,
              orderID: args.orderID,
              chatID: args.chatID,
              isStore: args.isStore),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    OffersRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i16.OffersScreen(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    OrderDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<OrderDetailsRouteArgs>();
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child:
              _i17.OrderDetailsScreen(key: args.key, argument: args.argument),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    OrderConfirmRoute.name: (routeData) {
      final args = routeData.argsAs<OrderConfirmRouteArgs>();
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child:
              _i18.OrderConfirmScreen(key: args.key, argument: args.argument),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    AddressRoute.name: (routeData) {
      final args = routeData.argsAs<AddressRouteArgs>();
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: _i19.AddressScreen(key: args.key, argument: args.argument),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    AddAddressRoute.name: (routeData) {
      final args = routeData.argsAs<AddAddressRouteArgs>(
          orElse: () => const AddAddressRouteArgs());
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: _i20.AddAddressScreen(key: args.key, argument: args.argument),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    PaymentWaysRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i21.PaymentWaysScreen(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    AddPaymentWayRoute.name: (routeData) {
      final args = routeData.argsAs<AddPaymentWayRouteArgs>(
          orElse: () => const AddPaymentWayRouteArgs());
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child:
              _i22.AddPaymentWayScreen(key: args.key, argument: args.argument),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    EditCardDataRoute.name: (routeData) {
      final args = routeData.argsAs<EditCardDataRouteArgs>(
          orElse: () => const EditCardDataRouteArgs());
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child:
              _i23.EditCardDataScreen(key: args.key, argument: args.argument),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    PartnerRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i24.PartnerScreen(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    AdvertsRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i25.AdvertsScreen(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    AddAdvertRoute.name: (routeData) {
      final args = routeData.argsAs<AddAdvertRouteArgs>();
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: _i26.AddAdvertScreen(key: args.key, argument: args.argument),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    CustomerServiceRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i27.CustomerServiceScreen(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    AcceptConditionRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i28.AcceptConditionScreen(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    EditProfileRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i29.EditProfileScreen(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    NotificationRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i30.NotificationScreen(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    ReviewsRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i31.ReviewsScreen(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    TermsAboutAppRoute.name: (routeData) {
      final args = routeData.argsAs<TermsAboutAppRouteArgs>();
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child:
              _i32.TermsAboutAppScreen(key: args.key, argument: args.argument),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    SettingRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i33.SettingsScreen(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    LocationOnMapRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i34.LocationOnMapScreen(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    CaptainRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i35.CaptainScreenTerms(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    CategoriesHomeRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i36.CategoriesHomeScreen(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    DepartmentsHomeRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i37.DepartmentsHomeScreen(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    AdsHomeRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i38.AdsHomeScreen(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    NavigationManagerRoute.name: (routeData) {
      final args = routeData.argsAs<NavigationManagerRouteArgs>(
          orElse: () => const NavigationManagerRouteArgs());
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: _i39.NavigationManager(
              key: args.key, selectedIndex: args.selectedIndex),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    PaymentScreenRoute.name: (routeData) {
      final args = routeData.argsAs<PaymentScreenRouteArgs>();
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: _i40.PaymentScreen(
              key: args.key,
              id: args.id,
              paymentTypeId: args.paymentTypeId,
              amount: args.amount),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    SplashScreenRoute.name: (routeData) {
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i41.SplashScreen(),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    TripDetailsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<TripDetailsScreenRouteArgs>();
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: _i17.TripDetailsScreen(key: args.key, argument: args.argument),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    },
    OrderConfirmationScreenRoute.name: (routeData) {
      final args = routeData.argsAs<OrderConfirmationScreenRouteArgs>();
      return _i42.CustomPage<dynamic>(
          routeData: routeData,
          child: _i17.OrderConfirmationScreen(
              key: args.key, argument: args.argument),
          transitionsBuilder: _i42.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 350,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i42.RouteConfig> get routes => [
        _i42.RouteConfig('/#redirect',
            path: '/', redirectTo: 'initial', fullMatch: true),
        _i42.RouteConfig(LoginScreenRoute.name, path: 'loginScreen'),
        _i42.RouteConfig(OTPRoute.name, path: 'otp'),
        _i42.RouteConfig(RegisterRoute.name, path: 'register'),
        _i42.RouteConfig(AuthSuccessfulRoute.name, path: 'auth_successful'),
        _i42.RouteConfig(HomeRoute.name, path: 'home'),
        _i42.RouteConfig(DriverRoute.name, path: 'driver'),
        _i42.RouteConfig(OrdersRoute.name, path: 'orders_history'),
        _i42.RouteConfig(MessageRoute.name, path: 'chat_history'),
        _i42.RouteConfig(StoresRoute.name, path: 'stores'),
        _i42.RouteConfig(StoreScreenRoute.name, path: 'store'),
        _i42.RouteConfig(CategoriesRoute.name, path: 'categories'),
        _i42.RouteConfig(MakeOrderRoute.name, path: 'make_order'),
        _i42.RouteConfig(DeliveryDetailsRoute.name, path: 'delivery_details'),
        _i42.RouteConfig(OrderSuccessfulRoute.name, path: 'order_successful'),
        _i42.RouteConfig(ChatScreenRoute.name, path: 'chat'),
        _i42.RouteConfig(OffersRoute.name, path: 'offers'),
        _i42.RouteConfig(OrderDetailsRoute.name, path: 'order_details'),
        _i42.RouteConfig(OrderConfirmRoute.name, path: 'order_confirm'),
        _i42.RouteConfig(AddressRoute.name, path: 'address'),
        _i42.RouteConfig(AddAddressRoute.name, path: 'add_address'),
        _i42.RouteConfig(PaymentWaysRoute.name, path: 'payment_ways'),
        _i42.RouteConfig(AddPaymentWayRoute.name, path: 'add_payment_way'),
        _i42.RouteConfig(EditCardDataRoute.name, path: 'edit_card_data'),
        _i42.RouteConfig(PartnerRoute.name, path: 'partner'),
        _i42.RouteConfig(AdvertsRoute.name, path: 'adverts'),
        _i42.RouteConfig(AddAdvertRoute.name, path: 'add_advert'),
        _i42.RouteConfig(CustomerServiceRoute.name, path: 'customer_service'),
        _i42.RouteConfig(AcceptConditionRoute.name, path: 'accept_condition'),
        _i42.RouteConfig(EditProfileRoute.name, path: 'edit_profile'),
        _i42.RouteConfig(NotificationRoute.name, path: 'notification'),
        _i42.RouteConfig(ReviewsRoute.name, path: 'reviews'),
        _i42.RouteConfig(TermsAboutAppRoute.name, path: 'terms_about_app'),
        _i42.RouteConfig(SettingRoute.name, path: 'setting'),
        _i42.RouteConfig(LocationOnMapRoute.name, path: 'location_on_map'),
        _i42.RouteConfig(CaptainRoute.name, path: 'captain'),
        _i42.RouteConfig(CategoriesHomeRoute.name, path: 'categories_home'),
        _i42.RouteConfig(DepartmentsHomeRoute.name, path: 'departments_home'),
        _i42.RouteConfig(AdsHomeRoute.name, path: 'ads_home'),
        _i42.RouteConfig(NavigationManagerRoute.name, path: 'navManager'),
        _i42.RouteConfig(PaymentScreenRoute.name, path: 'paymentScreen'),
        _i42.RouteConfig(SplashScreenRoute.name, path: 'initial'),
        _i42.RouteConfig(TripDetailsScreenRoute.name, path: 'order_details'),
        _i42.RouteConfig(OrderConfirmationScreenRoute.name,
            path: 'order_confirmation_screen')
      ];
}

/// generated route for
/// [_i1.LoginScreen]
class LoginScreenRoute extends _i42.PageRouteInfo<void> {
  const LoginScreenRoute() : super(LoginScreenRoute.name, path: 'loginScreen');

  static const String name = 'LoginScreenRoute';
}

/// generated route for
/// [_i2.OTPScreen]
class OTPRoute extends _i42.PageRouteInfo<OTPRouteArgs> {
  OTPRoute({_i43.Key? key, _i44.LoginModel? loginModel})
      : super(OTPRoute.name,
            path: 'otp', args: OTPRouteArgs(key: key, loginModel: loginModel));

  static const String name = 'OTPRoute';
}

class OTPRouteArgs {
  const OTPRouteArgs({this.key, this.loginModel});

  final _i43.Key? key;

  final _i44.LoginModel? loginModel;

  @override
  String toString() {
    return 'OTPRouteArgs{key: $key, loginModel: $loginModel}';
  }
}

/// generated route for
/// [_i3.RegisterScreen]
class RegisterRoute extends _i42.PageRouteInfo<void> {
  const RegisterRoute() : super(RegisterRoute.name, path: 'register');

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i4.AuthSuccessfulScreen]
class AuthSuccessfulRoute extends _i42.PageRouteInfo<void> {
  const AuthSuccessfulRoute()
      : super(AuthSuccessfulRoute.name, path: 'auth_successful');

  static const String name = 'AuthSuccessfulRoute';
}

/// generated route for
/// [_i5.HomeScreen]
class HomeRoute extends _i42.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: 'home');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i6.DriverScreen]
class DriverRoute extends _i42.PageRouteInfo<void> {
  const DriverRoute() : super(DriverRoute.name, path: 'driver');

  static const String name = 'DriverRoute';
}

/// generated route for
/// [_i7.OrdersHistoryScreen]
class OrdersRoute extends _i42.PageRouteInfo<void> {
  const OrdersRoute() : super(OrdersRoute.name, path: 'orders_history');

  static const String name = 'OrdersRoute';
}

/// generated route for
/// [_i8.ChatHistoryScreen]
class MessageRoute extends _i42.PageRouteInfo<void> {
  const MessageRoute() : super(MessageRoute.name, path: 'chat_history');

  static const String name = 'MessageRoute';
}

/// generated route for
/// [_i9.StoresScreen]
class StoresRoute extends _i42.PageRouteInfo<void> {
  const StoresRoute() : super(StoresRoute.name, path: 'stores');

  static const String name = 'StoresRoute';
}

/// generated route for
/// [_i10.StoreScreen]
class StoreScreenRoute extends _i42.PageRouteInfo<StoreScreenRouteArgs> {
  StoreScreenRoute({_i43.Key? key, _i45.StoreArgument? argument})
      : super(StoreScreenRoute.name,
            path: 'store',
            args: StoreScreenRouteArgs(key: key, argument: argument));

  static const String name = 'StoreScreenRoute';
}

class StoreScreenRouteArgs {
  const StoreScreenRouteArgs({this.key, this.argument});

  final _i43.Key? key;

  final _i45.StoreArgument? argument;

  @override
  String toString() {
    return 'StoreScreenRouteArgs{key: $key, argument: $argument}';
  }
}

/// generated route for
/// [_i11.CategoriesScreen]
class CategoriesRoute extends _i42.PageRouteInfo<CategoriesRouteArgs> {
  CategoriesRoute({_i43.Key? key, required _i46.CategoriesArgument argument})
      : super(CategoriesRoute.name,
            path: 'categories',
            args: CategoriesRouteArgs(key: key, argument: argument));

  static const String name = 'CategoriesRoute';
}

class CategoriesRouteArgs {
  const CategoriesRouteArgs({this.key, required this.argument});

  final _i43.Key? key;

  final _i46.CategoriesArgument argument;

  @override
  String toString() {
    return 'CategoriesRouteArgs{key: $key, argument: $argument}';
  }
}

/// generated route for
/// [_i12.MakeOrderScreen]
class MakeOrderRoute extends _i42.PageRouteInfo<MakeOrderRouteArgs> {
  MakeOrderRoute({_i43.Key? key, required _i47.MakeOrderArgument argument})
      : super(MakeOrderRoute.name,
            path: 'make_order',
            args: MakeOrderRouteArgs(key: key, argument: argument));

  static const String name = 'MakeOrderRoute';
}

class MakeOrderRouteArgs {
  const MakeOrderRouteArgs({this.key, required this.argument});

  final _i43.Key? key;

  final _i47.MakeOrderArgument argument;

  @override
  String toString() {
    return 'MakeOrderRouteArgs{key: $key, argument: $argument}';
  }
}

/// generated route for
/// [_i13.DeliveryDetailsScreen]
class DeliveryDetailsRoute extends _i42.PageRouteInfo<void> {
  const DeliveryDetailsRoute()
      : super(DeliveryDetailsRoute.name, path: 'delivery_details');

  static const String name = 'DeliveryDetailsRoute';
}

/// generated route for
/// [_i14.OrderSuccessfulScreen]
class OrderSuccessfulRoute extends _i42.PageRouteInfo<void> {
  const OrderSuccessfulRoute()
      : super(OrderSuccessfulRoute.name, path: 'order_successful');

  static const String name = 'OrderSuccessfulRoute';
}

/// generated route for
/// [_i15.ChatScreen]
class ChatScreenRoute extends _i42.PageRouteInfo<ChatScreenRouteArgs> {
  ChatScreenRoute(
      {_i43.Key? key,
      required int? orderID,
      required int? chatID,
      bool? isStore = false})
      : super(ChatScreenRoute.name,
            path: 'chat',
            args: ChatScreenRouteArgs(
                key: key, orderID: orderID, chatID: chatID, isStore: isStore));

  static const String name = 'ChatScreenRoute';
}

class ChatScreenRouteArgs {
  const ChatScreenRouteArgs(
      {this.key,
      required this.orderID,
      required this.chatID,
      this.isStore = false});

  final _i43.Key? key;

  final int? orderID;

  final int? chatID;

  final bool? isStore;

  @override
  String toString() {
    return 'ChatScreenRouteArgs{key: $key, orderID: $orderID, chatID: $chatID, isStore: $isStore}';
  }
}

/// generated route for
/// [_i16.OffersScreen]
class OffersRoute extends _i42.PageRouteInfo<void> {
  const OffersRoute() : super(OffersRoute.name, path: 'offers');

  static const String name = 'OffersRoute';
}

/// generated route for
/// [_i17.OrderDetailsScreen]
class OrderDetailsRoute extends _i42.PageRouteInfo<OrderDetailsRouteArgs> {
  OrderDetailsRoute(
      {_i43.Key? key, required _i48.OrderDetailsArgument? argument})
      : super(OrderDetailsRoute.name,
            path: 'order_details',
            args: OrderDetailsRouteArgs(key: key, argument: argument));

  static const String name = 'OrderDetailsRoute';
}

class OrderDetailsRouteArgs {
  const OrderDetailsRouteArgs({this.key, required this.argument});

  final _i43.Key? key;

  final _i48.OrderDetailsArgument? argument;

  @override
  String toString() {
    return 'OrderDetailsRouteArgs{key: $key, argument: $argument}';
  }
}

/// generated route for
/// [_i18.OrderConfirmScreen]
class OrderConfirmRoute extends _i42.PageRouteInfo<OrderConfirmRouteArgs> {
  OrderConfirmRoute(
      {_i43.Key? key, required _i49.OrderConfirmArgument argument})
      : super(OrderConfirmRoute.name,
            path: 'order_confirm',
            args: OrderConfirmRouteArgs(key: key, argument: argument));

  static const String name = 'OrderConfirmRoute';
}

class OrderConfirmRouteArgs {
  const OrderConfirmRouteArgs({this.key, required this.argument});

  final _i43.Key? key;

  final _i49.OrderConfirmArgument argument;

  @override
  String toString() {
    return 'OrderConfirmRouteArgs{key: $key, argument: $argument}';
  }
}

/// generated route for
/// [_i19.AddressScreen]
class AddressRoute extends _i42.PageRouteInfo<AddressRouteArgs> {
  AddressRoute({_i43.Key? key, required _i50.AddressArgument argument})
      : super(AddressRoute.name,
            path: 'address',
            args: AddressRouteArgs(key: key, argument: argument));

  static const String name = 'AddressRoute';
}

class AddressRouteArgs {
  const AddressRouteArgs({this.key, required this.argument});

  final _i43.Key? key;

  final _i50.AddressArgument argument;

  @override
  String toString() {
    return 'AddressRouteArgs{key: $key, argument: $argument}';
  }
}

/// generated route for
/// [_i20.AddAddressScreen]
class AddAddressRoute extends _i42.PageRouteInfo<AddAddressRouteArgs> {
  AddAddressRoute({_i43.Key? key, _i50.AddressArgument? argument})
      : super(AddAddressRoute.name,
            path: 'add_address',
            args: AddAddressRouteArgs(key: key, argument: argument));

  static const String name = 'AddAddressRoute';
}

class AddAddressRouteArgs {
  const AddAddressRouteArgs({this.key, this.argument});

  final _i43.Key? key;

  final _i50.AddressArgument? argument;

  @override
  String toString() {
    return 'AddAddressRouteArgs{key: $key, argument: $argument}';
  }
}

/// generated route for
/// [_i21.PaymentWaysScreen]
class PaymentWaysRoute extends _i42.PageRouteInfo<void> {
  const PaymentWaysRoute() : super(PaymentWaysRoute.name, path: 'payment_ways');

  static const String name = 'PaymentWaysRoute';
}

/// generated route for
/// [_i22.AddPaymentWayScreen]
class AddPaymentWayRoute extends _i42.PageRouteInfo<AddPaymentWayRouteArgs> {
  AddPaymentWayRoute({_i43.Key? key, _i51.AddPaymentWaysArgument? argument})
      : super(AddPaymentWayRoute.name,
            path: 'add_payment_way',
            args: AddPaymentWayRouteArgs(key: key, argument: argument));

  static const String name = 'AddPaymentWayRoute';
}

class AddPaymentWayRouteArgs {
  const AddPaymentWayRouteArgs({this.key, this.argument});

  final _i43.Key? key;

  final _i51.AddPaymentWaysArgument? argument;

  @override
  String toString() {
    return 'AddPaymentWayRouteArgs{key: $key, argument: $argument}';
  }
}

/// generated route for
/// [_i23.EditCardDataScreen]
class EditCardDataRoute extends _i42.PageRouteInfo<EditCardDataRouteArgs> {
  EditCardDataRoute({_i43.Key? key, _i51.AddPaymentWaysArgument? argument})
      : super(EditCardDataRoute.name,
            path: 'edit_card_data',
            args: EditCardDataRouteArgs(key: key, argument: argument));

  static const String name = 'EditCardDataRoute';
}

class EditCardDataRouteArgs {
  const EditCardDataRouteArgs({this.key, this.argument});

  final _i43.Key? key;

  final _i51.AddPaymentWaysArgument? argument;

  @override
  String toString() {
    return 'EditCardDataRouteArgs{key: $key, argument: $argument}';
  }
}

/// generated route for
/// [_i24.PartnerScreen]
class PartnerRoute extends _i42.PageRouteInfo<void> {
  const PartnerRoute() : super(PartnerRoute.name, path: 'partner');

  static const String name = 'PartnerRoute';
}

/// generated route for
/// [_i25.AdvertsScreen]
class AdvertsRoute extends _i42.PageRouteInfo<void> {
  const AdvertsRoute() : super(AdvertsRoute.name, path: 'adverts');

  static const String name = 'AdvertsRoute';
}

/// generated route for
/// [_i26.AddAdvertScreen]
class AddAdvertRoute extends _i42.PageRouteInfo<AddAdvertRouteArgs> {
  AddAdvertRoute({_i43.Key? key, required _i52.AddAdvertArgument argument})
      : super(AddAdvertRoute.name,
            path: 'add_advert',
            args: AddAdvertRouteArgs(key: key, argument: argument));

  static const String name = 'AddAdvertRoute';
}

class AddAdvertRouteArgs {
  const AddAdvertRouteArgs({this.key, required this.argument});

  final _i43.Key? key;

  final _i52.AddAdvertArgument argument;

  @override
  String toString() {
    return 'AddAdvertRouteArgs{key: $key, argument: $argument}';
  }
}

/// generated route for
/// [_i27.CustomerServiceScreen]
class CustomerServiceRoute extends _i42.PageRouteInfo<void> {
  const CustomerServiceRoute()
      : super(CustomerServiceRoute.name, path: 'customer_service');

  static const String name = 'CustomerServiceRoute';
}

/// generated route for
/// [_i28.AcceptConditionScreen]
class AcceptConditionRoute extends _i42.PageRouteInfo<void> {
  const AcceptConditionRoute()
      : super(AcceptConditionRoute.name, path: 'accept_condition');

  static const String name = 'AcceptConditionRoute';
}

/// generated route for
/// [_i29.EditProfileScreen]
class EditProfileRoute extends _i42.PageRouteInfo<void> {
  const EditProfileRoute() : super(EditProfileRoute.name, path: 'edit_profile');

  static const String name = 'EditProfileRoute';
}

/// generated route for
/// [_i30.NotificationScreen]
class NotificationRoute extends _i42.PageRouteInfo<void> {
  const NotificationRoute()
      : super(NotificationRoute.name, path: 'notification');

  static const String name = 'NotificationRoute';
}

/// generated route for
/// [_i31.ReviewsScreen]
class ReviewsRoute extends _i42.PageRouteInfo<void> {
  const ReviewsRoute() : super(ReviewsRoute.name, path: 'reviews');

  static const String name = 'ReviewsRoute';
}

/// generated route for
/// [_i32.TermsAboutAppScreen]
class TermsAboutAppRoute extends _i42.PageRouteInfo<TermsAboutAppRouteArgs> {
  TermsAboutAppRoute(
      {_i43.Key? key, required _i53.TermsAboutAppArgument argument})
      : super(TermsAboutAppRoute.name,
            path: 'terms_about_app',
            args: TermsAboutAppRouteArgs(key: key, argument: argument));

  static const String name = 'TermsAboutAppRoute';
}

class TermsAboutAppRouteArgs {
  const TermsAboutAppRouteArgs({this.key, required this.argument});

  final _i43.Key? key;

  final _i53.TermsAboutAppArgument argument;

  @override
  String toString() {
    return 'TermsAboutAppRouteArgs{key: $key, argument: $argument}';
  }
}

/// generated route for
/// [_i33.SettingsScreen]
class SettingRoute extends _i42.PageRouteInfo<void> {
  const SettingRoute() : super(SettingRoute.name, path: 'setting');

  static const String name = 'SettingRoute';
}

/// generated route for
/// [_i34.LocationOnMapScreen]
class LocationOnMapRoute extends _i42.PageRouteInfo<void> {
  const LocationOnMapRoute()
      : super(LocationOnMapRoute.name, path: 'location_on_map');

  static const String name = 'LocationOnMapRoute';
}

/// generated route for
/// [_i35.CaptainScreenTerms]
class CaptainRoute extends _i42.PageRouteInfo<void> {
  const CaptainRoute() : super(CaptainRoute.name, path: 'captain');

  static const String name = 'CaptainRoute';
}

/// generated route for
/// [_i36.CategoriesHomeScreen]
class CategoriesHomeRoute extends _i42.PageRouteInfo<void> {
  const CategoriesHomeRoute()
      : super(CategoriesHomeRoute.name, path: 'categories_home');

  static const String name = 'CategoriesHomeRoute';
}

/// generated route for
/// [_i37.DepartmentsHomeScreen]
class DepartmentsHomeRoute extends _i42.PageRouteInfo<void> {
  const DepartmentsHomeRoute()
      : super(DepartmentsHomeRoute.name, path: 'departments_home');

  static const String name = 'DepartmentsHomeRoute';
}

/// generated route for
/// [_i38.AdsHomeScreen]
class AdsHomeRoute extends _i42.PageRouteInfo<void> {
  const AdsHomeRoute() : super(AdsHomeRoute.name, path: 'ads_home');

  static const String name = 'AdsHomeRoute';
}

/// generated route for
/// [_i39.NavigationManager]
class NavigationManagerRoute
    extends _i42.PageRouteInfo<NavigationManagerRouteArgs> {
  NavigationManagerRoute({_i43.Key? key, int? selectedIndex})
      : super(NavigationManagerRoute.name,
            path: 'navManager',
            args: NavigationManagerRouteArgs(
                key: key, selectedIndex: selectedIndex));

  static const String name = 'NavigationManagerRoute';
}

class NavigationManagerRouteArgs {
  const NavigationManagerRouteArgs({this.key, this.selectedIndex});

  final _i43.Key? key;

  final int? selectedIndex;

  @override
  String toString() {
    return 'NavigationManagerRouteArgs{key: $key, selectedIndex: $selectedIndex}';
  }
}

/// generated route for
/// [_i40.PaymentScreen]
class PaymentScreenRoute extends _i42.PageRouteInfo<PaymentScreenRouteArgs> {
  PaymentScreenRoute(
      {_i43.Key? key,
      required int id,
      required int paymentTypeId,
      required double amount})
      : super(PaymentScreenRoute.name,
            path: 'paymentScreen',
            args: PaymentScreenRouteArgs(
                key: key,
                id: id,
                paymentTypeId: paymentTypeId,
                amount: amount));

  static const String name = 'PaymentScreenRoute';
}

class PaymentScreenRouteArgs {
  const PaymentScreenRouteArgs(
      {this.key,
      required this.id,
      required this.paymentTypeId,
      required this.amount});

  final _i43.Key? key;

  final int id;

  final int paymentTypeId;

  final double amount;

  @override
  String toString() {
    return 'PaymentScreenRouteArgs{key: $key, id: $id, paymentTypeId: $paymentTypeId, amount: $amount}';
  }
}

/// generated route for
/// [_i41.SplashScreen]
class SplashScreenRoute extends _i42.PageRouteInfo<void> {
  const SplashScreenRoute() : super(SplashScreenRoute.name, path: 'initial');

  static const String name = 'SplashScreenRoute';
}

/// generated route for
/// [_i17.TripDetailsScreen]
class TripDetailsScreenRoute
    extends _i42.PageRouteInfo<TripDetailsScreenRouteArgs> {
  TripDetailsScreenRoute(
      {_i43.Key? key, required _i48.TripDetailsArgument? argument})
      : super(TripDetailsScreenRoute.name,
            path: 'order_details',
            args: TripDetailsScreenRouteArgs(key: key, argument: argument));

  static const String name = 'TripDetailsScreenRoute';
}

class TripDetailsScreenRouteArgs {
  const TripDetailsScreenRouteArgs({this.key, required this.argument});

  final _i43.Key? key;

  final _i48.TripDetailsArgument? argument;

  @override
  String toString() {
    return 'TripDetailsScreenRouteArgs{key: $key, argument: $argument}';
  }
}

/// generated route for
/// [_i17.OrderConfirmationScreen]
class OrderConfirmationScreenRoute
    extends _i42.PageRouteInfo<OrderConfirmationScreenRouteArgs> {
  OrderConfirmationScreenRoute(
      {_i43.Key? key, required _i48.OrderConfirmationArgument? argument})
      : super(OrderConfirmationScreenRoute.name,
            path: 'order_confirmation_screen',
            args:
                OrderConfirmationScreenRouteArgs(key: key, argument: argument));

  static const String name = 'OrderConfirmationScreenRoute';
}

class OrderConfirmationScreenRouteArgs {
  const OrderConfirmationScreenRouteArgs({this.key, required this.argument});

  final _i43.Key? key;

  final _i48.OrderConfirmationArgument? argument;

  @override
  String toString() {
    return 'OrderConfirmationScreenRouteArgs{key: $key, argument: $argument}';
  }
}
