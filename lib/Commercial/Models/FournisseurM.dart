class FournisseurM{
  final String   numFourni;
  final String  nomFourni;
  final String  villeFourni;
  final String   numtelFourni;
  final String  emailFourni;



  const  FournisseurM({
    required this.numFourni,
    required this.nomFourni,
    required this.villeFourni,
    required this.numtelFourni,
    required this.emailFourni,


  });

  factory  FournisseurM.fromjson(Map<String,dynamic> json){
    return  FournisseurM(
      numFourni:json['numfourn'],
      nomFourni : json['nomfourn'],
      villeFourni:json['villefourn'],
      numtelFourni:json['numtelfourn'],
      emailFourni:json['emailfourn'],

    );
  }
}