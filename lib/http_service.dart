import 'dart:convert';
import 'package:http/http.dart' as http;
import 'post_model.dart';

class HttpService {
  static const String baseUrl = "https://equran.id/api/v2/surat";

  Future<List<Surah>> getSurah() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final surahList = json['data'] as List;
      return surahList.map((e) => Surah.fromJson(e)).toList();
    }
    throw Exception("Failed to load surah");
  }
}