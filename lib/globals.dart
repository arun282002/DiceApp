// // TODO Implement this library.library my_project.globals;
// library my_project.globals;
//  int globalToken = 300;

import 'package:get_storage/get_storage.dart';

class Globals {
 static final _box = GetStorage();

 static int get globalToken => _box.read('globalToken') ?? 100;

 static set globalToken(int value) {
  _box.write('globalToken', value);
 }
}

