import 'interop/webln_interop.dart';

class FlutterWebln {
  static get webln => WeblnInstance.webln;

  static enable() => WeblnApi.enable();
  static getInfo() => WeblnApi.getInfo();
  static makeInvoice({RequestInvoiceArgs? requestInvoiceArgs}) =>
      WeblnApi.makeInvoice(requestInvoiceArgs);
  static sendPayment({required String invoice}) =>
      WeblnApi.sendPayment(invoice);
  static keysend({required KeysendArgs keysendArgs}) =>
      WeblnApi.keysend(keysendArgs);
  static signMessage({required String message}) =>
      WeblnApi.signMessage(message);
  static verifyMessage({required String signature, required String message}) =>
      WeblnApi.verifyMessage(signature, message);

  static KeysendArgs keysendArgs(
          {required String destination,
          required dynamic amount,
          Map<String, String>? customRecords}) =>
      KeysendArgs(
          destination: destination,
          amount: amount,
          customRecords: customRecords);

  static RequestInvoiceArgs requestInvoiceArgs(
          {dynamic amount,
          dynamic defaultAmount,
          dynamic minimumAmount,
          dynamic maximumAmount,
          String? defaultMemo}) =>
      RequestInvoiceArgs(
          amount: amount,
          defaultAmount: defaultAmount,
          minimumAmount: minimumAmount,
          maximumAmount: maximumAmount,
          defaultMemo: defaultMemo);
}
