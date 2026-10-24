import 'package:flutter/material.dart';

import 'models/livre.dart';
import 'services/livre_service.dart';
import 'screens/catalogue_screen.dart';
import 'screens/galerie_screen.dart';
import 'screens/ma_liste_screen.dart';
import 'screens/parametres_screen.dart';

void main() {
  runApp(const MaBiblioApp());
}

class MaBiblioApp extends StatelessWidget {
  const MaBiblioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaBiblio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  late Future<List<Livre>> futurLivres;

  @override
  void initState() {
    super.initState();
    futurLivres = LivreService.chargerLivres();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Livre>>(
      future: futurLivres,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                'Erreur de chargement : ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        final livres = snapshot.data!;

        final ecrans = [
          CatalogueScreen(livres: livres),
          GalerieScreen(livres: livres),
          MaListeScreen(livres: livres),
        ];

        return Scaffold(
          appBar: AppBar(
            title: const Text('MaBiblio'),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ParametresScreen()),
                  );

                  if (mounted) setState(() {});
                },
              ),
            ],
          ),
          body: ecrans[index],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            type: BottomNavigationBarType.fixed,
            onTap: (nouvelIndex) {
              setState(() {
                index = nouvelIndex;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Catalogue',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_on),
                label: 'Galerie',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.checklist),
                label: 'Ma liste',
              ),
            ],
          ),
        );
      },
    );
  }
}
