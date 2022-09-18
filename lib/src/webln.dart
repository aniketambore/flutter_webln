import 'interop/webln_interop.dart';

class FlutterWebln {
  /// Before you start using any of the [FlutterWebln] methods
  /// you need to check for browser support by checking if the
  /// variable is defined or not as:
  ///
  /// ```dart
  /// final weblnValue = weblnDecode(FlutterWebln.webln);
  /// if (weblnValue.isEmpty) {
  ///   isWallet = false;
  /// } else {
  ///   isWallet = true;
  /// }
  /// ```
  ///
  /// [weblnValue.isEmpty] indicates that the WebLN provider
  /// is not installed and the user can't use any of the [FlutterWebln] methods.
  static get webln => WeblnInstance.webln;

  /// To begin interacting with WebLN APIs you'll first need to [enable] the provider as:
  ///
  /// ```dart
  /// await FlutterWebln.enable()
  /// ```
  ///
  /// It will prompt the user for permission to use the WebLN capabilities of the browser.
  /// After that you are free to call any of the other [FlutterWebln] methods.
  static enable() => WeblnApi.enable();

  /// With [getInfo] the user gets information about the connected node as:
  ///
  /// ```dart
  /// try {
  ///   await FlutterWebln.enable();
  ///   await FlutterWebln.getInfo().then(allowInterop((response) {
  ///     print('[+] GetInfoResponse: ${weblnDecode(response)}');
  ///   }));
  /// } catch (error) {
  ///   print('[!] Error in getInfo method is $error');
  /// }
  /// ```
  ///
  /// Result: [+] GetInfoResponse: {node: {alias: 🐝 getalby.com}}
  static getInfo() => WeblnApi.getInfo();

  /// With [makeInvoice] the user creates an invoice to be used by the web app as:
  ///
  /// ```dart
  /// final invoice = FlutterWebln.requestInvoiceArgs(
  ///   amount: 100,
  ///   defaultMemo: 'Hello World',
  /// );
  /// try {
  ///   await FlutterWebln.makeInvoice(requestInvoiceArgs: invoice)
  ///       .then(allowInterop((result) {
  ///     print('[+] RequestInvoiceResponse: ${weblnDecode(result)}');
  ///   }));
  /// } catch (error) {
  ///   print('[!] Error in makeInvoice method is $error');
  /// }
  /// ```
  static makeInvoice({RequestInvoiceArgs? requestInvoiceArgs}) =>
      WeblnApi.makeInvoice(requestInvoiceArgs);

  /// With [sendPayment] the user sends a payment for an invoice.
  /// The user needs to provide a BOLT-11 invoice.
  ///
  /// ```dart
  /// try {
  ///   await FlutterWebln.sendPayment(invoice: invoiceController.text)
  ///       .then(allowInterop((result) {
  ///     print('[+] SendPaymentResponse: ${weblnDecode(result)}');
  ///   }));
  /// } catch (error) {
  ///   print('[!] Error in sendPayment method is $error');
  /// }
  /// ```
  static sendPayment({required String invoice}) =>
      WeblnApi.sendPayment(invoice);

  /// With [keysend] it request the user to send a keysend payment.
  /// This payment only needs a destination public key and amount.
  ///
  /// ```dart
  /// try {
  ///   await FlutterWebln.keysend(keysendArgs: keysendArgs)
  ///       .then(allowInterop((result) {
  ///     print('[+] KeysendPaymentResponse: ${weblnDecode(result)}');
  ///   }));
  /// } catch (error) {
  ///   print('[!] Error in keysend method is $error');
  /// }
  /// ```
  static keysend({required KeysendArgs keysendArgs}) =>
      WeblnApi.keysend(keysendArgs);

  /// With [signMessage] it request that the user signs an arbitrary string message.
  ///
  /// ```dart
  /// try {
  ///   await FlutterWebln.signMessage(message: 'Hello World!')
  ///       .then(allowInterop((result) {
  ///     print('[+] SignMessageResponse: ${weblnDecode(result)}');
  ///   }));
  /// } catch (error) {
  ///   print('[!] Error in signMessage method is $error');
  /// }
  /// ```
  ///
  /// Signed messages can either be verified server-side using the LND RPC method,
  /// or by clients with [FlutterWebln.verifyMessage].
  static signMessage({required String message}) =>
      WeblnApi.signMessage(message);

  /// With [verifyMessage] the users's client verifies the signature
  /// against the raw message, and let's the user know if it was valid.
  ///
  /// ```dart
  /// try {
  ///   await FlutterWebln.verifyMessage(
  ///           signature: signatureController.text,
  ///           message: messageController.text,
  ///      ).then(allowInterop((result) {
  ///    print('[+] VerifyMessageResponse: ${weblnDecode(result)}');
  ///   }));
  /// } catch (error) {
  ///   print('[!] Error in verifyMessage method is $error');
  /// }
  /// ```
  static verifyMessage({required String signature, required String message}) =>
      WeblnApi.verifyMessage(signature, message);

  /// [KeysendArgs] parameters data types:
  ///
  /// - [destination] : String (Hex encoded public key of the destination node)
  /// - [amount] : String|num (The amount of satoshis you want to send)
  /// - [customRecords?] : Map<String, String>? (Records that are appended to the payment)
  static KeysendArgs keysendArgs(
          {required String destination,
          required dynamic amount,
          Map<String, String>? customRecords}) =>
      KeysendArgs(
          destination: destination,
          amount: amount,
          customRecords: customRecords);

  /// [RequestInvoiceArgs] parameters data types:
  ///
  /// - [amount?] : String|num (An invoice with a specific amount in sats)
  /// - [defaultAmount?] : String|num
  /// - [minimumAmount?] : String|num (Minimum amount constrained)
  /// - [maximumAmount?] : String|num (Maximum amount constrained)
  /// - [defaultMemo?] : String?
  ///
  /// As [amount?] is nullable when it is not set,
  /// the user can return an invoice that has no amount specified,
  /// allowing the payment maker to send any amount.
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
