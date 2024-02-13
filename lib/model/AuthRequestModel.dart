

class AuthRequestModel {
  String? user;
  String? password;

  AuthRequestModel({this.user, this.password,});

  AuthRequestModel.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['user'] = user;
    data['password'] = password;
    return data;
  }

  AuthRequestModel.empty(){
    user = '';
    password = '';
  }
  AuthRequestModel.mockTest(){
    user = 'cleo@test.com';
    password = 'Password1';
  }
}

