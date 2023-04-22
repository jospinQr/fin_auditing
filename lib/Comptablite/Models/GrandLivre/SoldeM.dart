class SoldeM{
  final String debit;
  final String credit;
  final String solde;



  String get getdebit=>debit;
  String get getdeC=>credit;
  SoldeM({
    required this.debit,
    required this.credit,
    required this.solde,

  });

  factory SoldeM.fromjson(Map<String, dynamic> json) {
    return SoldeM(
      debit: json['mntd'],
      credit: json['mntcr'],
      solde: json['solde'],
    );
  }
}