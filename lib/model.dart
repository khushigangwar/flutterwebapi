class User {
  final int id;
  final String user;
  final String address;

  const User({
    required this.id,
    required this.user,
    required this.address,
  });
  factory User.fromJson(Map<String, dynamic> json) =>
      User(id: json['id'], user: json['user'], address: json['address']);
  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "address": address,
      };
}
