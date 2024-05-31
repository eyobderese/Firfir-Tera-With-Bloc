class UserDto {
  String id;
  String firstName;
  String lastName;
  String email;
  String role;

  UserDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
  });

  UserDto.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        firstName = json['firstName'],
        lastName = json["lastName"],
        email = json['email'],
        role = json['role'][0];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['role'] = this.role;

    return data;
  }
}
