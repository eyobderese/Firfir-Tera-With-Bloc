import 'package:image_picker/image_picker.dart';

abstract class EditProfileEvent {}

class FirstNameUpdated extends EditProfileEvent {
  final String firstName;

  FirstNameUpdated(this.firstName);
}

class EmailUpdated extends EditProfileEvent {
  final String email;

  EmailUpdated(this.email);
}

class LastNameUpdated extends EditProfileEvent {
  final String lastName;

  LastNameUpdated(this.lastName);
}

class ImageUpdated extends EditProfileEvent {
  final ImageSource source;

  ImageUpdated(this.source);
}

class ProfileSubmitted extends EditProfileEvent {}
