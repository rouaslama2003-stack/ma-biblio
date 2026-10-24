import 'package:flutter/material.dart';

import '../models/livre.dart';
import '../widgets/livre_card.dart';
import '../widgets/livre_grid_item.dart';
import 'detail_screen.dart';

class GalerieScreen extends StatefulWidget {
  final List<Livre> livres;

  const GalerieScreen({super.key, required this.livres});

  @override
  State<GalerieScreen> createState() => _GalerieScreenState();
}

class _GalerieScreenState extends State<GalerieScreen> {
  bool modeGrille = true;
  bool triDecroissant = false;

  void ouvrirDetail(Livre livre) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailScreen(livre: livre)),
    ).then((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final largeur = MediaQuery.of(context).size.width;

    final colonnes = largeur < 600
        ? 2
        : largeur < 900
        ? 3
        : 4;

    final livres = [...widget.livres];

    if (triDecroissant) {
      livres.sort((a, b) => b.note.compareTo(a.note));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Galerie'),
        actions: [
          IconButton(
            tooltip: 'Trier par note',
            icon: const Icon(Icons.sort),
            onPressed: () {
              setState(() {
                triDecroissant = !triDecroissant;
              });
            },
          ),
          IconButton(
            icon: Icon(modeGrille ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                modeGrille = !modeGrille;
              });
            },
          ),
        ],
      ),
      body: modeGrille
          ? GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: livres.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: colonnes,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final livre = livres[index];

                return LivreGridItem(
                  livre: livre,
                  onTap: () => ouvrirDetail(livre),
                );
              },
            )
          : ListView.builder(
              itemCount: livres.length,
              itemBuilder: (context, index) {
                final livre = livres[index];

                return LivreCard(
                  livre: livre,
                  onTap: () => ouvrirDetail(livre),
                );
              },
            ),
    );
  }
}
