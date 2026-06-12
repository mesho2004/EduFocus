class ParentModel {
  String? message;
  String? accessToken;
  String? tokenType;
  Parent? parent;

  ParentModel({this.message, this.accessToken, this.tokenType, this.parent});

  ParentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    parent = json['parent'] != null
        ? new Parent.fromJson(json['parent'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
    return data;
  }
}

class Parent {
  String? id;
  String? email;
  String? authProvider;

  Parent({this.id, this.email, this.authProvider});

  Parent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    authProvider = json['auth_provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['auth_provider'] = this.authProvider;
    return data;
  }
}
