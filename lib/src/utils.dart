import 'dart:convert';

import 'interop/stringify_interop.dart';

/// [weblnDecode] helps us to deseralize "[object Object]" result to jsonMap.
///
/// ```dart
/// weblnDecode(FlutterWebln.webln);
/// ```
/// Result:
/// => {} // if webln provider is not installed
/// => {enabled: false, isEnabled: false, executing: false}
///
Map weblnDecode(obj) {
  String rawString = stringify(obj) ?? '{}';
  final jsonMap = jsonDecode(rawString);
  return jsonMap;
}
