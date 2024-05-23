abstract class Register3Event {}

class UploadImageEvent extends Register3Event {
  final String imageName;
  final String imageData;

  UploadImageEvent(this.imageData, this.imageName);
}

class Registration3SubmittedEvent extends Register3Event {}
