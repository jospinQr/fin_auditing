class Compte {
  final String numcpte;
  final String intitulecpte;
  final String naturecpte;
  final String numclas;
  final String codsousmas;

  const Compte(
      {required this.numcpte,
      required this.intitulecpte,
      required this.naturecpte,
      required this.numclas,
      required this.codsousmas});

  factory Compte.fromjson(Map<String, dynamic> json) {
    return Compte(
      
        numcpte: json['numcpte'],
        intitulecpte: json['intitulecpte'],
        naturecpte: json['naturecpte'],
        numclas: json['numclas'],
        codsousmas: json['codsousmas']
        
        );
  }
}
