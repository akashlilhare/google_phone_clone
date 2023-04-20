

class User {
  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.isFavourite,
  });
  late final String userId;
  late final String firstName;
  late final String lastName;
  late final String phone;
  late final String email;
  late final bool isFavourite;

  User.fromJson(Map<String, dynamic> json){
    userId = json['user_id'].toString();
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    isFavourite = json['is_favourite'];
  }

  User.fromFirestoreQuery(Map<String, dynamic> json, String id){
    userId = id;
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    isFavourite = json['is_favourite'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_id'] = userId;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['phone'] = phone;
    _data['email'] = email;
    _data['is_favourite'] = isFavourite;
    return _data;
  }
}