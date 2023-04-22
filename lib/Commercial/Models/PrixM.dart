class PrixM {
  final String numart;
  final String designart;
  final String obstva;
  final String unitppal;
  final String prixunitppal;
  final String sunit1;
  final String prixsunit1;
  final String sunit2;
  final String prixsunit2;
  final String sunit3;
  final String prixsunit3;

  PrixM({
    required this.numart,
    required this.designart,
    required this.obstva,
    required this.unitppal,
    required this.prixunitppal,
    required this.sunit1,
    required this.prixsunit1,
    required this.sunit2,
    required this.prixsunit2,
    required this.sunit3,
    required this.prixsunit3
  });


  factory PrixM.fromjson(Map<String, dynamic> json){
    return PrixM(
      numart: json['numart'],
      designart: json['designart'],
      obstva: json[' obstva'],
      unitppal: json['unitppal'],
      prixunitppal: json['prixunitppal'],
      sunit1:json ['sunit1'],
      prixsunit1: json ['prixsunit1'],
      sunit2: json ['sunit2'],
      prixsunit2: json ['prixsunit2'],
      sunit3: json ['sunit3'],
      prixsunit3: json ['prixsunit3'],);
  }
}
