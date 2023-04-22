import 'package:flutter/material.dart';

class SiteVM with ChangeNotifier {
  late String _codeSite;
  late String _designSite;

  String get getCodeSite => _codeSite;

  String get getDesignSite => _designSite;

  void setCodeSite(String codeSite) {
    _codeSite = codeSite;
  }

  void setDesignSite(String designSite) {
    _designSite = designSite;
  }
}
