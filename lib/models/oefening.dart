import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config.dart';
import '../services/auth_service.dart';

class Oefening {
  final int id;
  final String titel, beschrijving;

  Oefening.fromJson(Map j)
      : id = j['id'], titel = j['titel'], beschrijving = j['beschrijving'];
}

class OefeningService {
  static Future<List<Oefening>> fetch() async {
    final token = await AuthService.getToken();
    final resp = await http.get(
      Uri.parse('${Config.apiUrl}/oefeningen'),
      headers: {'Authorization': 'Bearer $token'},
    );
    final list = jsonDecode(resp.body) as List;
    return list.map((j) => Oefening.fromJson(j)).toList();
  }
}
