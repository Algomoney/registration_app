import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../models/registeration_model.dart';

class RegisterApi {
  final String url = '';
  Client _client = Client();

  Future<RegistrationModel> getRegistrationRecord() async {
    final response = await _client.get(url);
    final record = json.decode(response.body);
    return RegistrationModel.fromJson(record);
  }

  Future<String> postRegistrationRecord(RegistrationModel model) async {
    final record = json.encode(model.toJson());
    final response = await _client.post(url, body: record);

    return response.body;
  }
}
