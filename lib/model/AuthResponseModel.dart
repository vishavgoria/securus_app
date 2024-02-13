class AuthResponseModel {
  int? errorCode;
  String? errorMsg;
  String? message;
  Result? result;

  AuthResponseModel({this.errorCode, this.errorMsg, this.message, this.result});

  AuthResponseModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
    message = json['message'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }


  AuthResponseModel.empty(){
    errorCode = 0;
    errorMsg ='';
    message = '';
    result =
    result = Result.empty();
  }
}

class Result {
  int? contactId;
  String? firstName;
  String? lastName;

  Result({this.contactId, this.firstName, this.lastName});

  Result.fromJson(Map<String, dynamic> json) {
    contactId = json['contactId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contactId'] = this.contactId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    return data;
  }

  Result.empty(){
    contactId = 0;
    firstName = '';
    lastName = '';
  }
}
