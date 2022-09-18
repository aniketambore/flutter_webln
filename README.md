<p align="center"><img src="https://raw.githubusercontent.com/aniketambore/flutter_webln/master/assets/package_logo.png" alt="flutter_webln package logo" /></p>

<p align="center">A package that helps you to interact with WebLN providers by providing a <b>FlutterWebln</b> interface for creating Bitcoin Lightning powered web applications.</p>

---

## Features
There are methods to:
- Enable the provider (`FlutterWebln.enable`)
- Get information about a users Bitcoin Lightning node (`FlutterWebln.getInfo`) 
- Send a payment (`FlutterWebln.sendPayment`) 
- Create an invoice to receive a payment (`FlutterWebln.makeInvoice`) 
- Request the user to send a keysend payment (`FlutterWebln.keysend`)
- Request a signature of an arbitrary message (`FlutterWebln.signMessage`)
- Verifies the signature against the raw message (`FlutterWebln.verifyMessage`)

## Getting Started
You first need to install [WebLN provider](https://www.webln.guide/ressources/webln-providers) in order to use any of the `FlutterWebln` methods.

## Detecting WebLN support
Before you start using `FlutterWebln` you need to check for browser support by checking if the variable `FlutterWebln.webln` is defined:

```dart
  void checkWebln() {
    try {
      final weblnValue = weblnDecode(FlutterWebln.webln);
      if (weblnValue.isEmpty) {
        isWallet = false;
      } else {
        isWallet = true;
      }
      print('[+] webln value is $weblnValue');
    } catch (e) {
      print("[!] Error in checkWebln method is $e");
    }
  }
```

`weblnValue.isEmpty` indicates that the WebLN provider is not installed and the user can't use any of the `FlutterWebln` methods.

## Enable WebLN
To begin interacting with `FlutterWebln` methods you'll first need to **enable** the provider as:

```dart
await FlutterWebln.enable()
```

It will prompt the user for permission to use the WebLN capabilities of the browser. After that you are free to call any of the other `FlutterWebln` methods.

## Get Info
With `FlutterWebln.getInfo` the user gets information about the connected node as:

```dart
 try {
   await FlutterWebln.enable();
   await FlutterWebln.getInfo().then(allowInterop((response) {
     print('[+] GetInfoResponse: ${weblnDecode(response)}');
   }));
 } catch (error) {
   print('[!] Error in getInfo method is $error');
 }
```

Response
```text
Result: [+] GetInfoResponse: {node: {alias: 🐝 getalby.com}}
```

## Make Invoice
With `FlutterWebln.makeInvoice` the user creates an invoice to be used by the web app as:

```dart
 final invoice = FlutterWebln.requestInvoiceArgs(
   amount: 100,
   defaultMemo: 'Hello World',
 );
 try {
   await FlutterWebln.makeInvoice(requestInvoiceArgs: invoice)
       .then(allowInterop((result) {
     print('[+] RequestInvoiceResponse: ${weblnDecode(result)}');
   }));
 } catch (error) {
   print('[!] Error in makeInvoice method is $error');
 }
```

Response
```text
[+] RequestInvoiceResponse: {paymentRequest: lnbc1u1p3jdmdzpp5aehslp0ts0wszr62lwl82qwzcgl6jtqudvg000ez75jx307vpcdqdqjfpjkcmr0yptk7unvvscqzpgxqyz5vqsp5npje0n0mct745acshv8dl5pz5kyznz2z6du45fwpyxgwvxvepdts9qyyssqdynz62hf8xh76pn4qfpswzcz4ezt6k9kj9mccf6lzwzkutm04rwjhzynctgphyk6xc0g2ftn7unjxvmszutzr07xq52h5qeja5mk3sqpqwwx7y, rHash: ee6f0f85eb83dd010f4afbbe7501c2c23fa92c1c6b10f7bf22f52468bfcc0e1a}
```

## Send Payment
With `FlutterWebln.sendPayment` the user sends a payment for an invoice. The user needs to provide a [BOLT-11](https://github.com/lightning/bolts/blob/master/11-payment-encoding.md) invoice.

```dart
 try {
   await FlutterWebln.sendPayment(invoice: invoiceController.text)
       .then(allowInterop((result) {
     print('[+] SendPaymentResponse: ${weblnDecode(result)}');
   }));
 } catch (error) {
   print('[!] Error in sendPayment method is $error');
 }
```

Response
```text
[+] SendPaymentResponse: {preimage: 6662313533626135643134626265623164343134363734626261336263306630, paymentHash: ee6f0f85eb83dd010f4afbbe7501c2c23fa92c1c6b10f7bf22f52468bfcc0e1a, route: {total_amt: 100, total_fees: 0}}
```

## Keysend
With `FlutterWebln.keysend` it request the user to send a keysend payment. This payment only needs a destination public key and amount.

```dart
 try {
   await FlutterWebln.keysend(keysendArgs: keysendArgs)
       .then(allowInterop((result) {
     print('[+] KeysendPaymentResponse: ${weblnDecode(result)}');
   }));
 } catch (error) {
   print('[!] Error in keysend method is $error');
 }
```

Response:
```text
[+] KeysendPaymentResponse: {preimage: 3965373033306134316666323562396262333332393463653136383634636265, paymentHash: 20594ee7899bee252917bc44ec744309d0593adf0e79469bb067afb67b632ffc, route: {total_amt: 20, total_fees: 0}}
```

## Sign Message
With ``FlutterWebln.signMessage` it request that the user signs an arbitrary string message.

```dart
 try {
   await FlutterWebln.signMessage(message: 'Hello World!')
       .then(allowInterop((result) {
     print('[+] SignMessageResponse: ${weblnDecode(result)}');
   }));
 } catch (error) {
   print('[!] Error in signMessage method is $error');
 }
```

Signed messages can either be verified server-side using the LND RPC method, or by clients with `FlutterWebln.verifyMessage`.

## Verify Message
With `FlutterWebln.verifyMessage` the users's client verifies the **signature** against the raw **message**, and let's the user know if it was valid.

```dart
 try {
   await FlutterWebln.verifyMessage(
           signature: signatureController.text,
           message: messageController.text,
      ).then(allowInterop((result) {
    print('[+] VerifyMessageResponse: ${weblnDecode(result)}');
   }));
 } catch (error) {
   print('[!] Error in verifyMessage method is $error');
 }
```

## Example Project
<p align="center"><img src="https://i.ibb.co/thWNPJQ/01-flutter-webln-gif-for-example.gif" alt="flutter_webln package example" /></p>

The above [flutter_webln_integration](https://aniketambore.github.io/flutter_webln/) project can be found [here](https://github.com/aniketambore/flutter_webln/tree/main/example)

## Reference
- [WebLN Guide](https://www.webln.guide/introduction/readme)
- [WebLN Dev](https://webln.dev/#/)
- [TLV record registry](https://github.com/satoshisstream/satoshis.stream/blob/main/TLV_registry.md)