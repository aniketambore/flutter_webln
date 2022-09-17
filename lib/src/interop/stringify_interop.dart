@JS()
library stringify_interop;

import 'package:js/js.dart';

@JS("JSON.stringify")
external String? stringify(Object obj);
