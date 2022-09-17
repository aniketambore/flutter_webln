// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_webln/flutter_webln.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Webln Integration',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool isWallet = false;

  @override
  void initState() {
    checkWebln();
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Webln Integration"),
          centerTitle: true,
        ),
        body: isWallet ? const HomePage() : const NoWalletPage());
  }
}

class NoWalletPage extends StatelessWidget {
  const NoWalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Image.network("https://i.ibb.co/7nZ1pL9/5Jy4.gif"),
            ),
            const CustomHeader(headerText: "NO Wallet Found :(")
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void enableMethod() async {
    try {
      await FlutterWebln.enable().then(allowInterop((response) {
        CustomAlertDialog(
          title: "Enabled",
          content: "${weblnDecode(response)}",
        ).show(context);
      }));
    } catch (error) {
      print('[!] Error in enableMethod method is $error');
    }
  }

  void getInfo() async {
    try {
      await FlutterWebln.enable();
      await FlutterWebln.getInfo().then(allowInterop((response) {
        CustomAlertDialog(
          title: "Get Info",
          // content: "${decode(response)}",
          content: "${weblnDecode(response)}",
        ).show(context);
      }));
    } catch (error) {
      print('[!] Error in getInfo method is $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                    buttonText: "Enable", callback: () => enableMethod()),
                const SizedBox(
                  width: 15,
                ),
                // methodButton()
                CustomButton(buttonText: "Get Info", callback: () => getInfo()),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 400,
              color: Colors.transparent,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CustomCard(
                      cardChild: MakeInvoice(), cardColor: Color(0xFFFFBD12)),
                  CustomCard(
                      cardChild: Keysend(), cardColor: Color(0xFFFFC7DE)),
                  CustomCard(
                      cardChild: SendPayment(), cardColor: Color(0xFF00C6AE)),
                  CustomCard(
                      cardChild: SignMessage(), cardColor: Color(0xFFFFF4CC)),
                  CustomCard(
                      cardChild: VerifyMessage(), cardColor: Color(0xFFE9E7FC)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VerifyMessage extends StatefulWidget {
  const VerifyMessage({Key? key}) : super(key: key);

  @override
  State<VerifyMessage> createState() => _VerifyMessageState();
}

class _VerifyMessageState extends State<VerifyMessage> {
  final signatureController = TextEditingController();
  final messageController = TextEditingController();

  void verifyMessage() async {
    try {
      await FlutterWebln.verifyMessage(
              signature: signatureController.text,
              message: messageController.text)
          .then(allowInterop((result) {
        CustomAlertDialog(
          title: "Verify Message",
          content: '${weblnDecode(result)}',
        ).show(context);
      }));
    } catch (error) {
      print('[!] Error in verifyMessage method is $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const CustomHeader(headerText: "Verify Message"),
          const SizedBox(
            height: 15,
          ),
          CustomTextField(
              messageController: signatureController, text: "Signature"),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
              messageController: messageController, text: "Message"),
          const SizedBox(
            height: 15,
          ),
          CustomButton(
              buttonText: "Verify Message", callback: () => verifyMessage()),
        ],
      ),
    );
  }
}

class SignMessage extends StatefulWidget {
  const SignMessage({Key? key}) : super(key: key);

  @override
  State<SignMessage> createState() => _SignMessageState();
}

class _SignMessageState extends State<SignMessage> {
  final messageController = TextEditingController();

  void signMessage() async {
    try {
      await FlutterWebln.signMessage(message: messageController.text)
          .then(allowInterop((result) {
        CustomAlertDialog(
          title: "Sign Message",
          content: '${weblnDecode(result)}',
        ).show(context);
      }));
    } catch (error) {
      print('[!] Error in signMessage method is $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const CustomHeader(headerText: "Sign Message"),
          const SizedBox(
            height: 15,
          ),
          CustomTextField(
              messageController: messageController, text: "Message"),
          const SizedBox(
            height: 15,
          ),
          CustomButton(
              buttonText: "Sign Message", callback: () => signMessage()),
        ],
      ),
    );
  }
}

class SendPayment extends StatefulWidget {
  const SendPayment({Key? key}) : super(key: key);

  @override
  State<SendPayment> createState() => _SendPaymentState();
}

class _SendPaymentState extends State<SendPayment> {
  final invoiceController = TextEditingController();

  void sendPayment() async {
    try {
      await FlutterWebln.sendPayment(invoice: invoiceController.text)
          .then(allowInterop((result) {
        CustomAlertDialog(
          title: "Send Payment",
          content: "${weblnDecode(result)}",
        ).show(context);
      }));
    } catch (error) {
      print('[!] Error in sendPayment method is $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const CustomHeader(headerText: "Send Payment"),
          const SizedBox(
            height: 15,
          ),
          CustomTextField(
              messageController: invoiceController, text: "Invoice"),
          const SizedBox(
            height: 15,
          ),
          CustomButton(
              buttonText: "Send Payment", callback: () => sendPayment()),
        ],
      ),
    );
  }
}

class Keysend extends StatefulWidget {
  const Keysend({Key? key}) : super(key: key);

  @override
  State<Keysend> createState() => _KeysendState();
}

class _KeysendState extends State<Keysend> {
  final destinationNodeController = TextEditingController();
  final amountController = TextEditingController();
  final customRecordKeyController = TextEditingController();
  final customRecordValueController = TextEditingController();

  void keysend() async {
    final customRecord = {
      customRecordKeyController.text: customRecordValueController.text
    };
    final keysendArgs = FlutterWebln.keysendArgs(
      destination: destinationNodeController.text,
      amount: amountController.text,
      customRecords: customRecord,
    );

    try {
      await FlutterWebln.keysend(keysendArgs: keysendArgs)
          .then(allowInterop((result) {
        CustomAlertDialog(
          title: "Keysend",
          content: "${weblnDecode(result)}",
        ).show(context);
      }));
    } catch (error) {
      print('[!] Error in keysend method is $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const CustomHeader(headerText: "Keysend"),
          const SizedBox(
            height: 15,
          ),
          CustomTextField(
              messageController: destinationNodeController,
              text: "Destination Node Key"),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(messageController: amountController, text: "Amount"),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
              messageController: customRecordKeyController,
              text: "Custom Record Key"),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
              messageController: customRecordValueController,
              text: "Custom Record Value"),
          const SizedBox(
            height: 15,
          ),
          CustomButton(buttonText: "Keysend", callback: () => keysend()),
        ],
      ),
    );
  }
}

class MakeInvoice extends StatefulWidget {
  const MakeInvoice({Key? key}) : super(key: key);

  @override
  State<MakeInvoice> createState() => _MakeInvoiceState();
}

class _MakeInvoiceState extends State<MakeInvoice> {
  final amountController = TextEditingController();
  final defaultAmountController = TextEditingController();
  final defaultMemoController = TextEditingController();
  final minimumAmountController = TextEditingController();
  final maximumAmountController = TextEditingController();

  void makeInvoice() async {
    final invoice = FlutterWebln.requestInvoiceArgs(
      amount: amountController.text,
      defaultAmount: defaultAmountController.text,
      minimumAmount: minimumAmountController.text,
      maximumAmount: maximumAmountController.text,
      defaultMemo: defaultMemoController.text,
    );
    try {
      await FlutterWebln.makeInvoice(requestInvoiceArgs: invoice)
          .then(allowInterop((result) {
        CustomAlertDialog(
          title: "Make Invoice",
          content: "${weblnDecode(result)}",
        ).show(context);
      }));
    } catch (error) {
      print('[!] Error in makeInvoice method is $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const CustomHeader(headerText: "Make Invoice"),
          const SizedBox(
            height: 15,
          ),
          CustomTextField(messageController: amountController, text: "Amount"),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
              messageController: defaultMemoController, text: "Default Memo"),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
              messageController: minimumAmountController,
              text: "Minimum Amount"),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
              messageController: maximumAmountController,
              text: "Maximum Amount"),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
              messageController: defaultAmountController,
              text: "Default Amount"),
          const SizedBox(
            height: 15,
          ),
          CustomButton(
              buttonText: "Make Invoice", callback: () => makeInvoice()),
        ],
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final TextEditingController messageController;
  final String text;
  const CustomTextField(
      {Key? key, required this.messageController, required this.text})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.messageController,
      decoration: InputDecoration(
          hintText: widget.text,
          labelText: widget.text,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder()),
    );
  }
}

class CustomHeader extends StatelessWidget {
  final String headerText;
  const CustomHeader({Key? key, required this.headerText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      headerText,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback callback;
  const CustomButton(
      {Key? key, required this.buttonText, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0 * 1.5,
          vertical: 16.0 / 1,
        ),
        backgroundColor: Colors.indigo,
      ),
      onPressed: callback,
      icon: const Icon(
        Icons.bolt_outlined,
        color: Colors.yellow,
      ),
      label: Text(buttonText),
    );
  }
}

class CustomCard extends StatelessWidget {
  final Widget cardChild;
  final Color cardColor;
  const CustomCard({Key? key, required this.cardChild, required this.cardColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(width: 450, height: 350),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Card(
        elevation: 2.0,
        color: cardColor,
        child: SingleChildScrollView(
          primary: false,
          child: cardChild,
        ),
      ),
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);
  final String title;
  final String content;

  Future<bool?> show(BuildContext context) async {
    return await showDialog<bool>(
        context: context,
        builder: (context) => this,
        barrierDismissible: false);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SelectableText(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text("OK"),
        ),
      ],
    );
  }
}
