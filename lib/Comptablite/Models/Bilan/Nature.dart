class Nature {
  final String designation;
  final String SoldN;
  final String SoldN1;

  Nature({
    required this.designation,
    required this.SoldN,
    required this.SoldN1,
  });

  factory Nature.fromjson(Map<String, dynamic> json) {
    return Nature(
      designation: json['naturecpte'],
      SoldN: json['solden'],
      SoldN1: json['solden_1'],
    );
  }
}
