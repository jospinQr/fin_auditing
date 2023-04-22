class CatArticleM {
  final String numCateg;
  final String designCateg;
  final String desCateg;

  CatArticleM({
    required this.numCateg,
    required this.designCateg,
    required this.desCateg,
  });

  factory CatArticleM.fromjson(Map<String, dynamic> json) {
    return CatArticleM(
      numCateg: json['numcatart'],
      designCateg: json[ 'designcatart'],
      desCateg: json['desccatart'],
    );
  }
}
