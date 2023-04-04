import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

//初回に上書きしてキャッシュして使うので、直接アクセスはできないようにする
final sharedPreferencesProvider =
    Provider<SharedPreferences>((_) => throw UnimplementedError());
