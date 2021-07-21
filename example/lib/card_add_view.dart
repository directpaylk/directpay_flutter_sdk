import 'package:flutter/material.dart';
import 'package:flutter_mpgs_sdk/directpay_card_view.dart';
import 'package:flutter_mpgs_sdk/support.dart';
import 'package:flutter_mpgs_sdk_example/main.dart';
import 'package:flutter_support_pack/flutter_support_pack.dart';

class CardAddView extends StatefulWidget {
  final int reference;

  CardAddView({Key? key, required this.reference})
      : super(key: key);

  @override
  _CardAddViewState createState() => _CardAddViewState();
}

class _CardAddViewState extends State<CardAddView> {
  static const TAG = 'Card Add View';
  String? _transactionId;
  String? _status;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () => _init());
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Add'),
      ),
      body: SafeArea(
        child: DirectPayCardInput(
          onCloseCardForm: onCloseCardForm,
          onCompleteResponse: onCompleteCardForm,
          onErrorCardForm: onErrorCardForm,
        ),
      ),
    );
  }

  @override
  void initState() {
    DirectPayCardInput.init(MyApp.merchantId, MyApp.environment);
    super.initState();
  }

  void onCloseCardForm() {
    Navigator.pop<Map<String, dynamic>>(
        context, {'status': _status, 'transaction_id': _transactionId});
  }

  void onErrorCardForm(String? error, String? description) {
    print('$error - $description references: onErrorCardForm');
  }

  void onCompleteCardForm(
      String? status, String? transactionId, String? description) {
    Log.d(TAG,
        'Status:$status - TransactionId:$transactionId - Description:$description',
        references: ["onCompleteCardForm"]);
    _status = status;
    _transactionId = transactionId;
  }

  void _init() {
    var _cardAction = CardAction.CARD_ADD;
    var _cardData = CardData.add(
      currency: PayCurrency.LKR,
      reference: widget.reference.toString(),
    );
    DirectPayCardInput.start(_cardAction, _cardData);
  }

  @override
  void dispose() {
    print("Card Add View Disposed");
    super.dispose();
  }
}