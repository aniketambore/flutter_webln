import 'dart:convert';

import 'interop/stringify_interop.dart';

Map weblnDecode(obj) {
  String rawString = stringify(obj) ?? '{}';
  final jsonMap = jsonDecode(rawString);
  return jsonMap;
}
