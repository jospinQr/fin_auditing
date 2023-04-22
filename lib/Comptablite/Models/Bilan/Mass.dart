class Mass {
  final String codeMass;
  final String intitule;
  final String SoldN;
  final String SoldN1;

  Mass({
    required this.codeMass,
    required this.intitule,
    required this.SoldN,
    required this.SoldN1,
  });

  factory Mass.fromjson(Map<String, dynamic> json) {
    return Mass(
      codeMass: json['codmas'],
      intitule: json['intitulemas'],
      SoldN: json['solden'],
      SoldN1: json['solden_1'],
    );
  }
}
