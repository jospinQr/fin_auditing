class CompteM {
  final String numcpte;
  final String intitulecpte;
  final String naturecpte;


  CompteM({required this.numcpte,
    required this.intitulecpte,
    required this.naturecpte});

  factory CompteM.fromjson(Map<String, dynamic> json) {
    return CompteM(
        numcpte: json['numcpte'],
        intitulecpte: json['intitulecpte'],
        naturecpte: json['naturecpte']);
  }
}