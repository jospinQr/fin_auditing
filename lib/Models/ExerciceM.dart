class ExerciceM{

  final String annee;

  ExerciceM({required this.annee});

  factory ExerciceM.fromjson(Map<String,dynamic> json){
   return ExerciceM(annee: json['']);
  }

}