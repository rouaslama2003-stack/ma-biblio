import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/livre.dart';

class LivreService {
  static const String _cle = 'mabiblio_livres';

  // Charger les livres sauvegardés ou le JSON initial.
  static Future<List<Livre>> chargerLivres() async {
    final prefs = await SharedPreferences.getInstance();
    final sauvegarde = prefs.getString(_cle);

    final String contenu;

    if (sauvegarde != null) {
      contenu = sauvegarde;
    } else {
      contenu = await rootBundle.loadString('assets/livres.json');
    }

    final List<dynamic> donnees = jsonDecode(contenu);

    return donnees.map((element) {
      return Livre.fromJson(element as Map<String, dynamic>);
    }).toList();
  }

  // Sauvegarder les livres et leurs états.
  static Future<void> sauvegarderLivres(List<Livre> livres) async {
    final prefs = await SharedPreferences.getInstance();

    final contenu = jsonEncode(livres.map((livre) => livre.toJson()).toList());

    await prefs.setString(_cle, contenu);
  }

  // Supprimer la sauvegarde pour revenir au JSON initial.
  static Future<void> reinitialiser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cle);
  }
}
