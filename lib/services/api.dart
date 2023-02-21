import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ipseekr/models/ipmodel.dart';

class ApiService {
  static const _baseUrl =
      'https://api.ipify.org/?format=json'; // substitua com sua URL de API

  Stream<dynamic> getIp() async* {
    while (true) {
      try {
        final response = await http.get(Uri.parse(_baseUrl));
        if (response.statusCode == 200) {
          final jsonData = jsonDecode(response.body);
          final ip = jsonData['ip'];
          yield ip;
        } else {
          throw Exception('Failed to load IP');
        }
      } catch (e) {
        print('Error: $e');
      }
      await Future.delayed(Duration(seconds: 1));
    }
  }
}

final ipApi = ApiService();
