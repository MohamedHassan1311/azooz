class NotificationRouteData {
  final String id;
  final String path;

  NotificationRouteData(this.id, this.path);
}

Map<String, NotificationRouteData> notificationRoutesData = {
  "openHomePage": NotificationRouteData("0", "home"),
  "refreshClientActiveOrdersPage": NotificationRouteData("3", "orders_history"),
  "refreshClientOrderOffersPage": NotificationRouteData("4", "order_confirm"),
  "openNotificationPage": NotificationRouteData("5", "notification"),
  "openClientChatPage": NotificationRouteData("6", "chat_history"),
  "openCustomerService": NotificationRouteData("9", "customer_service"),
  "openClientCanceldOrders": NotificationRouteData("10", "orders_history"),
};
