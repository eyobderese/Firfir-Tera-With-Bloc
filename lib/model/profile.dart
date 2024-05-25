class ProfileModel {
  final String firstName;
  final String lastName;
  final String email;
  final String image;

  ProfileModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
  });

  String get getFirstName => this.firstName;
  String get getLastName => this.lastName;
  String get getEmail => this.email;
  String get getImage => this.image;

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'image': image,
    };
  }
}
