class ApiConstants {
  static const String severUrl = 'http://192.168.43.163';
  static const String baseUrl = '$severUrl/FinAuditing-Web/api';
  static const String imageUrl = '/FinAuditing-Web/img/Bd_Images/';
  static const String userEndPoint = '/user';
  static const String articleEndPoint = '/view/ArticleView.php';
  static const String articleCountEndPoint = '/view/ArticleConuntView.php';
  static const String loginEndPoint = '/Controller/LoginAPi.php';
  static const String compteEndPoint = '/Controller/CompteAPI.php/';
  static const String clientEndPoint = '/view/ClientView.php';
  static const String agenceEndPoint = '/view/AgenceView.php';
  static const String siteEndPoint = '/view/SiteView.php';

  //pour le journal chronologique
  static const String Journalgroupagence =
      '/view/JournalChronologique/Journalgroupagence.php';
  static const String Journalgroupsite =
      '/view/JournalChronologique/groupsitesansanne.php?';
  static const String Journaldateop =
      '/view/JournalChronologique/journalgroupdatesite.php?';
  static const String Journaloperation =
      '/view/JournalChronologique/journaloperation.php?';
  static const String journalChrono =
      '/view/JournalChronologique/journalChrono.php?';

  //pour le journal chronologique
  static const String JournalBrouillardgroupsite =
      '/view/JournalBrouillard/groupsitesansanne.php?';
  static const String JournalBrouillarddateop =
      '/view/JournalBrouillard/journalgroupdatesite.php?';
  static const String JournalBrouillardoperation =
      '/view/JournalBrouillard/journaloperation.php?';
  static const String journalBrouillard =
      '/view/JournalBrouillard/journalBrouillard.php?';


}
