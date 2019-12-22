import 'package:book_flutter_7_async/main.dart' as app;
import 'package:flutter_driver/driver_extension.dart';

/// flutter drive --target=./test_driver/app.dartで起動

void main() {
  enableFlutterDriverExtension();
  app.main();
}
