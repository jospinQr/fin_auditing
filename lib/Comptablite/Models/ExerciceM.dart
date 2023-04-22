class ExerciceM {
  final String annee;
  final String dateDebut;
  final String DateFin;

  ExerciceM({
    required this.annee,
    required this.dateDebut,
    required this.DateFin,
  });

  factory ExerciceM.fromjson(Map<String, dynamic> json) {
    return ExerciceM(
      annee: json['codan'],
      dateDebut: json['datedeban'],
      DateFin: json['datefinan'],
    );
  }
}


