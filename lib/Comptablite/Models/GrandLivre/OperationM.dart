class GrandLivreM {

  final String numOpera;
  final String libeleOpera;
  final String pieceOpera;
  final String mntcr;
  final String mntd;
  final String sold;
  final String dateOpera;


  GrandLivreM(
      {required this.numOpera, required this.libeleOpera, required this.pieceOpera, required this.mntcr,
        required this.mntd,required this.sold, required this.dateOpera});

  factory GrandLivreM.fromjson(Map<String, dynamic> json){
    return GrandLivreM(numOpera: json['numopera'],
        libeleOpera: json['libopera'],
        pieceOpera: json['pieceopera'],
        mntcr: json['mntcr'],
        mntd: json['mntd'],
        sold: json['solde'],
        dateOpera: json['dateopera']);
  }
}