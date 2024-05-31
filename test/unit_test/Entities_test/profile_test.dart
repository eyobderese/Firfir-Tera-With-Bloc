import 'package:firfir_tera/Domain/Entities/profile.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProfileModel', () {
    final profile = ProfileModel(
      firstName: 'Abebe',
      lastName: 'Kebede',
      email: 'abebe@example.com',
      image: 'image.png',
    );

    test('fromJson creates correct instance', () {
      final json = {
        'firstName': 'Abebe',
        'lastName': 'Kebede',
        'email': 'abebe@example.com',
        'image': 'image.png',
      };

      final profileFromJson = ProfileModel.fromJson(json);

      expect(profileFromJson.firstName, 'Abebe');
      expect(profileFromJson.lastName, 'Kebede');
      expect(profileFromJson.email, 'abebe@example.com');
      expect(profileFromJson.image, 'image.png');
    });

    test('toJson returns correct map', () {
      final json = profile.toJson();

      expect(json, {
        'firstName': 'Abebe',
        'lastName': 'Kebede',
        'email': 'abebe@example.com',
        'image': 'image.png',
      });
    });

    test('getters return correct values', () {
      expect(profile.getFirstName, 'Abebe');
      expect(profile.getLastName, 'Kebede');
      expect(profile.getEmail, 'abebe@example.com');
      expect(profile.getImage, 'image.png');
    });
  });
}
