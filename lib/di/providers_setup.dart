part of 'providers_import.dart';

class ProviderSetup {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => LoginProvider()),
    ChangeNotifierProvider(create: (_) => OTPProvider()),
    ChangeNotifierProvider(create: (_) => RegisterProvider()),
    ChangeNotifierProvider(
        create: (_) => ProfileProvider()..getData(context: _)),
    ChangeNotifierProvider(create: (_) => GenderProvider()),
    ChangeNotifierProvider(create: (_) => CityRegionProvider()),
    ChangeNotifierProvider(create: (_) => ChatProvider()),
    ChangeNotifierProvider(create: (_) => NotificationProvider()),
    ChangeNotifierProvider(create: (_) => ReviewsProvider()),
    ChangeNotifierProvider(create: (_) => HomeProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => FirebaseProvider()),
    ChangeNotifierProvider(create: (_) => AddressProvider()..getUserLocation()),
    ChangeNotifierProvider(create: (_) => SettingProvider()),
    ChangeNotifierProvider(create: (_) => StoreProvider()),
    ChangeNotifierProvider(create: (_) => AddressProvider()),
    ChangeNotifierProvider(create: (_) => LocationProvider()),
    ChangeNotifierProvider(create: (_) => ProductProvider()),
    ChangeNotifierProvider(create: (_) => FavoriteProvider()),
    ChangeNotifierProvider(create: (_) => PaymentProvider()),
    ChangeNotifierProvider(create: (_) => OrdersProvider()),
    ChangeNotifierProvider(create: (_) => OffersProvider()),
    ChangeNotifierProvider(create: (_) => AdvertisementProvider()),
    ChangeNotifierProvider(create: (_) => WalletProvider()),
    ChangeNotifierProvider(create: (_) => ClientTripsProvider()),
    ChangeNotifierProvider(create: (_) => DelayedClientTripsProvider()),
    ChangeNotifierProvider(create: (_) => BeCaptainProvider()),
    ChangeNotifierProvider(create: (_) => BePartnerProvider()),
    ChangeNotifierProvider(create: (_) => DepartmentProvider()),
    ChangeNotifierProvider(create: (_) => BanksProvider()),
    ChangeNotifierProvider(create: (_) => CustomServiceProvider()),
    ChangeNotifierProvider(create: (_) => TripPriceCalculatorProvider()),
    ChangeNotifierProvider(create: (_) => DelayedTripDateTimeProvider()),
    ChangeNotifierProvider(
        create: (_) => CurrentLocationProvider()..getCurrentLocation()),
    // ChangeNotifierProvider(create: (_) => MeshwarTripsProvider()),
    ChangeNotifierProvider(create: (_) => ActiveTripsOrdersProvider()),
    ChangeNotifierProvider(create: (_) => ProviderMaps()..getUserLocation()),
    ChangeNotifierProvider(
        create: (_) => DriverTypesProvider()..getDriverTypes()),
    ChangeNotifierProvider(
        create: (_) => CarCategoryProvider()..getCarCategory()),
    ChangeNotifierProvider(
        create: (_) => IdentityTypesProvider()..getIdentityTypes()),
    ChangeNotifierProvider(create: (_) => DriverCarProvider()),
    ChangeNotifierProvider(
        create: (_) => GetAllTripProvider()..getAllActiveTrips()),
    ChangeNotifierProvider(create: (_) => ChatWithStoreProvider()),
    ChangeNotifierProvider(create: (_) => CalculateDistanceProvider()),
    ChangeNotifierProvider(create: (_) => LocalNotificationServices()),
    ChangeNotifierProvider(create: (_) => MapServicesProvider()),
  ];
}
