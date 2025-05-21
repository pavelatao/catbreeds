import 'dart:convert';
import 'package:catbreeds/modules/home/domain/models/cat.dart';
import 'package:catbreeds/modules/home/infrastructure/cat_repository.dart';
import 'package:http/http.dart' as http;

class TheCatApiRepository extends CatRepository {
  final String _baseUrl = "https://api.thecatapi.com/v1/images/search";
  final String _apiKey = "live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr";
  final String _defaultBreedId = "beng";

  @override
  Future<List<Cat>> fetchCats(String? breedId) async {
    final queryParameters = {'limit': '10', 'api_key': _apiKey, 'breed_ids': breedId ?? _defaultBreedId};

    final uri = Uri.parse(_baseUrl).replace(queryParameters: queryParameters);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Cat.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener los gatos: ${response.statusCode}');
    }
  }
}
