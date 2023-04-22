class ClientM{
  final String   numcli;
  final String  nomcli;
  final String  villecli;
  final String   numtelcli;
  final String  emailcli;
  final String   agence;


  const ClientM({
    required this.numcli,
    required this.nomcli,
    required this.villecli,
    required this.numtelcli,
    required this.emailcli,
    required this.agence,

});

  factory ClientM.fromjson(Map<String,dynamic> json){
     return ClientM(
         numcli:json['numcli'],
         nomcli : json['nomcli'],
         villecli:json['villecli'],
         numtelcli:json['numtelcli'],
         emailcli:json['emailcli'],
         agence:json['designag'],
         );
  }
}