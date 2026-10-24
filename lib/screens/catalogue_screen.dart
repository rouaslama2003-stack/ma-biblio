import 'package:flutter/material.dart';

import '../models/livre.dart';
import '../widgets/livre_card.dart';
import 'detail_screen.dart';

class CatalogueScreen extends StatelessWidget {
  final List<Livre> livres;

  const CatalogueScreen({super.key, required this.livres});

  @override
  Widget build(BuildContext context) {
    final nouveautes = livres.where((l) => l.nouveaute).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'Nouveautés',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 125,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: nouveautes.length,
            itemBuilder: (context, index) {
              final livre = nouveautes[index];

              return Container(
                width: 140,
                margin: const EdgeInsets.all(6),
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: livre.couleur,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  livre.titre,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'Tout le catalogue',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: livres.length,
            itemBuilder: (context, index) {
              final livre = livres[index];

              return LivreCard(
                livre: livre,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(livre: livre),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
