import 'package:flutter/material.dart';

import 'card_add_form.dart';
import 'controllers/parameters.dart';
import 'support.dart';

class DirectPayCardInput extends StatefulWidget{

  static GlobalKey<_DirectPayCardState> _myKey = GlobalKey();

  final directPayOnCloseHandler onCloseCardForm; // Triggers when card form is closed
  final directPayOnErrorHandler onErrorCardForm; // Triggers when card form has errors
  final directPayOnCompleteHandler
  onCompleteResponse; // Triggers when transaction reaches end of cycle

  DirectPayCardInput({required this.onCloseCardForm,
    required this.onCompleteResponse,
    required this.onErrorCardForm}):super(key:_myKey);

  static init(String merchantId, Environment environment,
      {bool debug = false}) {

    if(merchantId == "DP00000")throw new Exception("Invalid Merchant ID, Please Specify Your Merchant ID");

    StaticEntry.merchantId = merchantId;
    switch (environment) {
      case Environment.LIVE:
        StaticEntry.STAGE = Env.PROD;
        break;
      case Environment.SANDBOX:
        StaticEntry.STAGE = Env.DEV;
        break;
    }
    StaticEntry.IS_DEV = debug;
  }


  static start(CardAction action, CardData payment) {
    _myKey.currentState!.start(action, payment);
  }

  static close() {
    _myKey.currentState!.close();
  }

  @override
  createState() => _DirectPayCardState();

}

class _DirectPayCardState extends State<DirectPayCardInput>{

  bool _visible = false;
  CardAction? _action;
  CardData? _payment;

  void start(CardAction action, CardData payment) {
    if(_visible && this.mounted){
      setState(() {
        close();
      });
    }
    setState(() {
      _action = action;
      _payment = payment;
      _visible = true;
    });
  }

  close() {
    setState(() {
      _visible = false;
      _action = null;
      _payment = null;
    });
    widget.onCloseCardForm();
  }

  @override
  Widget build(BuildContext context) {
    if(_visible){
      return CardAddForm(onCloseCardForm: close,onErrorCardForm: widget.onErrorCardForm,onTransactionCompleteResponse: widget.onCompleteResponse,payment: _payment,action: _action,);
    }else{
      return Container();
    }
  }

}


