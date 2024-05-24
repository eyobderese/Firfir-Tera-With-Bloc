import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class Register3Event extends Equatable {
  const Register3Event();
  @override
  List<Object?> get props => [];
}

class UploadImageEvent extends Register3Event {
  final ImageSource source;

  const UploadImageEvent(this.source);

  @override
  List<Object> get props => [source];
}

class Registration3SubmittedEvent extends Register3Event {}
