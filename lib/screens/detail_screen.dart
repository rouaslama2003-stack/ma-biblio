import 'package:flutter/material.dart';

import '../models/livre.dart';

class DetailScreen extends StatefulWidget {
  final Livre livre;

  const DetailScreen({super.key, required this.livre});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final livre = widget.livre;

    return Scaffold(
      appBar: AppBar(title: const Text('Détail du livre')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            child: Container(
              height: 200,
              color: livre.couleur,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: Text(
                livre.titre,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Auteur'),
            subtitle: Text(livre.auteur),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Année'),
            subtitle: Text('${livre.annee}'),
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Genre'),
            subtitle: Text(livre.genre),
          ),
          OverflowBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    livre.favori = !livre.favori;
                  });
                },
                icon: Icon(
                  livre.favori ? Icons.favorite : Icons.favorite_border,
                ),
                label: Text(
                  livre.favori ? 'Retirer des favoris' : 'Ajouter aux favoris',
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    livre.lu = !livre.lu;
                  });
                },
                icon: Icon(livre.lu ? Icons.check_circle : Icons.menu_book),
                label: Text(livre.lu ? 'Déjà lu' : 'Marquer comme lu'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
