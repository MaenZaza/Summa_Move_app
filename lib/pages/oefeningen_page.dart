import 'package:flutter/material.dart';
import '../models/oefening.dart';
// import '../services/oefening_service.dart';  // Belangrijk: import toevoegen

class OefeningenPage extends StatelessWidget {
  const OefeningenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Oefeningen')),
      body: FutureBuilder<List<Oefening>>(
        future: OefeningService.fetch(),
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Fout: ${snap.error}'));
          }
          final list = snap.data;
          if (list == null || list.isEmpty) {
            return const Center(child: Text('Geen oefeningen gevonden'));
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (ctx, i) {
              final oef = list[i];
              return ListTile(
                title: Text(oef.titel),
                subtitle: Text(oef.beschrijving),
                onTap: () {
                  Navigator.pushNamed(context, '/prestatie', arguments: oef);
                },
              );
            },
          );
        },
      ),
    );
  }
}
