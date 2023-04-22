class StockAlertM {
  final String numart;
  final String designart;
  final String stockalertunitppal;
  final String unitppal;
  final String stockalertsunit1;
  final String sunit1;
  final String stockalertsunit2;
  final String sunit2;
  final String stockalertsunit3;
  final String sunit3;

  StockAlertM(
      {required this.numart,
      required this.designart,
      required this.stockalertunitppal,
      required this.unitppal,
      required this.stockalertsunit1,
      required this.sunit1,
      required this.stockalertsunit2,
      required this.sunit2,
      required this.stockalertsunit3,
      required this.sunit3});

  factory StockAlertM.fromjson(Map<String, dynamic> json) {
    return StockAlertM(
        numart: json['numart'],
        designart: json['designart'],
        stockalertunitppal: json['stockalertunitppal'],
        unitppal: json['unitppal'],
        stockalertsunit1: json['stockalertsunit1'],
        sunit1: json['stockalertsunit1'],
        stockalertsunit2: json['stockalertsunit2'],
        sunit2: json['sunit2'],
        stockalertsunit3: json['stockalertsunit3'],
        sunit3: json['sunit3']);
  }
}
