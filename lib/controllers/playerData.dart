class playerData {
  late String _name;
  late int _grade;
  late bool _varsity;

  var statistics = List<List>.generate(
      2, (i) => List<dynamic>.generate(6, (index) => null, growable: false),
      growable: false);
  //FH, BH, Volley, OverHead, W/L
  //1st Row = Hit/Win, 2nd Row = Miss/Loss

  playerData(String name, int grade, bool varsity) {
    this._name = name;
    this._grade = grade;
    this._varsity = varsity;
  }

  String getName() {
    return _name;
  }

  int getGrade() {
    return _grade;
  }

  bool isVarsity() {
    return _varsity;
  }

  List<List<dynamic>> getStatsList() {
    return statistics;
  }

  void changeName(String name) {
    this._name = name;
  }

  void changeGrade(int grade) {
    this._grade = grade;
  }

  void changeVarsity(bool isVarsity) {
    this._varsity = isVarsity;
  }
}
