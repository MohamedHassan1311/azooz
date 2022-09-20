class PayRechargeIds {
  static const int payTripOrderId = 1;
  static const int payAdsId = 4;
  static const int rechargeWalletId = 5;
}

class PaymentTypeModel {
  PaymentTypeModel(this.id, this.name);

  final int id;
  final String name;

  toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  toJson(Map<String, dynamic> json) {
    json['id'] = id;
    json['name'] = name;
  }
}

List<Map<String, dynamic>> paymentMethodTypes = [
  {
    "id": 1011,
    "name": "Cash",
  },
  {
    "id": 1012,
    "name": "Visa",
  },
  {
    "id": 1013,
    "name": "Master",
  },
  {
    "id": 1014,
    "name": "ApplePay",
  },
  {
    "id": 1015,
    "name": "Mada",
  },
  {
    "id": 1016,
    "name": "STCpay",
  },
  {
    "id": 1017,
    "name": "AEX",
  },
  {
    "id": 1018,
    "name": "Wallet",
  },
];

class PaymentMethodTypeIds {
  static const Map<String, dynamic> cash = {
    "id": 1011,
    "name": "Cash",
  };
  static const Map<String, dynamic> visa = {
    "id": 1012,
    "name": "Visa",
  };
  static const Map<String, dynamic> master = {
    "id": 1013,
    "name": "Master",
  };
  static const Map<String, dynamic> applePay = {
    "id": 1014,
    "name": "ApplePay",
  };
  static const Map<String, dynamic> mada = {
    "id": 1015,
    "name": "Mada",
  };
  static const Map<String, dynamic> stcPay = {
    "id": 1016,
    "name": "STCpay",
  };
  static const Map<String, dynamic> aEX = {
    "id": 1017,
    "name": "AEX",
  };
  static const Map<String, dynamic> wallet = {
    "id": 1018,
    "name": "Wallet",
  };
}

String MadaRegexV =
    "4(0(0861|1757|7(197|395)|9201)|1(0685|7633|9593)|2(281(7|8|9)|8(331|67(1|2|3)))|3(1361|2328|4107|9954)|4(0(533|647|795)|5564|6(393|404|672))|5(5(036|708)|7865|8456)|6(2220|854(0|1|2|3))|8(301(0|1|2)|4783|609(4|5|6)|931(7|8|9))|93428)";
String MadaRegexM =
    "5(0(4300|8160)|13213|2(1076|4(130|514)|9(415|741))|3(0906|1095|2013|5(825|989)|6023|7767|9931)|4(3(085|357)|9760)|5(4180|7606|8848)|8(5265|8(8(4(5|6|7|8|9)|5(0|1))|98(2|3))|9(005|206)))|6(0(4906|5141)|36120)|9682(0(1|2|3|4|5|6|7|8|9)|1(0|1))";
String MadaHash = "";

enum PaymentMethodsEnum {
  VISA,
  MASTER,
  MADA,
  STCPAY,
  APPLEPAY,
  WALLET,
  NONE,
}

enum CheckoutMode {
  mobile,
  // qr_code,
}
