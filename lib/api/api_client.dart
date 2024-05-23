import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  static const String _baseUrl = 'https://eightballapi.com/api';

  Future<String> fetch8BallResponse() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['reading'];
    } else {
      throw Exception('Error fetching response');
    }
  }
}
