class DebitCredit {
  final String debit;
  final String credit;



  String get getdebit=>debit;
  String get getdeC=>credit;
  DebitCredit({
    required this.debit,
    required this.credit,
  });

  factory DebitCredit.fromjson(Map<String, dynamic> json) {
    return DebitCredit(
      debit: json['mntd'],
      credit: json['mntcr'],
    );
  }
}
