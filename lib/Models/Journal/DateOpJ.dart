class DateOJM {
  final String dateOperation;

  const DateOJM({required this.dateOperation});
  factory DateOJM.fromjson(Map<String,dynamic> json){
    return DateOJM(dateOperation: json['dateopera']);
  }
}
