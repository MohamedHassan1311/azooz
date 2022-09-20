class ChatWithStoreModel {
  Result? result;
  String? message;

  ChatWithStoreModel({this.result, this.message});

  ChatWithStoreModel.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Result {
  int? chatid;

  Result({this.chatid});

  Result.fromJson(Map<String, dynamic> json) {
    chatid = json['chatid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatid'] = chatid;
    return data;
  }
}
