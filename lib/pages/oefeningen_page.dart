import 'package:flutter/material.dart';

import '../models/oefening.dart';

class OefeningenPage extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return FutureBuilder<List<Oefening>>(
      future: OefeningService.fetch(),
      builder: (ctx, snap) {
        if (!snap.hasData) return Center(child: CircularProgressIndicator());
        return ListView(
          children: snap.data!.map((o) => ListTile(
            title: Text(o.titel),
            subtitle: Text(o.beschrijving),
            onTap: () => Navigator.pushNamed(ctx, '/prestatie', arguments: o),
          )).toList(),
        );
      },
    );
  }
}
