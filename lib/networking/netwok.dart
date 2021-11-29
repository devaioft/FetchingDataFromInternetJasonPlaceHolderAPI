import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:network_app/models/album_model.dart';

 
  Future<List<Album>> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

     return parseAlbum(response.body);
  }

  List<Album> parseAlbum(String responsebody) {
    final parsed = jsonDecode(responsebody).cast<Map<String, dynamic>>();
    return parsed.map<Album>((json) => Album.fromJson(json)).toList();
  }
 
