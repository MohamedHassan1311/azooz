class AppStatus {
  static Map<dynamic, dynamic> mediaType = {
    'Text': 201,
    'Image': 202,
    'Video': 203,
    'Record': 204,
    'AnyFile': 205,
  };

  static Map<dynamic, dynamic> orderStatusTypes = {
    'New': 81,
    'Accept': 82, // Show hud to accept or reject order/trip
    'Active': 83, // Show chat screen
    'Completed': 84, // Show hud to rate driver
    'Cancel': 85,
  };

  static Map<dynamic, dynamic> offerType = {
    'New': 101,
    'Accept': 102,
    'Reject': 103,
    'Waiting': 104,
    'Cancel': 105,
    'CancelByProvider': 106,
    'Done': 107,
  };

  static const defaultStoreType = 71;
  static const mapStoreType = 72;
}
