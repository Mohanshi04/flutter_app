class User {
  final int id;
  final String fullName;
  final String email;
  final String image;

  User({required this.id, required this.fullName, required this.email, required this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: "${json['firstName']} ${json['lastName']}",
      email: json['email'],
      image: json['image'] ?? '',
    );
  }
}
