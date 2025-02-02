class UserModel {
  final String? id;
  final String name;
  final String email;

  UserModel({this.id, required this.name, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      id: data['_id'] as String,
      name: data['name'] as String,
      email: data['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'name': name, 'email': email};
  }
}
