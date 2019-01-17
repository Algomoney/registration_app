import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../models/registeration_model.dart';

class RegisterApi {
  final String url =
      'https://flutter-registration-app.azurewebsites.net/api/RegisterAppFunction?code=7fwup7//Nvkz3D0jiLi9hNDkZe4ZGGu96ZIvdSpqWbZaWZNuWyqz0A==';
  Client _client = Client();

  Future<RegistrationModel> getRegistrationRecord() async {
    final response = await _client.get(url);
    final record = json.decode(response.body);
    print('Response from GET: $record');
    return RegistrationModel.fromJson(record);
  }

  Future<String> postRegistrationRecord(RegistrationModel model) async {
    final record = json.encode(model.toJson());
    final response = await _client.post(url, body: record);
//    print('Status code from POST: ${response.statusCode}');
//    print('Response body from POST: ${response.body}');

    return response.body;
  }
}
