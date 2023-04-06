import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final httpClientProvider = Provider<http.Client>((ref) => http.Client());
