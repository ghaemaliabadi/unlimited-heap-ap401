class Company {
  Company(this.name);
  final String name;
  String get logo {
    Map<String, String> addresses = {
      'ماهان': 'assets/images/mahan.png',
      'کارون': 'assets/images/karoon.png',
      'زاگرس': 'assets/images/zagros.png',
      'وارش': 'assets/images/varesh.png',
    };
    return 'assets/images/${addresses[name]}.png';
  }
}