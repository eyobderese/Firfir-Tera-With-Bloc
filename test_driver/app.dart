import 'package:flutter_driver/driver_extension.dart';
import 'package:firfir_tera/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';

import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/services.dart';

void main() {
  enableFlutterDriverExtension();


  const MethodChannel channel = MethodChannel('plugins.flutter.io/image_picker');

  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    ByteData data = await rootBundle.load('Firfir-Tera--With-Bloc/assets/images/userImage.png');
    Uint8List bytes = data.buffer.asUint8List();
    Directory tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/tmp.tmp', ).writeAsBytes(bytes);
    print(file.path);
    return file.path;
  });


  app.main();
}