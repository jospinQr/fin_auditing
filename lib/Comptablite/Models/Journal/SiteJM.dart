import 'package:fin_auditing/Public/Models/Site.dart';

class SiteJM {
  final String codsite;
  final String designsite;
  final String codag;

  SiteJM({
    required this.codsite,
    required this.designsite,
    required this.codag,
  });

  factory SiteJM.fromjson(Map<String, dynamic> json) {
    return SiteJM(
      codsite: json['codsite'],
      designsite: json['designsite'],
      codag: json['codag'],
    );
  }


}
