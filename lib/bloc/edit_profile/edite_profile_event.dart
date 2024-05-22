import 'package:image_picker/image_picker.dart';

abstract class EditProfileEvent {}

class NameUpdated extends EditProfileEvent {
  final String name;

  NameUpdated(this.name);
}

class EmailUpdated extends EditProfileEvent {
  final String email;

  EmailUpdated(this.email);
}

class BioUpdated extends EditProfileEvent {
  final String bio;

  BioUpdated(this.bio);
}

class ImageUpdated extends EditProfileEvent {
  final ImageSource source;

  ImageUpdated(this.source);
}

class ProfileSubmitted extends EditProfileEvent {}
