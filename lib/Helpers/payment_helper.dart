import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentHelper with ChangeNotifier {
  TimeOfDay deliveryTime = TimeOfDay.now();
  Future selectTime(BuildContext context) async {
    final selectedTime =
        await showTimePicker(context: context, initialTime: deliveryTime);
    if (selectedTime != null || selectedTime != deliveryTime) {
      deliveryTime = selectedTime!;
      log('DELIVERYTIME=====>>>>>${deliveryTime.format(context)}');
      notifyListeners();
    }
  }

  handlPaymentSuccess(
      BuildContext context, PaymentSuccessResponse paymentSuccessResponse) {
    return showResponse(context, paymentSuccessResponse.paymentId);
  }

  handlPaymentError(
      BuildContext context, PaymentFailureResponse paymentFailureResponse) {
    return showResponse(context, paymentFailureResponse.message);
  }

  handlExternalWaller(
      BuildContext context, ExternalWalletResponse externalWalletResponse) {
    return showResponse(context, externalWalletResponse.walletName);
  }

  showResponse(BuildContext context, String? response) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          width: 200,
          child: Text('the response is ${response}'),
        );
      },
    );
  }
}
