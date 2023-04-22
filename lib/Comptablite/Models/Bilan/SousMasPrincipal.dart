class SousMassPrincipal {
  final String codeSousMassPrincip;
  final String intitule;
  final String SoldN;
  final String SoldN1;

  SousMassPrincipal({
    required this.codeSousMassPrincip,
    required this.intitule,
    required this.SoldN,
    required this.SoldN1,
  });

  factory SousMassPrincipal.fromjson(Map<String, dynamic> json) {
    return SousMassPrincipal(
      codeSousMassPrincip: json['codsousmasppal'],
      intitule: json['intitulesousmasppal'],
      SoldN: json['solden'],
      SoldN1: json['solden_1'],
    );
  }
}
