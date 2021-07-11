class CardInfo {
  String cardNumber;
  String name;
  String validate;
  String cvv;

  CardInfo({required this.cardNumber, required this.name, required this.validate, required this.cvv});

  @override
  String toString() {
    return "cardNumber=$cardNumber, name=$name, validate=$validate, cvv=$cvv";
  }
}
