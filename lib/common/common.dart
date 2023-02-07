import 'package:flutter/cupertino.dart';

class Global {

  // 初始化全局信息
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
  }
}