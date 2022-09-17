@JS()
library webln_interop;

import 'package:js/js.dart';

@JS('window')
abstract class WeblnInstance {
  external static get webln;
}

@JS('window.webln')
abstract class WeblnApi {
  external static enable();
  external static getInfo();
  external static makeInvoice(RequestInvoiceArgs? requestInvoiceArgs);
  external static sendPayment(String invoice);
  external static keysend(KeysendArgs keysendArgs);
  external static signMessage(String message);
  external static verifyMessage(String signature, String message);
}

@JS()
@anonymous
class RequestInvoiceArgs {
  external factory RequestInvoiceArgs({
    dynamic amount,
    dynamic defaultAmount,
    dynamic minimumAmount,
    dynamic maximumAmount,
    String? defaultMemo,
  });

  external dynamic /*num|String*/ get amount;
  external set amount(dynamic /*num|String*/ v);

  external dynamic /*num|String*/ get defaultAmount;
  external set defaultAmount(dynamic /*num|String*/ v);

  external dynamic /*num|String*/ get minimumAmount;
  external set minimumAmount(dynamic /*num|String*/ v);

  external dynamic /*num|String*/ get maximumAmount;
  external set maximumAmount(dynamic /*num|String*/ v);

  external String? get defaultMemo;
  external set defaultMemo(String? v);
}

@JS()
@anonymous
class KeysendArgs {
  external factory KeysendArgs({
    required String destination,
    required dynamic amount,
    Map<String, String>? customRecords,
  });

  external String get destination;
  external set destination(String v);

  external dynamic /*num|String*/ get amount;
  external set amount(dynamic /*num|String*/ v);

  external Map<String, String>? get customRecords;
  external set customRecords(Map<String, String>? v);
}
