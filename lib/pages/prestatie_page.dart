import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import '../models/oefening.dart';
import '../services/auth_service.dart';

class PrestatiePage extends StatefulWidget {
  @override
  _PrestatiePageState createState() => _PrestatiePageState();
}

class _PrestatiePageState extends State<PrestatiePage> {
  final tijdCtl = TextEditingController();
  final aantalCtl = TextEditingController();
  final lengteCtl = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext c) {
    final oef = ModalRoute.of(c)!.settings.arguments as Oefening;
    return Scaffold(
      appBar: AppBar(title: Text(oef.titel)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(children: [
            Text(oef.beschrijving),
            TextFormField(controller: tijdCtl, decoration: InputDecoration(labelText:'Tijd'), validator:(v)=>v!.isEmpty?'verplicht':null),
            TextFormField(controller: aantalCtl, decoration: InputDecoration(labelText:'Aantal')),
            TextFormField(controller: lengteCtl, decoration: InputDecoration(labelText:'Lengte')),
            ElevatedButton(child: Text('Opslaan'), onPressed: () async {
              if (!_form.currentState!.validate()) return;
              final token = await AuthService.getToken();
              final resp = await http.post(
                Uri.parse('${Config.apiUrl}/prestaties'),
                headers:{
                  'Content-Type':'application/json',
                  'Authorization':'Bearer $token',
                },
                body: jsonEncode({
                  'oefening_id': oef.id,
                  'tijd_required': tijdCtl.text,
                  'aantal': int.tryParse(aantalCtl.text) ?? 0,
                  'lengte': double.tryParse(lengteCtl.text) ?? 0.0,
                }),
              );
              if (resp.statusCode == 201) Navigator.pop(c);
              else ScaffoldMessenger.of(c).showSnackBar(SnackBar(content: Text('Fout')));
            })
          ]),
        ),
      ),
    );
  }
}
