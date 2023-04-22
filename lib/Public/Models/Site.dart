class Site {
  final String codsite;
  final String designsite;
  final String typesite;
  final String adressite;
  final String numtelsite;
  final String emailsite;
  final String codag;

  const Site({
    required this.codsite,
    required this.designsite,
    required this.typesite,
    required this.adressite,
    required this.numtelsite,
    required this.emailsite,
    required this.codag
  });

  factory Site.fromjson(Map<String, dynamic> json) {
    return Site(
        codsite: json['codsite'],
        designsite: json['designsite'],
        typesite: json['typesite'],
        adressite: json['adressite'],
        numtelsite: json['numtelsite'],
        emailsite: json['emailsite'],
        codag: json['codag'],
    );
  }
}
