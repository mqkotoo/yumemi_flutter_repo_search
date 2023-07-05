import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

class TestHelper {
  //初期状態は横画面判定になっているので縦画面に設定する
  static void setDisplayVertical({Size size = const Size(390, 844)}) {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.window.physicalSizeTestValue = size;
    binding.window.devicePixelRatioTestValue = 1;
  }
}
