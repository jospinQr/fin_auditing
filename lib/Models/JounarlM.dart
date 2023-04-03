import 'package:fin_auditing/ViewModel/Journal/JournalVM.dart';

class JournalM {


  final String codan;
  final String descan;
  final String datedeban;
  final String datefinan;
  final String numopera;
  final String dateopera;
  final String libopera;
  final String typeopera;
  final String pieceopera, obsopera, numut, nomut, posteut, codag,
      designag, codsite, designsite, adressite, numtelsite, emailsite, numcpte,
      intitulecpte, naturecpte, numclas, mntd, mntcr;

  JournalM({ required this.codan,
    required this.descan,
    required this.datedeban,
    required this.datefinan,
    required this.numopera,
    required this.dateopera,
    required this.libopera,
    required this.typeopera,
    required this.pieceopera,
    required this.obsopera,
    required this.numut,
    required this.nomut,
    required this.posteut,
    required this.codag,
    required this.designag,
    required this.codsite,
    required this.designsite,
    required this.adressite,
    required this.numtelsite,
    required this.emailsite,
    required this.numcpte,
    required this.intitulecpte,
    required this.naturecpte,
    required this.numclas,
    required this.mntd,
    required this.mntcr});

  factory JournalM.fromjson(Map<String, dynamic> json) {
    return JournalM(
      codan: json['codan'],
      descan: json['descan'],
      datedeban: json['datedeban'],
      datefinan: json['datefinan'],
      numopera: json['numopera'],
      dateopera: json['dateopera'],
      libopera: json['libopera'],
      typeopera: json['typeopera'],
      pieceopera: json['pieceopera'],
      obsopera: json['obsopera'],
      numut: json['numut'],
      nomut: json['nomut'],
      posteut: json['postut'],
      codag: json['codage'],
      designag: json['designag'],
      codsite: json['codsite'],
      designsite: json['designsite'],
      adressite: json['adressite'],
      numtelsite: json['numtelsite'],
      emailsite: json['emailsite'],
      numcpte: json['numcpte'],
      intitulecpte: json['intitulecpte'],
      naturecpte: json['naturecpte'],
      numclas: json['numclas'],
      mntd: json['mntd'],
      mntcr: json['mntcr'],

    );
  }
}