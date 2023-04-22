class SousMass{
  final String codeSousMass;
  final String intitule;
  final String SoldN;
  final String SoldN1;

  SousMass({
    required this.codeSousMass,
    required this.intitule,
    required this.SoldN,
    required this.SoldN1,
  });

  factory SousMass.fromjson(Map<String, dynamic> json) {
    return SousMass(
      codeSousMass: json['codsousmas'],
      intitule: json['intitulesousmas'],
      SoldN: json['solden'],
      SoldN1: json['solden_1'],
    );
  }
}