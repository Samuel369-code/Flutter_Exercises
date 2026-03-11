

class User {
  final String name;
  final String phone;
  final String email;
  final String password;
  String? profileImagePath;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required  this.password,
    this.profileImagePath,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'phone': phone,
    'profileImagePath': profileImagePath,
  };

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json['name'] ?? 'Admin User',
    email: json['email'] ?? 'admin@example.com',
    phone: json['phone'] ?? '+34 600 123 456',
    profileImagePath: json['profileImagePath'],
    password: 'admin123',
  );

}