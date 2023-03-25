class Agence {
  final String codAge;
  final String desinAge;

  const Agence({required this.codAge, required this.desinAge});

  factory Agence.fromjson(Map<String, dynamic> json) {
    return Agence(
      codAge: json['codag'],
      desinAge: json['designag'],
    );
  }
}
