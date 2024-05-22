import 'package:image_picker/image_picker.dart';

class ProfileRepository {
  Future<void> updateProfile({
    required String name,
    required String email,
    required String bio,
    required XFile? imageData,
  }) async {
    // Simulate a network request
    await Future.delayed(Duration(seconds: 1));
  }
}
