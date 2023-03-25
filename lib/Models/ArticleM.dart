class Article {
 

  final String numart;
	final String designart; 
	final String obstva ;
	final String photo;
	final String unitppal;
	final String valunitppal;
	final String  sunit1;
	final String valsunit1; 
	final String sunit2;
	final String valsunit2 ;
	final String sunit3;
	final String valsunit3;
  final String numcatart; 

  const Article(
      {required this.numart,
      required this.designart,
      required this.obstva,
      required this.photo,
      required this.unitppal,
       required this.valunitppal,
      required this.sunit1,
      required this.valsunit1,
      required this.sunit2,
      required this.valsunit2,
      required this.sunit3,
      required this.valsunit3,
      required this.numcatart
      
      });

  factory Article.fromjson(Map<dynamic, dynamic> json) {
    return Article(
      numart: json['numart'],
      designart: json['designart'],
      obstva: json['obstva'],
      photo: json['photo'],
      unitppal: json['unitppal'],
      valunitppal: json['valunitppal'],
      sunit1: json['sunit1'],
      valsunit1: json['valsunit1'],
      sunit2: json['sunit2'],
      valsunit2: json['valsunit2:'],
      sunit3: json['sunit3'],
      valsunit3: json['valsunit3'],
      numcatart: json['numcatart'],

    );
  }

}
