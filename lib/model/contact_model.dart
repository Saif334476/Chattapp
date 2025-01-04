
class Contact{
  String email;
  String name;
  Contact({required this.email, required this.name});

  factory Contact.fromJson(Map<String,dynamic> doc) {
    return Contact(
      email: doc['email'],
      name: doc['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
    };
  }
}
