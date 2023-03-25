import 'package:fin_auditing/Models/Site.dart';

class SiteJM {
  final String codsite;
  final String designsite;

  SiteJM({
    required this.codsite,
    required this.designsite,
  });

  factory SiteJM.fromjson(Map<String, dynamic> json) {
    return SiteJM(
      codsite: json['codsite'],
      designsite: json['designsite'],
    );
  }


}
