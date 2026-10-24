import 'package:flutter/material.dart';

import '../models/livre.dart';
import '../services/livre_service.dart';

class MaListeScreen extends StatefulWidget {
  final List<Livre> livres;

  const MaListeScreen({super.key, required this.livres});

  @override
  State<MaListeScreen> createState() => _MaListeScreenState();
}

class _MaListeScreenState extends State<MaListeScreen> {
  bool nouveautesSeulement = false;

  final Map<String, bool> genres = {
    'Roman': true,
    'Science': true,
    'Histoire': true,
    'Jeunesse': true,
    'Informatique': true,
  };

  Future<void> enregistrer() async {
    await LivreService.sauvegarderLivres(widget.livres);
  }

  @override
  Widget build(BuildContext context) {
    final livresFiltres = widget.livres.where((livre) {
      return genres[livre.genre] == true &&
          (!nouveautesSeulement || livre.nouveaute);
    }).toList();

    final tous = genres.values.every((v) => v);
    final aucun = genres.values.every((v) => !v);

    final lus = livresFiltres.where((l) => l.lu).length;

    return Scaffold(
      appBar: AppBar(title: Text('Lus : $lus / ${livresFiltres.length}')),
      body: Column(
        children: [
          CheckboxListTile(
            title: const Text('Afficher uniquement les nouveautés'),
            value: nouveautesSeulement,
            onChanged: (value) {
              setState(() {
                nouveautesSeulement = value ?? false;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Tous les genres'),
            tristate: true,
            value: tous
                ? true
                : aucun
                ? false
                : null,
            onChanged: (value) {
              setState(() {
                final cocher = value != true;
                genres.updateAll((key, old) => cocher);
              });
            },
          ),
          ...genres.keys.map((genre) {
            final nombre = widget.livres.where((l) => l.genre == genre).length;

            IconData icone;

            switch (genre) {
              case 'Science':
                icone = Icons.science;
                break;
              case 'Informatique':
                icone = Icons.computer;
                break;
              case 'Histoire':
                icone = Icons.history_edu;
                break;
              case 'Jeunesse':
                icone = Icons.child_care;
                break;
              default:
                icone = Icons.menu_book;
            }

            return CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              secondary: Icon(icone),
              title: Text(genre),
              subtitle: Text('$nombre livres'),
              value: genres[genre],
              activeColor: Colors.blue,
              onChanged: (value) {
                setState(() {
                  genres[genre] = value ?? false;
                });
              },
            );
          }),
          const Divider(),
          Expanded(
            child: ListView.separated(
              itemCount: livresFiltres.length,
              separatorBuilder: (_, __) => const Divider(indent: 60),
              itemBuilder: (context, index) {
                final livre = livresFiltres[index];

                return CheckboxListTile(
                  value: livre.lu,
                  secondary: CircleAvatar(
                    backgroundColor: livre.couleur,
                    child: const Icon(Icons.menu_book, color: Colors.white),
                  ),
                  title: Text(
                    livre.titre,
                    style: TextStyle(
                      decoration: livre.lu
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: Text(livre.auteur),
                  onChanged: (value) async {
                    setState(() {
                      livre.lu = value ?? false;
                    });

                    await enregistrer();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
