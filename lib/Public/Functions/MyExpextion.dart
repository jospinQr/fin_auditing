class PackageRecupererException{


   final String packageName;
   final int? statusCode;

   PackageRecupererException({ required this.packageName, this.statusCode});
}