class Member {
  String name;

  Member(this.name);

  void showMember() {
    print('Member: $name');
  }
}

class PremiumMember extends Member {
  PremiumMember(String name) : super(name);

  void showPremium() {
    print('$name is a Premium Member.');
  }
}
