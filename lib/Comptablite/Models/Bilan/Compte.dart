class Compte{

  final String numCompte;
  final String intituleCompte;
  final String SoldN;
  final String SoldN1;

 Compte({
    required this.numCompte,
    required this.intituleCompte,
    required this.SoldN,
    required this.SoldN1,
  });

  factory Compte.fromjson(Map<String, dynamic> json) {
    return Compte(
      numCompte: json['codsousmas'],
      intituleCompte: json['intituleCompte;'],
      SoldN: json['solden'],
      SoldN1: json['solden_1'],
    );
  }

}