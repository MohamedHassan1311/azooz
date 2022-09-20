const String baseURL = 'http://api.azoooz.com/api/';
const String baseImageURL = 'http://api.azoooz.com';

// const baseURL = "http://75.119.137.98:2040/api/";
// const baseImageURL = "http://75.119.137.98:2040";
// UserRule = 61

// Store Type
// 71 => Azooz
// 72 => Marsoul

/// Authentication
const String loginURL = '${baseURL}Authentication/Login';
const String verificationURL = '${baseURL}Authentication/Verifiaction';
const String profileURL = '${baseURL}Authentication/Profile';
const String logoutURL = '${baseURL}Authentication/LogOut';
const String deleteAccountURL = '${baseURL}Authentication/DeleteAccount';
const String fcmURL = '${baseURL}Authentication/FCM';

/// Region & City
const String regionURL = '${baseURL}Regions/Get';
const String cityURL = '${baseURL}Cities/Get';

/// Gender
const String gendersURL = '${baseURL}Genders/Get';

/// Chat
const String allChatURL = '${baseURL}Chat/GetAll';
const String chatURL = '${baseURL}Chat/Get';
const String createChatWithStoreURL = '${baseURL}Chat/CreateChatWithStore';
const String getStoreHudURL = '${baseURL}Chat/GetStoreClientHud';

/// Chat Message
const String chatMessageURL = '${baseURL}ChatMessage/Get';
const String createChatMessageURL = '${baseURL}ChatMessage/Create';

const String chatClientWithStore = '${baseURL}Chat/CreateChatWithStore';

/// Notification
const String notificationURL = '${baseURL}Notifications/Get';

/// Reviews
const String reviewsURL = '${baseURL}Reviews/Reviews';
const String postStoreReviewsURL = '${baseURL}Reviews/Reviews';

/// Setting
const String appStatusURL = '${baseURL}Setting/AppStatus';
const String termsURL = '${baseURL}Setting/TermsAndPolicies';
const String vehicleURL = '${baseURL}Setting/VehicleType';
const String departmentURL = '${baseURL}Setting/GetAllDepartments';
const String bankURL = '${baseURL}Setting/GetAllBanks';

/// Home
const String homeURL = '${baseURL}Home/Details';
const String allCategoriesURL = '${baseURL}Home/ShowAllDepartments';
const String allAdsURL = '${baseURL}Home/ShowAllAdds';
const String allDepartmentsURL = '${baseURL}Home/ShowAllSmartDepartments';

/// Store
const String storesByDepURL = '${baseURL}Store/ByDepartment';
const String storeByIdURL = '${baseURL}Store/ById';

/// Product
const String productsURL = '${baseURL}Products/ByCategory';

/// Address
const String addAddressURL = '${baseURL}FavoriteLocations/Create';
const String getAddressURL = '${baseURL}FavoriteLocations/Get';
const String editAddressURL = '${baseURL}FavoriteLocations/Update';
const String deleteAddressURL = '${baseURL}FavoriteLocations/Delete';

/// Favorites
const String getFavoriteURL = '${baseURL}FavoriteStores/Get';
const String addFavoriteURL = '${baseURL}FavoriteStores/Create';
const String deleteFavoriteURL = '${baseURL}FavoriteStores/Delete';

/// Payment
const String getPaymentsURL = '${baseURL}FavoriteCards/Get';
const String addPaymentsURL = '${baseURL}FavoriteCards/Create';
const String editPaymentsURL = '${baseURL}FavoriteCards/Update';
const String deletePaymentsURL = '${baseURL}FavoriteCards/Delete';
const String cashPaymentURL = '${baseURL}Payment/Cash';
const String walletPaymentURL = '${baseURL}Payment/Wallet';
const String checkoutURL = '${baseURL}Payment/Checkout';
const String creditStatusURL = '${baseURL}Payment/CreditStatus';

/// Orders
const String ordersCurrentURL = '${baseURL}Orders/Active';
const String ordersPreviousURL = '${baseURL}Orders/Finish';
const String orderDetailsURL = '${baseURL}Orders/Details';
const String orderCancelURL = '${baseURL}Orders/Cancel';
const String paymentValueURL = '${baseURL}Orders/PaymentValue';
const String createOrderURL = '${baseURL}Orders/Create';
const String cancelOrderConfirmURL = '${baseURL}Orders/CancelConfirmation';

/// Duration
// const String durationURL = '${baseURL}Duration';

/// TripTypes
const String ordersTypesURL = '${baseURL}Orders/OrderTypes';

/// Coupon
const String couponCheckURL = '${baseURL}Cobouns/Check';

/// Offers
const String offersURL = '${baseURL}driver/Offers/Offers';
const String acceptOfferURL = '${baseURL}driver/Offers/Accept';
const String rejectOfferURL = '${baseURL}driver/Offers/OfferLess';

/// Advertisement
const String getAdvertisementURL = '${baseURL}Advertisement/Get';
const String addAdvertisementURL = '${baseURL}Advertisement';
const String deleteAdvertisementURL = '${baseURL}Advertisement';
const String editAdvertisementURL = '${baseURL}Advertisement/Edit';

/// Wallet
const String walletURL = '${baseURL}Wallet/Get';
const String walletSendURL = '${baseURL}Wallet';

/// Trips
// const String tripURL = '${baseURL}Trips';
const String clientTripsURL = '${baseURL}ClientTrips';
const String delayedClientTripURL = '${baseURL}ClientTrips/DelayedTrip';
const String tripCostCalculatorURL = '${baseURL}ClientTrips/DelayedTripPrice';
const String activeClientTripsURL = '${baseURL}ClientTrips/Active';
const String finishClientTripsURL = '${baseURL}ClientTrips/Finish';
const String tripDetailsURL = '${baseURL}Orders/Details';

/// Partner
const String captainURL = '${baseURL}User/User/RequestAsAServiceProvider';

/// Captain
const String partnerURL = '${baseURL}User/User/RequestAsStore';
const String driverTypesURL = '${baseURL}LookUp/DriverTypes';
const String carCategoryURL = '${baseURL}LookUp/CarCategory';
const String identityTypesURL = '${baseURL}LookUp/IdentityTypes';
const String carTypesURL = '${baseURL}LookUp/CarTypes';
const String carsKindURL = '${baseURL}LookUp/CarsKind';
const String orderPaymentTypesURL = '${baseURL}LookUp/OrderPaymentTypes';

// Maps
const String calculateDistanceURL = '${baseURL}LookUp/CalculateDistence';

/// Contact Us
const String contactCustomerServiceURL =
    '${baseURL}ContactUs/ContactCustomerService';
const String contactSendMessageURL = '${baseURL}ContactUs/SendMessage';
const String contactMessagesURL = '${baseURL}ContactUs/Get';
