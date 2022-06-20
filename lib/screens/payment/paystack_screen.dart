import 'dart:io';

import 'dart:math';

import 'package:avon/screens/enrollee/dashboard/profile.dart';
import 'package:avon/screens/payment/payment_option.dart';
import 'package:avon/widgets/scaffolds.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:intl/intl.dart';
import 'package:seerbit_flutter/seerbit_flutter.dart';

const Color green = const Color(0xFF3db76d);
const Color lightBlue = const Color(0xFF34a5db);
const Color navyBlue = const Color(0xFF031b33);

class PayStackScreen extends StatefulWidget {
  int amount;
  String email;

  PayStackScreen({Key? key, required this.amount, required this.email})
      : super(key: key);

  _PayStackScreen createState() => new _PayStackScreen();
}

class _PayStackScreen extends State<PayStackScreen> {
  String checkout_method = '';
  bool _inProgress = false;
  NumberFormat _formatCurrency = new NumberFormat.currency(
    decimalDigits: 2,
    customPattern: "#,##0.00",
  );

  //final PaymentPlugin =  PaystackPlugin();

  void initState() {
    /// PaymentPlugin.initialize(publicKey: 'pk_test_afab87d96412d62eea6fb05c5212582a91ee7665');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
        title: "Seerbit",
        showAppBar: true,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.black.withOpacity(0.1)))),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.monetization_on,
                        size: 28,
                        color: Colors.red,
                      ),
                      margin: EdgeInsets.only(right: 10),
                    ),
                    Container(
                      child: Text('Pay With Seerbit',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.8))),
                    )
                  ],
                ),
              ),
              onTap: () {
                //payments

              },
            ),
            InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.black.withOpacity(0.1)))),
                child: Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.credit_card,
                        size: 28,
                        color: Colors.green,
                      ),
                      margin: EdgeInsets.only(right: 10),
                    ),
                    Container(
                      child: Text('Pay with new credit/debit card',
                          style: new TextStyle(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.8))),
                    )
                  ],
                ),
              ),
              onTap: () {
                //payWithCard();
              },
            )
          ],
        ));
  }

  //Charge createCharge(){
  //  Charge charge = Charge()
  //    ..amount = widget.amount * 100// In base currency
  //     ..email = widget.email;
  //  return charge;
//  }

  //void payWithCard() async{
  //  setState((){checkout_method='card';});
  //  Charge charge=createCharge();
  ////  charge..card = PaymentCard(
  //  number: ' 408 408 408 408 408 1',
  ////     cvc: '408',
  //   expiryMonth: 05,
  //    expiryYear: 22,
  //  );
  //  charge.reference = _getReference();

  //  try {
  //    setState(() => _inProgress = true);

  //   CheckoutResponse response = await PaymentPlugin.checkout(
  //   context,
  //    method: CheckoutMethod.card,
  //   charge: charge,
  //   fullscreen: false,
  //    logo: Text("AVON"),
  //  );
//      print('Response = $response');
  //  setState(() => _inProgress = false);
  //   _handlePaymentResponse(response);

  //  } catch (e) {
  // setState(() => _inProgress = false);

  // rethrow;
  // }
  // }
  // void payWithBank({String access_code = "rere34"}) async{
  //  setState((){checkout_method='bank';});

  /// Charge charge=createCharge();
  // charge.accessCode=access_code;
  // charge.amount = widget.amount * 100;
  // try {
  //  setState(() => _inProgress = true);
  //  CheckoutResponse response = await PaymentPlugin.checkout(
  //  context,
  // method: CheckoutMethod.bank,
  // charge: charge,
  // fullscreen: false,
  // logo: new Text('Avon'),
  // );
  // _handlePaymentResponse(response);
  //} catch (e) {
  //  setState(() => _inProgress = false);

  //   rethrow;
  //}

  // }

  // _handlePaymentResponse(CheckoutResponse response){
  ///  print(response);
  ///  if(response.status){
  // Navigator.pop(context, {
  //   "tx_ref":response.reference,
  //   "status":"completed",
  // });
  // }else{

  // }
  // }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }
}

SeerbitButton() {}

Paysuccess() {
  SnackBar(
    content: Text('Payment Successful'),
  );
}

Payfailure() {
  SnackBar(
    content: Text('Payment Cancelled'),
  );
}

PayloadModel payload = PayloadModel(
    currency: 'NGN',
    email: "hello@gmail.com",
    description: "Avon Payment",
    fullName: "Mac Kingsley",
    country: "NG",
    amount: "10000",
    transRef: Random().nextInt(5000200).toString(),
    callbackUrl: "callbackUrl",
    publicKey: "SBPUBK_KHPQZMH6NOILGOYVN4HOEIXMC7BBRHAU",
    pocketRef: "",
    vendorId: "Freedah",
    closeOnSuccess: false,
    closePrompt: false,
    setAmountByCustomer: false,
    customization: CustomizationModel(
      borderColor: "#000000",
      backgroundColor: "#004C64",
      buttonColor: "#0084A0",
      paymentMethod: [PayChannel.account, PayChannel.transfer],
      confetti: false,
      logo: "logo_url || base64",
    ));
