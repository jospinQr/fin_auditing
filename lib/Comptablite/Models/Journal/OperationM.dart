class OperationM {
  final String numopera;
  final String libopera;
  final String mntcr;
  final String mntd;

  OperationM({required this.numopera, required this.libopera,required this.mntcr,required this.mntd});

  factory OperationM.fromjson(Map<String, dynamic> json) {
    return OperationM(
      numopera: json['numopera'],
      libopera: json['libopera'],
      mntd:json['mntd'],
      mntcr:json['mntcr'],

    );
  }
}
