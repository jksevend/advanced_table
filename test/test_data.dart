class TestData {
  String valueOne;
  String valueTwo;

  TestData({required this.valueOne, required this.valueTwo});

  Map<String, dynamic> toJson() => {'valueOne': valueOne, 'valueTwo': valueTwo};
}

class TestDataNoToJson {
  String valueOne;
  String valueTwo;

  TestDataNoToJson({required this.valueOne, required this.valueTwo});
}
