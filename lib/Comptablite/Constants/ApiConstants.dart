class ApiConstants{

  static const String exerciceEndPoint = '/view/Exercice.php';

  //pour le journal brouillar et chronologique
  static const String Journalgroupagence =
      '/view/Journal/Journalgroupagence.php?';
  static const String Journalgroupsite = '/view/Journal/groupsitesansanne.php?';
  static const String Journaldateop = '/view/Journal/journalgroupdatesite.php?';
  static const String Journaloperation = '/view/Journal/journaloperation.php?';
  static const String journal = '/view/Journal/journal.php?';

  //pour d'autre type de journal
  static const String journalgroupagencetypeora =
      '/view/Journal/journalgroupagencetypeora.php?';
  static const String journalgroupsiteType =
      '/view/Journal/journalgroupsiteType.php?';
  static const String journaldateopType =
      '/view/Journal/journaldateopType.php?';
  static const String jounrnaloprationtype =
      '/view/Journal/jounrnaloprationtype.php?';

  //pour les totaux chrono et brouillard

  static const String journalTotalAgence = '/view/Journal/totalAgence.php?';
  static const String journalTotalSite = '/view/Journal/totalSite.php?';
  static const String journalTotalDate = '/view/Journal/totalDate.php?';

  //pour les totaux type de joural

  static const String journalTotalAgenceType =
      "/view/Journal/totalAgenceType.php?";
  static const String journalTotalSiteType = '/view/Journal/totalSiteType.php?';
  static const String journalTotalDateType = '/view/Journal/totalDateType.php?';


  //**************************************************//
  //**************************BILAN************/
//***************************************************//

  static const String bilanAgence="/view/Bilan/agenceBilan.php?";
  static const String bilanMass="/view/Bilan/massBilan.php?";
  static const String bilanSousMassPrincip="/view/Bilan/sousMassPrincipBilan.php?";
  static const String bilanSousMass="/view/Bilan/sousMassBilan.php?";
  static const String bilanNature="/view/Bilan/natureBilan.php?";
  static const String bilanCompte="/view/Bilan/compteBilan.php?";

//**************************************************//
//***********************Grand livre************/
//***************************************************//

  static const String grandLivreAgence="/view/GrandLivre/agence.php?";
  static const String grandLivreAgenceType="/view/GrandLivre/agenceType.php?";
  static const String grandLivreSite="/view/GrandLivre/site.php?";
  static const String grandLivreSiteType="/view/GrandLivre/siteType.php?";
  static const String grandLivreOperation="/view/GrandLivre/operation.php?";
  static const String grandLivreOperationType="/view/GrandLivre/operationType.php?";
  static const String grandLivreComptePatri="/view/GrandLivre/comptePatrimoine.php?";
  static const String grandLivreCompteType="/view/GrandLivre/compteType.php?";
  static const String grandLivreCompteExploit="/view/GrandLivre/compteExploitation.php?";
  static const String grandLivreCompteSolde="/view/GrandLivre/sommeCompte.php?";
  static const String grandLivreAgenceSolde="/view/GrandLivre/sommeAgence.php?";
  static const String grandLivreSiteSolde="/view/GrandLivre/sommeSite.php?";
}