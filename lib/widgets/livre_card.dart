import 'package:flutter/material.dart';

import '../models/livre.dart';

class LivreCard extends StatelessWidget {
  final Livre livre;
  final VoidCallback? onTap;

  const LivreCard({super.key, required this.livre, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: livre.couleur,
          child: Text(
            livre.titre[0],
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(livre.titre),
        subtitle: Text('${livre.auteur} – ${livre.annee}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(livre.note.toStringAsFixed(1)),
            const Icon(Icons.star, color: Colors.amber),
            if (livre.favori) const Icon(Icons.favorite, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
