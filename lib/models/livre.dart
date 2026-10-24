import 'package:flutter/material.dart';

class Livre {
  final int id;
  final String titre;
  final String auteur;
  final String genre;
  final int annee;
  final double note;
  final Color couleur;
  final bool nouveaute;

  bool lu;
  bool favori;

  Livre({
    required this.id,
    required this.titre,
    required this.auteur,
    required this.genre,
    required this.annee,
    required this.note,
    required this.couleur,
    this.nouveaute = false,
    this.lu = false,
    this.favori = false,
  });

  factory Livre.fromJson(Map<String, dynamic> json) {
    final String hex = (json['couleur'] as String).replaceFirst('#', '');

    return Livre(
      id: json['id'] as int,
      titre: json['titre'] as String,
      auteur: json['auteur'] as String,
      genre: json['genre'] as String,
      annee: json['annee'] as int,
      note: (json['note'] as num).toDouble(),
      couleur: Color(int.parse('FF$hex', radix: 16)),
      nouveaute: json['nouveaute'] ?? false,
      lu: json['lu'] ?? false,
      favori: json['favori'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titre': titre,
      'auteur': auteur,
      'genre': genre,
      'annee': annee,
      'note': note,
      'couleur':
          '#${couleur.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
      'nouveaute': nouveaute,
      'lu': lu,
      'favori': favori,
    };
  }
}
