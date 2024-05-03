class User {
  final int Id;
  final String user;
  final String address;

  const User({
    required this.Id,
    required this.user,
    required this.address,
  });
  const User.empty({
    this.Id = 0,
    this.user = '',
    this.address = '',
  });
  factory User.fromJson(Map<String, dynamic> json) =>
      User(Id: json['Id'], user: json['user'], address: json['address']);
  Map<String, dynamic> toJson() => {
        "Id": Id,
        "user": user,
        "address": address,
      };
}
